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
    id = Components.id(-1),
    genEntities = Components.genEntities(),
    camera = nil,
    dirtyBit = Components.dirtyBit(true)
  }
  return StaticCollisionMap
end
