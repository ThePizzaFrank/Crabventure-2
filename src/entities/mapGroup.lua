module(...,package.seeall)

Components = require("src.components")

--map generator
function mapGroup()
  MapGroup =
  {
    _type = "MapGroup",
    mapIdentifier = Components.mapIdentifier(mapId),
    mapData = Components.mapData(),
    camera = Components.camera(),
  }
  return MapGroup
end
