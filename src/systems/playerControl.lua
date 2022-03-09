--this one has updates needed in the entity
module(...,package.seeall)

Components = require("src.components")
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"position","directionControls","gameControls","action","stats"})

function update(entity,key)
  handleInput(entity,key)
end

function handleInput(entity,key)
  --temp to test events
  if key == 'i' then
    love.event.push("gameEvent","inventoryClose")
  end
  --end temp
  for k,inputOption in pairs(entity.gameControls) do
    if key == inputOption then
      if k == 'quit' then
        love.event.push("quit")
      end
    end
  end
  for k,inputOption in pairs(entity.directionControls) do
    if key == inputOption then
      if k == 'up' and passive(entity) then
        entity.action.turns = entity.stats.movement
        Entities:addComponent(entity._id,"movement",Components.movement(0,-1))
      elseif k == 'down' and passive(entity) then
        entity.action.turns = entity.stats.movement
        Entities:addComponent(entity._id,"movement",Components.movement(0,1))
      elseif k == 'left' and passive(entity) then
        entity.action.turns = entity.stats.movement
        Entities:addComponent(entity._id,"movement",Components.movement(-1,0))
      elseif k == 'right' and passive(entity) then
        entity.action.turns = entity.stats.movement
        Entities:addComponent(entity._id,"movement",Components.movement(1,0))
      end
    end
  end
end

function passive(entity)
  return entity.action.turns == 0
end
