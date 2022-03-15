module(...,package.seeall)

Components = require("src.components")
MapGenerator = require("src.entities.mapGenerator")
Filter = require("src.utilities.filter")
globals = require("src.utilities.globals")

function staircase(x,y)
  Stairs = {
    _type = "Staircase",
    classification = Components.classification(true),
    sprite = Components.sprite("stairs"),
    position = Components.position(x,y),
    camera = camera,
    collider = Components.collider(globals.CollisionEnum.Object,"stair")
  }

  return Stairs
end
