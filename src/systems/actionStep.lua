module(...,package.seeall)
Filter = require("src.utilities.filter")

filter = Filter.filter({"action"})

function update(entity)
  if(entity.action.turns > 0) then
    entity.action.turns = entity.action.turns - 1
  end
end
