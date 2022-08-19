module(...,package.seeall)

Components = require("src.components")
MapGenerator = require("src.entities.mapGenerator")
Entities = require("src.utilities.entityComponentSystems").Entities
Button = require("src.entities.button")
Filter = require("src.utilities.filter")
globals = require("src.utilities.globals")

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

function chestCloseButton(visibleEvent,xPos,yPos)
  local ChestCloseButton = Button.button(xPos,yPos,16,16,
    visibleEvent,"close_button","close_button_hover","close_button_pressed","chest_close")
  ChestCloseButton.interfaceVisible = Components.interfaceVisible(false)
  return ChestCloseButton
end

function chest(x,y,camera)
  local Chest = {
    _type = "Chest",
    classification = Components.classification(true),
    sprite = Components.sprite("chest"),
    position = Components.position(x,y),
    camera = camera,
    collider = Components.collider(globals.CollisionEnum.Object,"chest"),
    inventory = Components.inventory()
  }

  local chest = Entities:add(Chest)
  local elements = {}
  local event = "chestToggle_"..chest._id
  local xPos = globals.tileSize*globals.scale*10
  local yPos = globals.tileSize*globals.scale*10-300
  table.insert(elements,Entities:add(chestWindow(chest.inventory,xPos,yPos))._id)
  table.insert(elements,Entities:add(chestCloseButton(event,xPos,yPos))._id)

  chest.userInterface = Components.userInterface(elements,false,event)
  chest.eventEmitter = Components.eventEmitter(event)
  Entities:update(chest)

  return chest;
end
