use utf8;
package RisingWorld::DB::Result::Banlist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::Banlist

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Banlist>

=cut

__PACKAGE__->table("Banlist");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 playername

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 playermacaddress

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 serial

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 date

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 admin

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 duration

  data_type: 'bigint'
  is_nullable: 1

=head2 reason

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "playername",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "playermacaddress",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "serial",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "date",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "admin",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "duration",
  { data_type => "bigint", is_nullable => 1 },
  "reason",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<playername>

=over 4

=item * L</playername>

=back

=cut

__PACKAGE__->add_unique_constraint("playername", ["playername"]);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oFnPXpMPyd374bavY41DxA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
