use utf8;
package RisingWorld::DB::Result::GrowingPlant;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::GrowingPlant

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<GrowingPlants>

=cut

__PACKAGE__->table("GrowingPlants");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 typeid

  data_type: 'integer'
  is_nullable: 1

=head2 chunkposx

  data_type: 'integer'
  is_nullable: 1

=head2 chunkposy

  data_type: 'integer'
  is_nullable: 1

=head2 chunkposz

  data_type: 'integer'
  is_nullable: 1

=head2 positionx

  data_type: 'integer'
  is_nullable: 1

=head2 positiony

  data_type: 'integer'
  is_nullable: 1

=head2 positionz

  data_type: 'integer'
  is_nullable: 1

=head2 rotationx

  data_type: 'integer'
  is_nullable: 1

=head2 rotationy

  data_type: 'integer'
  is_nullable: 1

=head2 rotationz

  data_type: 'integer'
  is_nullable: 1

=head2 growtime

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "typeid",
  { data_type => "integer", is_nullable => 1 },
  "chunkposx",
  { data_type => "integer", is_nullable => 1 },
  "chunkposy",
  { data_type => "integer", is_nullable => 1 },
  "chunkposz",
  { data_type => "integer", is_nullable => 1 },
  "positionx",
  { data_type => "integer", is_nullable => 1 },
  "positiony",
  { data_type => "integer", is_nullable => 1 },
  "positionz",
  { data_type => "integer", is_nullable => 1 },
  "rotationx",
  { data_type => "integer", is_nullable => 1 },
  "rotationy",
  { data_type => "integer", is_nullable => 1 },
  "rotationz",
  { data_type => "integer", is_nullable => 1 },
  "growtime",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:McUkhltKIQgeoFRIBrce2g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
