use utf8;
package RisingWorld::DB::Result::Worldchunk;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::Worldchunk

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Worldchunks>

=cut

__PACKAGE__->table("Worldchunks");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 x

  data_type: 'integer'
  is_nullable: 1

=head2 y

  data_type: 'integer'
  is_nullable: 1

=head2 z

  data_type: 'integer'
  is_nullable: 1

=head2 info

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "x",
  { data_type => "integer", is_nullable => 1 },
  "y",
  { data_type => "integer", is_nullable => 1 },
  "z",
  { data_type => "integer", is_nullable => 1 },
  "info",
  { data_type => "varchar", is_nullable => 1, size => 64 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yvXunx0PcBf3yjmcL96KmA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
