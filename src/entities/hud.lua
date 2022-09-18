module(...,package.seeall)

Entities = require("src.utilities.entityComponentSystems").Entities
Components = require("src.components")
Button = require("src.entities.button")
--
function hud(stats)
  elements = {}
  table.insert(elements,Entities:add(playerInventoryWindow())._id)
  return playerInventoryInterface(elements)
end

--inventory menu entity
function hudWindow()
  local PlayerInventoryWindow =
  {
    _type = "HudWindow",
    interfaceVisible = Components.interfaceVisible(true),
    window = Components.window(100,100),
    screenPosition = Components.position(200,200),
  }
  return PlayerInventoryWindow
end

function playerInventoryInterface(elements)
  local PlayerInventoryInterface = {
    _type = "InventoryInterface",
    userInterface = Components.userInterface(elements,false,"inventoryToggle",false),
    interfaceVisible = Components.interfaceVisible(false),
  }
  return PlayerInventoryInterface
end

function healthBar(stats)
  local HealthBar = {

  }
  return HealthBar
}
