module(...,package.seeall)
Filter = require("src.utilities.filter")

filter = Filter.filter({"collider","position","eventEmitter"})

function update(entity,event,x,y)
  if event == "interact" and entity.position.x == x and entity.position.y == y then
    --loopFilter = Filter.filter({"collisionMap","mapIdentifier","camera"})
    --filterEntities = Entities:filterAll(loopFilter,false,true)
    love.event.push("gameEvent",entity.eventEmitter.event,entity._id)
  end
end
