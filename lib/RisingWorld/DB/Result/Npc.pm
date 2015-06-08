use utf8;
package RisingWorld::DB::Result::Npc;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::Npc

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Npc>

=cut

__PACKAGE__->table("Npc");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 typeid

  data_type: 'integer'
  is_nullable: 1

=head2 variation

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 position

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 rotation

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 owner

  data_type: 'integer'
  is_nullable: 1

=head2 group

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 age

  data_type: 'integer'
  is_nullable: 1

=head2 health

  data_type: 'integer'
  is_nullable: 1

=head2 hunger

  data_type: 'tinyint'
  is_nullable: 1

=head2 thirst

  data_type: 'tinyint'
  is_nullable: 1

=head2 spawndate

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "typeid",
  { data_type => "integer", is_nullable => 1 },
  "variation",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "position",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "rotation",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "owner",
  { data_type => "integer", is_nullable => 1 },
  "group",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "age",
  { data_type => "integer", is_nullable => 1 },
  "health",
  { data_type => "integer", is_nullable => 1 },
  "hunger",
  { data_type => "tinyint", is_nullable => 1 },
  "thirst",
  { data_type => "tinyint", is_nullable => 1 },
  "spawndate",
  { data_type => "bigint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MzMD2WshHmnokXjKZfO9pA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
