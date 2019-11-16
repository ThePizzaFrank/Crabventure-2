module(...,package.seeall)

Components = require("src.components")

function staticTCMGrower()
  StaticTCMGrower =
  {
    builder = Components.builder(),
    position = Components.position(0,0),
    spriteMap = Components.spriteMap(),
    camera = nil
  }
  return StaticTCMGrower
end
