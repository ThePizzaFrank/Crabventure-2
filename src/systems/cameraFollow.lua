module(...,package.seeall)
Filter = require("src.utilities.filter")

globals = require('src.utilities.globals')

filter = Filter.filter({"position","camera","cameraTarget"})

function update(entity)
  entity.camera.x = entity.position.x * globals.tileSize * globals.scale + entity.cameraTarget.x
  entity.camera.y = entity.position.y * globals.tileSize * globals.scale + entity.cameraTarget.y
end
