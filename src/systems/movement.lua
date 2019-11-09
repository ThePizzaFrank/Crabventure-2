module(...,package.seeall)
Filter = require("src.utilities.filter")

local filter = Filter.filter({"position","movement"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      entity.position.x = entity.position.x + entity.movement.x
      entity.position.y = entity.position.y + entity.movement.y
      entity["movement"] = nil
    end
  end
end
