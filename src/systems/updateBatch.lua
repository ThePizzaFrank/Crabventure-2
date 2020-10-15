module(...,package.seeall)
Filter = require("src.utilities.filter")

globals = require('src.utilities.globals')
assets = require('src.assets')

local filter = Filter.filter({"collisionMap","spriteMap","batchMap","dirtyBit"})


--this takes any static Textured Collision Maps that haven't had their spriteBatches generated
--and updates the spritemap for it
function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      dbit = entity.dirtyBit
      --if the dirty bit is true
      if(dbit.bit) then
        --get maps
        cmap = entity.collisionMap.map
        smap = entity.spriteMap.mapping
        bmap = entity.batchMap.mapping
        for _,v in ipairs(dbit.target) do
          --find the associated value in the collision map at x and y of of the dbit target
          spriteKey = v.key
          --get the array of the possible sprites from the sprite map
          spriteTypes = smap[spriteKey]
          --pick one
          spriteName = spriteTypes[love.math.random(#spriteTypes)]
          --get the associated sprite batch for that sprite
          batch = bmap[spriteName]
          --if batch doesnt exist
          if(batch == nil) then
            --print(spriteName)
            entity.batchMap.mapping[spriteName] = love.graphics.newSpriteBatch(assets.images[spriteName])
          end
          entity.batchMap.mapping[spriteName]:add(v.x,v.y)
          --print(v.x,v.y,spriteName,entity.batchMap.mapping[spriteName]:getCount())
        end
        dbit.target = {}
        dbit.bit = false
      end
    end
  end
end
