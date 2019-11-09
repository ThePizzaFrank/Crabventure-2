module(...,package.seeall)
Filter = require("src.utilities.filter")

local filter = Filter.filter({"player","action"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      return entity.action.turns 
    end
  end
  return 0
end
