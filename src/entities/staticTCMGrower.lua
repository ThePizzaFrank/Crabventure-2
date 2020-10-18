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
    id = Components.id(-1),
    genEntities = Components.genEntities(),
    camera = nil
  }
  return StaticTCMGrower
end
