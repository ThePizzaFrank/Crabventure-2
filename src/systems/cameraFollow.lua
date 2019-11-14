module(...,package.seeall)
Filter = require("src.utilities.filter")

globals = require('src.utilities.globals')

local filter = Filter.filter({"position","camera","cameraTarget"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      entity.camera.x = entity.position.x * globals.tileSize + entity.cameraTarget.x
      entity.camera.y = entity.position.y * globals.tileSize + entity.cameraTarget.y
    end
  end
end
