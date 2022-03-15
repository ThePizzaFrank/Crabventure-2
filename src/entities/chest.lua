module(...,package.seeall)

Components = require("src.components")
MapGenerator = require("src.entities.mapGenerator")
Filter = require("src.utilities.filter")
globals = require("src.utilities.globals")

function chest(x,y)
  Chest = {
    _type = "Chest",
    classification = Components.classification(true),
    sprite = Components.sprite("chest"),
    position = Components.position(x,y),
    camera = camera,
    collider = Components.collider(globals.CollisionEnum.Object,"chest"),
    eventEmitter = Components.eventEmitter("openChest"),
    inventory = Components.inventory()
  }

  return Chest
end
