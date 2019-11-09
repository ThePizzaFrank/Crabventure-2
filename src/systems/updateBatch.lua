module(...,package.seeall)
Filter = require("src.utilities.filter")

globals = require('src.utilities.globals')
assets = require('src.assets')

local filter = Filter.filter({"spriteMap","batchMap","dirtyBit"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      dbit = entity.dirtyBit
      if(dbit.bit) then
        smap = entity.spriteMap.mapping
        bmap = entity.batchMap.mapping
        for k,v in pairs(smap) do
          batch = bmap[v]
          if(batch == nil) then
            bmap[v] = love.graphics.newSpriteBatch(assets.images[v])
            batch = bmap[v]
          end
          fillMap(dbit,batch)
        end
      end
    end
  end
end

function fillMap(dbit, batch)
  for k,v in ipairs(dbit.target) do
    batch:add(v.x,v.y)
  end
  dbit.target = {}
  dbit.bit = false
end
