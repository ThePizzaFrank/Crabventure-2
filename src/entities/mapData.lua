module(...,package.seeall)

Components = require("src.components")

--map generator
function mapData(chunks,floor)
  MapData =
  {
    _type = "Map",
    chunks = chunks,
    mapMetaData = Components.mapMetaData()
  }
  return MapData
end
