use utf8;
package RisingWorld::DB::Result::Player;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::Player

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Player>

=cut

__PACKAGE__->table("Player");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

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

=head2 group

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 onlinetime

  data_type: 'integer'
  is_nullable: 1

=head2 lasttimeonline

  data_type: 'bigint'
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

=head2 brokenbones

  data_type: 'tinyint'
  is_nullable: 1

=head2 dead

  data_type: 'tinyint'
  is_nullable: 1

=head2 fly

  data_type: 'tinyint'
  is_nullable: 1

=head2 clothing

  data_type: 'blob'
  is_nullable: 1

=head2 lastspawn

  data_type: 'integer'
  is_nullable: 1

=head2 spawnpointprimary

  data_type: 'varbinary'
  is_nullable: 1
  size: 255

=head2 spawnpointsecondary

  data_type: 'varbinary'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "position",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "rotation",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "group",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "onlinetime",
  { data_type => "integer", is_nullable => 1 },
  "lasttimeonline",
  { data_type => "bigint", is_nullable => 1 },
  "health",
  { data_type => "integer", is_nullable => 1 },
  "hunger",
  { data_type => "tinyint", is_nullable => 1 },
  "thirst",
  { data_type => "tinyint", is_nullable => 1 },
  "brokenbones",
  { data_type => "tinyint", is_nullable => 1 },
  "dead",
  { data_type => "tinyint", is_nullable => 1 },
  "fly",
  { data_type => "tinyint", is_nullable => 1 },
  "clothing",
  { data_type => "blob", is_nullable => 1 },
  "lastspawn",
  { data_type => "integer", is_nullable => 1 },
  "spawnpointprimary",
  { data_type => "varbinary", is_nullable => 1, size => 255 },
  "spawnpointsecondary",
  { data_type => "varbinary", is_nullable => 1, size => 255 },
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

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("playername", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:J7DxfmJFgA+LYe7NNh3fxw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
