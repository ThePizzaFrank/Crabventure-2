module(...,package.seeall)
Filter = require("src.utilities.filter")

filter = Filter.filter({"visible","toggleVisibleEvent"})

function update(entity,event)
  entityEvent = entity.toggleVisibleEvent.event
  if event == entityEvent then
    entity.visible.visible = not(entity.visible.visible)
    print("toggleVisibleEvent triggered for "..entity._type)
  end
end
