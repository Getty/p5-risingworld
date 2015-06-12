#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

for (qw(
  RisingWorld
  RisingWorld::DB
  RisingWorld::DB::Result::GrowingPlant
  RisingWorld::DB::Result::Chunk
  RisingWorld::DB::Result::Chest
  RisingWorld::DB::Result::WorldInfo
  RisingWorld::DB::Result::Player
  RisingWorld::DB::Result::Inventory
  RisingWorld::DB::Result::Npc
  RisingWorld::DB::Result::Furnace
  RisingWorld::DB::Result::ChunkAddition
  RisingWorld::DB::Result::Lodchunk
  RisingWorld::DB::Result::Worldchunk
  RisingWorld::DB::Result::Banlist
)) {
  use_ok($_);
}

done_testing;

