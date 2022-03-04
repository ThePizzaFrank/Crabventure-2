module(...,package.seeall)
Filter = require("src.utilities.filter")

local filter = Filter.filter({"mouseCollider","eventEmitter","screenPosition"})

function update(world,x,y,button)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      if not(entity.visible) or entity.visible.visible then
        xMin = entity.screenPosition.x
        xMax = entity.screenPosition.x + entity.mouseCollider.width
        yMin = entity.screenPosition.y
        yMax = entity.screenPosition.y + entity.mouseCollider.height
        if x > xMin and x < xMax and y > yMin and y < yMax then
          love.event.push("gameEvent",entity.eventEmitter.event)
        end
      end
    end
  end
end
