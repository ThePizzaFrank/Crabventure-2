module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"position","movement"})

function update(entity)
  entity.position.x = entity.position.x + entity.movement.x
  entity.position.y = entity.position.y + entity.movement.y
  Entities:removeComponent(entity._id,"movement")
end
