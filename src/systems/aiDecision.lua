module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities
Components = require("src.components")

filter = Filter.filter({"action","ai","position","stats"})

function update(entity)
  if entity.action.turns <= 0 then
    if entity.ai.type == 1 then
      basic(entity)
    end
  end
end

function basic(entity)
  local xDif = entity.ai.target.x-entity.position.x
  local yDif = entity.ai.target.y-entity.position.y
  --get the direction of x movement
  local movement = Components.movement(xDif/math.max(1,math.abs(xDif)),0,entity.stats.movement)
  --if y dif has higher magnitude then shift from moving in x to moving in y
  if math.abs(yDif) > math.abs(xDif) then
    movement.x = 0
    movement.y = yDif/math.max(1,math.abs(yDif))
  end
  entity.movement = movement
end
--print(entity.movement.turns)

function advanced(entity)
end
