module(...,package.seeall)

Components = require("src.components")

function staticTexturedCollisionMap()
  StaticCollisionMap =
  {
    _type = "StaticCollisionMap",
    classification = Components.classification(true),
    collisionMap = Components.collisionMap(),
    position = Components.position(0,0),
    spriteMap = Components.spriteMap(),
    batchMap = Components.batchMap(),
    mapIdentifier = Components.mapIdentifier(-1),
    camera = nil,
    dirtyBit = Components.dirtyBit(true)
  }
  return StaticCollisionMap
end
