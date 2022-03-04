module(...,package.seeall)

Components = require("src.components")

--button entity
function button(x,y,width,height,onClick,sprite,spriteHover,spritePressed,name)
  Button =
  {
    _type = "Button_"..name,
    hover = Components.hover(),
    mouseCollider = Components.mouseCollider(width,height),
    eventEmitter = Components.eventEmitter(onClick),
    screenPosition = Components.position(x,y),
    sprite = Components.sprite(sprite),
    hoverSwap = Components.spriteSwap(sprite,spriteHover),
    pressSwap = Components.spriteSwap(sprite,spritePressed),
  }
  return Button
end
