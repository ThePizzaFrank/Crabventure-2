module(...,package.seeall)

Components = require("src.components")

function staticTexturedCollisionMap()
  MapGenerator =
  {
    chunks = Components.chunks(),
    chunkData = Components.chunkData(),
    position = Components.position(0,0),
    spriteMap = Components.spriteMap(),
    camera = nil
  }
  return StaticCollisionMap
end
