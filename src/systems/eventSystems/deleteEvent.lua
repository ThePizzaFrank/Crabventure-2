module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"deleteEvent"})

function update(entity,event)
  local entityEvent = entity.deleteEvent.event
  if event ~= entityEvent then
    return
  end
  if entity.userInterface then
    for _,id in pairs(entity.userInterface.elements) do
      Entities:remove(id)
    end
  end
  Entities:remove(entity)
end
