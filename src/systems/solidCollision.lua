module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"collision", "movement", "collider"})

function update(entity)
  local colliderFilter = Filter.filter({"collider"})
  local collidedEntity = Entities:get(entity.collision.entityId, colliderFilter)
  if collidedEntity and collidedEntity.collider.solid and entity.collider.solid then
    Entities:removeComponent(entity._id,"movement")
  end
end
