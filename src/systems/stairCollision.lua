module(...,package.seeall)
Filter = require("src.utilities.filter")

local filter = Filter.filter({"collision","player","position"})

function update(world,dy)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      --if entity.collision.collisionType == ''
      --go down stairs
    end
  end
end
