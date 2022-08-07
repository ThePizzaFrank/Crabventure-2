module(...,package.seeall)
globals = require("src.utilities.globals")
Components = require("src.components")
Button = require("src.entities.button")

function chestInventory(chestId,inventory,camera,x,y)
  xPos = globals.tileSize*globals.scale*x-camera.x
  yPos = globals.tileSize*globals.scale*y-camera.y - 300
  event = "chestClose_"..chestId
  elements = {}
  table.insert(elements,Entities:add(chestWindow(inventory,xPos,yPos))._id)
  table.insert(elements,Entities:add(chestCloseButton(event,xPos,yPos))._id)
  return chestUserInterface(event,elements)
end


--inventory menu entity
function chestWindow(inventory,xPos,yPos)
  local ChestWindow =
  {
    _type = "chest_window",
    window = Components.window(200,300),
    screenPosition = Components.position(xPos,yPos),
    inventory = inventory,
    interfaceVisible = Components.interfaceVisible(false),
  }
  return ChestWindow
end



function chestUserInterface(deleteEvent,elements)
  local ChestUserInterface = {
    _type = "chest_interface",
    userInterface = Components.userInterface(elements,true),
    toggleVisibleEvent = Components.toggle(deleteEvent),
    interfaceVisible = Components.interfaceVisible(false),
  }
  return ChestUserInterface
end
