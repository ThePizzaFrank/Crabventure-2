module(...,package.seeall)

Components = require("src.components")

--map generator
function mapGroup()
  MapGroup =
  {
    _type = "MapGroup",
    mapIdentifier = Components.mapIdentifier(mapId),
    mapData = Components.mapData(),
    classification = Components.classification(true),
    camera = Components.camera(),
  }
  return MapGroup
end
