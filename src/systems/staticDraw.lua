module(...,package.seeall)
Filter = require("src.utilities.filter")

assets = require('src.assets')
globals = require('src.utilities.globals')

local filter = Filter.filter({"sprite","position","camera"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      if not(entity.visible) or entity.visible.visible then
        draw(entity)
      end
    end
  end
end

function draw(entity)
  offsetX = 0
  offsetY = 0
  if entity.camera then
    offsetX = entity.camera.x
    offsetY = entity.camera.y
  end
  local x = globals.tileSize*globals.scale*(entity.position.x)-offsetX
  local y = globals.tileSize*globals.scale*(entity.position.y)-offsetY
  love.graphics.draw(
    assets.images[entity.sprite.key],x,y,0,globals.scale)
end
