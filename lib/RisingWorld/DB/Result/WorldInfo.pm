use utf8;
package RisingWorld::DB::Result::WorldInfo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RisingWorld::DB::Result::WorldInfo

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<WorldInfos>

=cut

__PACKAGE__->table("WorldInfos");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 key

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 value

  data_type: 'varbinary'
  is_nullable: 1
  size: 800

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "key",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "value",
  { data_type => "varbinary", is_nullable => 1, size => 800 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<infokey>

=over 4

=item * L</key>

=back

=cut

__PACKAGE__->add_unique_constraint("infokey", ["key"]);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-06-08 19:18:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BXZfzY5Vd81tyZjpHQavBQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
