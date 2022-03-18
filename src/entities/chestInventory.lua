module(...,package.seeall)
globals = require("src.utilities.globals")
Components = require("src.components")
Button = require("src.entities.button")
--
function chestMenu(chestId,inventory,camera,x,y)
  xPos = globals.tileSize*globals.scale*x-camera.x
  yPos = globals.tileSize*globals.scale*y-camera.y - 300
  event = "chestClose_"..chestId
  return {
    chestInventory(event,inventory,xPos,yPos),
    chestCloseButton(event,xPos,yPos),
  }
end

--inventory menu entity
function chestInventory(deleteEvent,inventory,xPos,yPos)
  local ChestInventory =
  {
    _type = "ChestInventory",
    deleteEvent = Components.deleteEvent(deleteEvent),
    window = Components.window(200,300),
    screenPosition = Components.position(xPos,yPos),
    inventory = inventory,
  }
  return ChestInventory
end

function chestCloseButton(deleteEvent,xPos,yPos)
  ChestCloseButton = Button.button(xPos,yPos,16,16,
    deleteEvent,"close_button","close_button_hover","close_button_pressed","chest_close")
  ChestCloseButton.deleteEvent = Components.deleteEvent(deleteEvent)
  return ChestCloseButton
end
