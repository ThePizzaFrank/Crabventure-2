module(...,package.seeall)

Components = require("src.components")

function staticTexturedCollisionMap()
  StaticCollisionMap =
  {
    collisionMap = Components.collisionMap(),
    position = Components.position(0,0),
    spriteMap = Components.spriteMap(),
    batchMap = Components.batchMap(),
    camera = nil,
    dirtyBit = Components.dirtyBit(true)
  }
  return StaticCollisionMap
end
