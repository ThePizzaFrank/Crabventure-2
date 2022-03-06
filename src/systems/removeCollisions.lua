module(...,package.seeall)
Filter = require("src.utilities.filter")

local filter = Filter.filter({"collision"})

function update(world,dy)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      entity.collision = nil
    end
  end
end
