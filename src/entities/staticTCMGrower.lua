module(...,package.seeall)

Components = require("src.components")

function staticTCMGrower()
  StaticCollisionMap =
  {
    builder = Components.builder(),
    position = Components.position(0,0),
    spriteMap = Components.spriteMap(),
    camera = nil
  }
  return StaticCollisionMap
end
