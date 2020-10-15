module(...,package.seeall)
Filter = require("src.utilities.filter")

local filter = Filter.filter({"scrollData"})

function update(world,dy)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      sd = entity.scrollData
      newPosition = sd.scrollPosition + dy
      if sd.scrollMin ~= nil then
        newPosition = math.max(newPosition,sd.scrollMin)
      end
      if sd.scrollMax ~= nil then
        newPosition = math.min(newPosition,sd.scrollMax)
      end
      entity.scrollData.scrollPosition = newPosition
    end
  end
end
