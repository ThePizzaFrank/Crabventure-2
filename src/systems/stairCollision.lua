module(...,package.seeall)
Filter = require("src.utilities.filter")

globals = require("src.utilities.globals")
filter = Filter.filter({"collision","player","position"})

--I dont want all the next floor logic to be here, it will trigger an event to run the actual world code
function update(entity)
  if entity.collision.colliderType == globals.CollisionEnum.Object and entity.collision.colliderName == "stair" then
    love.event.push("gameEvent", "nextFloor")
  end
end
