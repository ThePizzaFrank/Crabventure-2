module(...,package.seeall)

Components = require("src.components")
Filter = require("src.utilities.filter")

local filter = Filter.filter({"position","directionControls","gameControls","action","stats"})

function update(world,key)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      handleInput(entity,key)
    end
  end
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
        entity.movement = Components.movement(0,-1)
      elseif k == 'down' and passive(entity) then
        entity.action.turns = entity.stats.movement
        entity.movement = Components.movement(0,1)
      elseif k == 'left' and passive(entity) then
        entity.action.turns = entity.stats.movement
        entity.movement = Components.movement(-1,0)
      elseif k == 'right' and passive(entity) then
        entity.action.turns = entity.stats.movement
        entity.movement = Components.movement(1,0)
      end
    end
  end
end

function passive(entity)
  return entity.action.turns == 0
end
