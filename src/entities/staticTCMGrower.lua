module(...,package.seeall)

Components = require("src.components")

function staticTCMGrower()
  StaticTCMGrower =
  {
    _type = "StaticTCMGrower",
    builder = Components.builder(),
    position = Components.position(0,0),
    spriteMap = Components.spriteMap(),
    id = Components.id(-1),
    camera = nil
  }
  return StaticTCMGrower
end
