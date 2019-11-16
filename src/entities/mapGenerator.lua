module(...,package.seeall)

Components = require("src.components")

function mapGenerator(cwid,wid,hei,start)
  MapGenerator =
  {
    chunks = Components.chunks(),
    chunkData = Components.chunkData(cwid,wid,hei,start),
    position = Components.position(0,0),
    spriteMap = Components.spriteMap(),
    camera = nil
  }
  return MapGenerator
end
