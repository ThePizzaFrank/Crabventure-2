module(...,package.seeall)

Components = require("src.components")

function staticTCMGrower()
  StaticTCMGrower =
  {
    _type = "StaticTCMGrower",
    classification = Components.classification(false),
    builder = Components.builder(),
    position = Components.position(0,0),
    spriteMap = Components.spriteMap(),
    mapIdentifier = Components.mapIdentifier(-1),
    camera = nil
  }
  return StaticTCMGrower
end
