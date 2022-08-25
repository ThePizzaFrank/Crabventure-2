module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities
Components = require("src.components")

filter = Filter.filter({"stats", "damageable"})

function update(entity)
  if entity.stats.currentHp <= 0 then
    if entity.player then
      --game over logic
    else
      --maybe implement better logic for death eventually?  Removing the entity might cause issues
      --drop items/give exp logic here too everntually
      Entities:remove(entity)
    end
  end
end
