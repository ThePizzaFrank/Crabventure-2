module(...,package.seeall)
Filter = require("src.utilities.filter")

filter = Filter.filter({"mouseCollider","eventEmitter","screenPosition"})

function update(entity,x,y,button)
  if not(entity.interfaceVisible) or entity.interfaceVisible.visible then
    xMin = entity.screenPosition.x
    xMax = entity.screenPosition.x + entity.mouseCollider.width
    yMin = entity.screenPosition.y
    yMax = entity.screenPosition.y + entity.mouseCollider.height
    if x > xMin and x < xMax and y > yMin and y < yMax then
      love.event.push("gameEvent",entity.eventEmitter.event)
    end
  end
end
