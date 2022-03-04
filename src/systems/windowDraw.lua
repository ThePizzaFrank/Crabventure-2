module(...,package.seeall)
Filter = require("src.utilities.filter")

assets = require('src.assets')
globals = require('src.utilities.globals')

local filter = Filter.filter({"window","screenPosition"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      if not(entity.visible) or entity.visible.visible then
        love.graphics.setColor(0,0,1)
        love.graphics.rectangle("fill", entity.screenPosition.x, entity.screenPosition.y, entity.window.width, entity.window.height)
        love.graphics.setColor(1,1,1)
      end
    end
  end
end
