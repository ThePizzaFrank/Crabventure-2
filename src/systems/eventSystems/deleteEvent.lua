module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"deleteEvent"})

function update(entity,event)
  entityEvent = entity.deleteEvent.event
  print(event,entityEvent)
  if event == entityEvent then
    Entities:remove(entity)
  end
end
