module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"position","movement","action"})

function update(entity)
  entity.position.x = entity.position.x + entity.movement.x
  entity.position.y = entity.position.y + entity.movement.y
  entity.action.turns = entity.movement.turns
  Entities:removeComponent(entity._id,"movement")
  love.event.push("gameEvent","closeAll") --not the best spot for this but it breaks collision if you put it on button inputs...
end
