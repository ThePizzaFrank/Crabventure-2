module(...,package.seeall)
Filter = require("src.utilities.filter")

filter = Filter.filter({"visible","toggleVisibleEvent"})

function update(world,event)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      entityEvent = entity.toggleVisibleEvent.event
      if event == entityEvent then
        entity.visible.visible = not(entity.visible.visible)
        print("toggleVisibleEvent triggered for "..entity._type)
      end
    end
  end
end
