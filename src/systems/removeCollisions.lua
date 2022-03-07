module(...,package.seeall)
Filter = require("src.utilities.filter")


filter = Filter.filter({"collision"})

function update(entity)
  entity.collision = nil
end
