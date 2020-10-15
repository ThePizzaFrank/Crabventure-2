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
  local x = globals.tileSize*globals.scale*(entity.position.x)-entity.camera.x*globals.scale
  local y = globals.tileSize*globals.scale*(entity.position.y)-entity.camera.y*globals.scale
  love.graphics.draw(
    assets.images[entity.sprite.key],x,y,0,globals.scale)
end
