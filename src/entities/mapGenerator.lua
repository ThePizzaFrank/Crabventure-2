module(...,package.seeall)

Components = require("src.components")

--map generator
function mapGenerator(cwid,wid,hei,start,mapId)
  MapGenerator =
  {
    _type = "MapGenerator",
    chunks = Components.chunks(),
    chunkData = Components.chunkData(cwid,wid,hei,start),
    position = Components.position(0,0),
    spriteMap = Components.spriteMap(),
    id = Components.id(mapId),
    camera = nil
  }
  return MapGenerator
end
