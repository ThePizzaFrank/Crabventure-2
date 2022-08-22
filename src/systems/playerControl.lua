--this one has updates needed in the entity
module(...,package.seeall)

Components = require("src.components")
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"player","position","directionControls","gameControls","action","stats"})

function update(entity,key)
  handleInput(entity,key)
end

function handleInput(entity,key)
  --temp to test events
  if key == 'i' then
    love.event.push("gameEvent","inventoryToggle")
  end

  --end temp
  for k,inputOption in pairs(entity.gameControls) do
    if key == inputOption then
      if k == 'quit' then
        love.event.push("quit")
      elseif k == "interact" then
        love.event.push("gameEvent","interact",entity.position.x,entity.position.y)
      end
    end
  end
  for k,inputOption in pairs(entity.directionControls) do
    if key == inputOption then
      --use can act here?
      if k == 'up' and passive(entity) then
        Entities:addComponent(entity._id,"movement",Components.movement(0,-1,entity.stats.movement))
      elseif k == 'down' and passive(entity) then
        Entities:addComponent(entity._id,"movement",Components.movement(0,1,entity.stats.movement))
      elseif k == 'left' and passive(entity) then
        Entities:addComponent(entity._id,"movement",Components.movement(-1,0,entity.stats.movement))
      elseif k == 'right' and passive(entity) then
        Entities:addComponent(entity._id,"movement",Components.movement(1,0,entity.stats.movement))
      end
      love.event.push("gameEvent","closeAll") 
    end
  end
end

function passive(entity)
  return entity.action.turns == 0
end
