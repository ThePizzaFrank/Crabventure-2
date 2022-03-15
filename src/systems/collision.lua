module(...,package.seeall)

Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

Components = require("src.components")
globals = require('src.utilities.globals')

filter = Filter.filter({"position","collider","movement"})

function update(entity)
  local nullify = false
  --find all dynamic colliders
  searchFilterDynamic = Filter.filter({"position","collider"})
  activeDynamicColliders = Entities:filterAll(searchFilterDynamic,false,true)
  for _,e2 in pairs(activeDynamicColliders) do
    future = futurePosition(entity)
    if(future.x == e2.position.x and future.y == e2.position.y and entity.collider.id ~= e2.collider.id) then
      nullify = true
      collision(entity,e2)
    end
  end
  --find all static colliders
  searchFilterStatic = Filter.filter({"position","collisionMap"})
  activeStaticColliders = Entities:filterAll(searchFilterStatic,false,true)
  for _,static in pairs(activeStaticColliders) do
    future = futurePosition(entity)
    if(checkStatic(future,static.collisionMap.map,static.position)) then
      staticCollision(entity,static)
    end
  end
end

function futurePosition(entity)
  local x = 0
  local y = 0
  if entity.movement then
    x = entity.movement.x
    y = entity.movement.y
  end
  future = {
    x = entity.position.x + x,
    y = entity.position.y + y
  }
  return future
end

function collision(e1,e2)
  Entities:addComponent(e1._id,"collision",Components.collision(e2.collider.type,e2.collider.id,e2.collider.name,e2._id))
  Entities:addComponent(e2._id,"collision",Components.collision(e1.collider.type,e1.collider.id,e1.collider.name,e1._id))
end

function checkStatic(future,cMap, pos)
  if cMap[future.x-pos.x] and cMap[future.x-pos.x][future.y-pos.y] then
    return cMap[future.x-pos.x][future.y-pos.y] >= 1
  else
    return false;
  end
end

function staticCollision(e1,e2)
  Entities:removeComponent(e1._id,"movement")
end
