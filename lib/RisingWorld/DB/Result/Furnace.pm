use utf8;
package RisingWorld::DB::Result::Furnace;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::Furnace

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Furnaces>

=cut

__PACKAGE__->table("Furnaces");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 objecttypeid

  data_type: 'integer'
  is_nullable: 1

=head2 isactive

  data_type: 'tinyint'
  is_nullable: 1

=head2 items

  data_type: 'blob'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "objecttypeid",
  { data_type => "integer", is_nullable => 1 },
  "isactive",
  { data_type => "tinyint", is_nullable => 1 },
  "items",
  { data_type => "blob", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3rfQ5D22D9nsBDMi+3YybQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
