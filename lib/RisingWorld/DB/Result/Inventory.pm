use utf8;
package RisingWorld::DB::Result::Inventory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::Inventory

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Inventory>

=cut

__PACKAGE__->table("Inventory");

=head1 ACCESSORS

=head2 playerid

  data_type: 'integer'
  is_nullable: 0

=head2 inventory

  data_type: 'blob'
  is_nullable: 1

=head2 quickslot

  data_type: 'tinyint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "playerid",
  { data_type => "integer", is_nullable => 0 },
  "inventory",
  { data_type => "blob", is_nullable => 1 },
  "quickslot",
  { data_type => "tinyint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</playerid>

=back

=cut

__PACKAGE__->set_primary_key("playerid");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NG9x8WQnZ9kETlMmP+T1Tw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
