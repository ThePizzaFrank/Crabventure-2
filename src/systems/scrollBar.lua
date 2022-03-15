module(...,package.seeall)
Filter = require("src.utilities.filter")


filter = Filter.filter({"scrollData"})

function update(entity,dy)
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
