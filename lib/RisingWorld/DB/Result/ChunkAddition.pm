use utf8;
package RisingWorld::DB::Result::ChunkAddition;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::ChunkAddition

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<ChunkAdditions>

=cut

__PACKAGE__->table("ChunkAdditions");

=head1 ACCESSORS

=head2 x

  data_type: 'integer'
  is_nullable: 1

=head2 z

  data_type: 'integer'
  is_nullable: 1

=head2 objects

  data_type: 'blob'
  is_nullable: 1

=head2 vegetations

  data_type: 'blob'
  is_nullable: 1

=head2 constructions

  data_type: 'blob'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "x",
  { data_type => "integer", is_nullable => 1 },
  "z",
  { data_type => "integer", is_nullable => 1 },
  "objects",
  { data_type => "blob", is_nullable => 1 },
  "vegetations",
  { data_type => "blob", is_nullable => 1 },
  "constructions",
  { data_type => "blob", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:StQGyNjPkNJ4vqpkNHk4XA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
