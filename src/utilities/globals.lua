module(...,package.seeall)


tileSize = 32;
turns = 0;
currentCollider = 0;
itemId = 0;
scale = 1;
CombineChunkSystem = {}

CollisionEnum = {
  Player = 0,
  Wall = 1,
  Enemy = 2,
  Object = 3,
}
