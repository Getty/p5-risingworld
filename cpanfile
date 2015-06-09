
requires 'Path::Tiny', '0';
requires 'DBIx::Class', '0';

on test => sub {
  requires 'Test::More', '0.96';
};

