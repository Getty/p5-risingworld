package RisingWorld::Mapserver;

use MooX qw(
  Options
);

use POE qw(
  Component::Server::TCP
  Component::Server::HTTPServer
  Component::Server::HTTPServer::Handler
  Component::Server::HTTPServer::StaticHandler
  Filter::JSONMaybeXS
  Filter::Line
  Filter::Stackable
  Wheel::FollowTail
);

use Protocol::WebSocket::Handshake::Server;
use Protocol::WebSocket::Frame;

use Scalar::Util qw( blessed );
use File::ShareDir::ProjectDistDir;
use Path::Tiny;
use JSON::MaybeXS;
use HTTP::Status;
use Data::Dumper;

use RisingWorld::DB;

has ws_port => (
  is => 'ro',
  lazy => 1,
  default => sub { 4288 },
);

has port => (
  is => 'ro',
  lazy => 1,
  default => sub { 4280 },
);

has _ws_conns => (
  is => 'rw',
  lazy => 1,
  default => sub {{}},
);

has ws_server => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    POE::Component::Server::TCP->new(
      Port            => $self->ws_port,
      ClientFilter    => 'POE::Filter::Stream',
      ClientConnected => sub {
        $self->_ws_conns->{$_[SESSION]->ID} = $_[HEAP]{client};
        $_[HEAP]{hs} = Protocol::WebSocket::Handshake::Server->new;
        $_[HEAP]{frame} = Protocol::WebSocket::Frame->new;
      },
      ClientDisconnected => sub {
        delete $self->_ws_conns->{$_[SESSION]->ID};
      },
      ClientInput     => sub {
        my $chunk = $_[ARG0];
        if (!$_[HEAP]{hs}->is_done) {
          $_[HEAP]{hs}->parse($chunk);
          if ($_[HEAP]{hs}->is_done) {
            $_[HEAP]{client}->put($_[HEAP]{hs}->to_string);
          }
          return;
        }
        $_[HEAP]{frame}->append($chunk);
        while (my $message = $_[HEAP]{frame}->next) {
          $self->send_to_all($message);
        }
      },
    );
  },
);

# has web_server => (
#   is => 'ro',
#   lazy => 1,
#   default => sub {
#     my ( $self ) = @_;
#     my $web_server = POE::Component::Server::PSGI->new(
#       port => $self->port,
#     );
#     $web_server->run($self->web_app);
#     return $web_server;
#   },
# );

# has web_app => (
#   is => 'ro',
#   lazy => 1,
#   default => sub {
#     my ( $self ) = @_;
#     Plack::App::Directory->new(root => $self->web_root)->to_app;
#   },
# );

has web_server => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    my $http_server = POE::Component::Server::HTTPServer->new;
    $http_server->port($self->port);
    $http_server->handlers([
      '/' => new_handler('StaticHandler',$self->web_root),
      '/data.json' => sub { $self->data_handler(@_) },
    ]);
    $http_server->create_server();
  },
);

has web_root => (
  is => 'ro',
  lazy => 1,
  default => sub { path(dist_dir('RisingWorld'),'mapserver') },
);

has tail_session => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    return undef unless $self->has_eventlog;
    my $filter = POE::Filter::Stackable->new();
    $filter->push(
      POE::Filter::Line->new(),
      POE::Filter::JSONMaybeXS->new(),
    );
    POE::Session->create(
      inline_states => {
        _start => sub {
          $_[HEAP]{tailor} = POE::Wheel::FollowTail->new(
            Filename => $self->eventlog,
            Filter => $filter,
            InputEvent => "got_event",
            ResetEvent => "got_eventlog_rollover",
          );
        },
        got_event => sub {
          $self->got_event($_[ARG0]);
        },
        got_eventlog_rollover => sub {
          # TODO
        },
      }
    );
  },
);

option dbi => (
  is => 'ro',
  required => 1,
  format => 's',
  doc => 'DBI String',
);

option user => (
  is => 'ro',
  format => 's',
  doc => 'Username for World DB (not required for SQLite)',
);

option pass => (
  is => 'ro',
  format => 's',
  doc => 'Password for World DB (not required for SQLite)',
);

has db => (
  is => 'ro',
  lazy => 1,
  default => sub {
    my ( $self ) = @_;
    my $dbi = $self->dbi;
    my $user = $self->user;
    my $pass = $self->pass;
    my $sqlite = ( $dbi =~ /SQLite/ ) ? 1 : 0;
    RisingWorld::DB->connect('dbi:'.$dbi, $user, $pass, {
      AutoCommit => 1,
      RaiseError => 1,
      quote_char => $sqlite ? '"' : '`',
      name_sep   => '.',
    });
  },
);

option eventlog => (
  is => 'ro',
  format => 's',
  predicate => 1,
  doc => 'EventLog for WebSocket (disabled if not given)',
);

sub got_event {
  my ( $self, $event ) = @_;
  $self->send_to_all($event);
}

sub send_to_all {
  my ( $self, $message ) = @_;
  my $json;
  eval {
    $json = encode_json($message);    
  };
  if ($@) {
    warn "Error on encode of message (".(Dumper $message)."): ".$@;
    return;
  }
  my $bytes = Protocol::WebSocket::Frame->new($json)->to_bytes;
  for my $conn (values %{$self->_ws_conns}) {
    if ($conn) {
      $conn->put($bytes);
    }
  }
}

sub data_handler {
  my ($self, $context) = @_;
  $context->{response}->code(RC_OK);
  $context->{response}->content(encode_json($self->make_data));
  $context->{response}->content_type('application/json');
  return H_FINAL;
}

sub make_data {
  my ( $self ) = @_;
  my @chunks;
  my @chunks_results = $self->db->resultset('Chunk')->search(undef,{
    columns => [qw/ x y z /],
    order_by => [qw/ x z y /]
  })->all;

  for (@chunks_results) {
    push @chunks, [ $_->x+0, $_->y+0, $_->z+0 ];
  }

  my @wchunks;
  my @wchunks_results = $self->db->resultset('Worldchunk')->search(undef,{
    columns => [qw/ x z /],
    order_by => [qw/ x z /]
  })->all;

  for (@wchunks_results) {
    push @wchunks, [ $_->x+0, $_->z+0 ];
  }
  return {
    Chunks => \@chunks,
    Worldchunks => \@wchunks,
  };
}

sub BUILD {
  my ( $self ) = @_;
  $self->db;
  $self->ws_server;
  $self->tail_session;
  $self->web_server;
}

sub run {
  $_[0]->new_with_options unless blessed $_[0];
  POE::Kernel->run;
}

1;