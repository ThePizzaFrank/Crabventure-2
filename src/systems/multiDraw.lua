module(...,package.seeall)
Filter = require("src.utilities.filter")

assets = require('src.assets')
globals = require('src.utilities.globals')

filter = Filter.filter({"batchMap","position","camera"})

function update(entity)
  bmap = entity.batchMap.mapping
  for k,batch in pairs(bmap) do
    draw(entity,batch);
  end
end

local function draw(entity,batch)
  local x = globals.tileSize*globals.scale*(entity.position.x)-entity.camera.x
  local y = globals.tileSize*globals.scale*(entity.position.y)-entity.camera.y
  love.graphics.draw(
    batch,x,y,0,globals.scale)
end
