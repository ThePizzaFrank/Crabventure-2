module(...,package.seeall)

Entities = require("src.utilities.entityComponentSystems").Entities
Components = require("src.components")
Button = require("src.entities.button")
--
function playerInventory()
  elements = {}
  table.insert(elements,Entities:add(playerInventoryWindow())._id)
  table.insert(elements,Entities:add(playerInventoryCloseButton())._id)
  return playerInventoryInterface(elements)
end

--inventory menu entity
function playerInventoryWindow()
  local PlayerInventoryWindow =
  {
    _type = "InventoryWindow",
    interfaceVisible = Components.interfaceVisible(false),
    window = Components.window(100,100),
    screenPosition = Components.position(200,200),
    inventory = Components.inventory(),
  }
  return PlayerInventoryWindow
end

function playerInventoryCloseButton()
  local PlayerInventoryCloseButton = Button.button(200,200,16,16,
    "inventoryToggle","close_button","close_button_hover","close_button_pressed","inventory_close")
  PlayerInventoryCloseButton.interfaceVisible = Components.interfaceVisible(false)
  return PlayerInventoryCloseButton
end

function playerInventoryInterface(elements)
  local PlayerInventoryInterface = {
    _type = "InventoryInterface",
    userInterface = Components.userInterface(elements,false,"inventoryToggle"),
    interfaceVisible = Components.interfaceVisible(false),
  }
  return PlayerInventoryInterface
end
