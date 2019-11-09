module(...,package.seeall)
Filter = require("src.utilities.filter")

assets = require('src.assets')
globals = require('src.utilities.globals')

local filter = Filter.filter({"sprite","position","camera"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      draw(entity)
    end
  end
end

function draw(entity)
  local x = globals.tileSize*(entity.position.x)-entity.camera.x
  local y = globals.tileSize*(entity.position.y)-entity.camera.y
  love.graphics.draw(
    assets.images[entity.sprite.key],x,y)
end
