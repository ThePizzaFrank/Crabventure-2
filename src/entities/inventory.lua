module(...,package.seeall)

Components = require("src.components")
Button = require("src.entities.button")
--
function inventoryEntities()

end

--inventory menu entity
function inventory()
  Inventory =
  {
    _type = "Inventory",
    visible = Components.visible(false),
    toggleVisibleEvent = Components.toggleVisibleEvent("inventoryClose"),
    window = Components.window(100,100),
    screenPosition = Components.position(200,200),
    inventory = Components.inventory(),
  }
  return Inventory
end

function inventoryCloseButton()
  InventoryCloseButton = Button.button(200,200,16,16,
    "inventoryClose","close_button","close_button_hover","close_button_pressed","inventory_close")
  InventoryCloseButton.visible = Components.visible(false)
  InventoryCloseButton.toggleVisibleEvent = Components.toggleVisibleEvent("inventoryClose")
  return InventoryCloseButton
end
