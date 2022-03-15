module(...,package.seeall)
Filter = require("src.utilities.filter")


filter = Filter.filter({"collision","player","position"})

function update(entity)
  --if entity.collision.collisionType == ''
  --go down stairs
end
