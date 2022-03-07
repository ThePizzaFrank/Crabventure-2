module(...,package.seeall)
Filter = require("src.utilities.filter")

globals = require('src.utilities.globals')

filter = Filter.filter({"position","camera","cameraTarget"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      entity.camera.x = entity.position.x * globals.tileSize * globals.scale + entity.cameraTarget.x
      entity.camera.y = entity.position.y * globals.tileSize * globals.scale + entity.cameraTarget.y
    end
  end
end
