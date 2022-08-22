module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities
Components = require("src.components")

filter = Filter.filter({"collision", "movement", "canAttack", "stats", "alliance"})

function update(entity)
  local damageableFilter = Filter.filter({"damageable", "alliance"})
  local collidedEntity = Entities:get(entity.collision.entityId, damageableFilter)
  print(collidedEntity)
  if collidedEntity and collidedEntity.damageable and collidedEntity.alliance.allianceId ~= entity.alliance.allianceId then
    entity.attack = Components.attack(entity.movement.x, entity.movement.y, entity.canAttack.baseDamage, entity.stats.movement)
    Entities:update(entity)
    Entities:removeComponent(entity._id,"movement")
  end
end
