use utf8;
package RisingWorld::DB::Result::Chunk;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::Chunk

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Chunks>

=cut

__PACKAGE__->table("Chunks");

=head1 ACCESSORS

=head2 x

  data_type: 'integer'
  is_nullable: 1

=head2 y

  data_type: 'integer'
  is_nullable: 1

=head2 z

  data_type: 'integer'
  is_nullable: 1

=head2 terrain

  data_type: 'blob'
  is_nullable: 1

=head2 blocks

  data_type: 'blob'
  is_nullable: 1

=head2 biome

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "x",
  { data_type => "integer", is_nullable => 1 },
  "y",
  { data_type => "integer", is_nullable => 1 },
  "z",
  { data_type => "integer", is_nullable => 1 },
  "terrain",
  { data_type => "blob", is_nullable => 1 },
  "blocks",
  { data_type => "blob", is_nullable => 1 },
  "biome",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uAbAnu1BoPHpREXEfwGxLw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
