module(...,package.seeall)
Filter = require("src.utilities.filter")

StaticTexturedCollisionMap = require("src.entities.staticTexturedCollisionMap")

Components = require("src.components")

globals = require('src.utilities.globals')
assets = require('src.assets')

filter = Filter.filter({"collisionMap","spriteMap","batchMap","dirtyBit","id","camera","genEntities"})

function update(world)
  local ids = getIds(world)
  for id,count in pairs(ids) do
    if count > 1 then
      local localct =count
      local chunks = {}
      for key,entity in pairs(world) do
        if filter:fit(entity) then
          if entity.id.value == id then
            table.insert(chunks,entity)
            world[key] = nil
          end
        end
      end
      local resultStcm = StaticTexturedCollisionMap.staticTexturedCollisionMap()
      for k,chunk in pairs(chunks) do
        for cpos,column in ipairs(chunk.collisionMap.map) do
          trueCpos = cpos + chunk.position.x
          if resultStcm.collisionMap.map[trueCpos] == nil then
            resultStcm.collisionMap.map[trueCpos] = {}
          end
          for rpos,rowValue in ipairs(column) do
            trueRpos = rpos + chunk.position.y
            resultStcm.collisionMap.map[trueCpos][trueRpos] = rowValue
            table.insert(resultStcm.dirtyBit.target,{key = resultStcm.collisionMap.map[trueCpos][trueRpos], x = trueCpos*globals.tileSize, y = trueRpos*globals.tileSize})
          end
        end
      end
      resultStcm.id.value = id
      resultStcm.spriteMap = chunks[1].spriteMap
      resultStcm.camera = chunks[1].camera
      resultStcm.genEntities = chunks[1].genEntities
      table.insert(world,resultStcm)
      ids[id] = false
    end
  end
end

function getIds(world)
  ids = {}
  for key,entity in pairs(world) do
    if filter:fit(entity) then
      if entity.id.value ~= -1 then
        if ids[entity.id.value] == nil then
          ids[entity.id.value] = 0
        end
        ids[entity.id.value] = ids[entity.id.value] + 1
      end
    end
  end
  return ids
end
