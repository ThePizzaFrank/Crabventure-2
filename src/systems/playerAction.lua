module(...,package.seeall)
Filter = require("src.utilities.filter")


filter = Filter.filter({"player","action"})

function update(entity)
  return entity.action.turns
end
