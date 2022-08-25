module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities
Components = require("src.components")

filter = Filter.filter({"position", "attack", "action"})

function update(entity)
  local targetFilter = Filter.filter({"damageable","position","collider", "stats"})
  local targets = Entities:filterAll(targetFilter, false, true)
  for _,target in pairs(targets) do
    if target._id ~= entity._id then
      if target.collider.active and target.position.x == entity.position.x + entity.attack.x
        and target.position.y == entity.position.y + entity.attack.y then
        target.stats.currentHp = target.stats.currentHp - entity.attack.baseDamage
        entity.action.turns = entity.attack.turns
        entity.attack = nil
        Entities:update(entity)
        print(entity._id,'attacked',target._id)
      end
    end
  end
end
