module(...,package.seeall)
Filter = require("src.utilities.filter")

assets = require('src.assets')
globals = require('src.utilities.globals')

local filter = Filter.filter({"batchMap","position","camera"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      bmap = entity.batchMap.mapping
      for k,batch in pairs(bmap) do
        draw(entity,batch);
      end
    end
  end
end

function draw(entity,batch)
  local x = globals.tileSize*(entity.position.x)-entity.camera.x
  local y = globals.tileSize*(entity.position.y)-entity.camera.y
  love.graphics.draw(
    batch,x,y)
end
