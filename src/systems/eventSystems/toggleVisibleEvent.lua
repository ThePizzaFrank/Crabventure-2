module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"visible","toggleVisibleEvent"})

function update(entity,event)
  entityEvent = entity.toggleVisibleEvent.event
  if event ~= entityEvent then
    return
  end
  entity.visible.visible = not(entity.visible.visible)
end
