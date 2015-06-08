use utf8;
package RisingWorld::DB::Result::Chest;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::Chest

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Chests>

=cut

__PACKAGE__->table("Chests");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 slots

  data_type: 'integer'
  is_nullable: 1

=head2 relatedobjectid

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 playerid

  data_type: 'integer'
  is_nullable: 1

=head2 creationdate

  data_type: 'bigint'
  is_nullable: 1

=head2 lastaccess

  data_type: 'bigint'
  is_nullable: 1

=head2 chest

  data_type: 'blob'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "slots",
  { data_type => "integer", is_nullable => 1 },
  "relatedobjectid",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "playerid",
  { data_type => "integer", is_nullable => 1 },
  "creationdate",
  { data_type => "bigint", is_nullable => 1 },
  "lastaccess",
  { data_type => "bigint", is_nullable => 1 },
  "chest",
  { data_type => "blob", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5x8ra/eELJxcHv6KNGSpxA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
