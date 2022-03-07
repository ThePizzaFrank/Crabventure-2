module(...,package.seeall)
Filter = require("src.utilities.filter")

filter = Filter.filter({"position","movement"})

function update(entity)
  entity.position.x = entity.position.x + entity.movement.x
  entity.position.y = entity.position.y + entity.movement.y
  entity.movement = nil
end
