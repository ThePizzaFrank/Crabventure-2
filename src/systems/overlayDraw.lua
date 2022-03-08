module(...,package.seeall)
Filter = require("src.utilities.filter")

assets = require('src.assets')
globals = require('src.utilities.globals')

filter = Filter.filter({"sprite","screenPosition"})

function update(entity)
  if not(entity.visible) or entity.visible.visible then
    draw(entity)
  end
end

function draw(entity)
  offsetX = 0
  offsetY = 0
  local x = globals.scale*(entity.screenPosition.x)
  local y = globals.scale*(entity.screenPosition.y)
  love.graphics.draw(
    assets.images[entity.sprite.key],x,y,0,globals.scale)
end
