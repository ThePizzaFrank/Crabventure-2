module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

StaticTexturedCollisionMap = require("src.entities.staticTexturedCollisionMap")

Components = require("src.components")

globals = require('src.utilities.globals')
assets = require('src.assets')

filter = Filter.filter({"mapIdentifier","camera","mapData"})

--this is gonna be super inefficient with the new ECS framework I made but it only fully runs once per stage so idc
function update(entity)
  local count = entity.mapData.count
  if count > 1 and not(entity.mapData.merged) then
    local chunks = {}
    local loopFilter = Filter.filter({"collisionMap","spriteMap","batchMap","dirtyBit","camera","position","mapIdentifier"})
    local fitEntities = Entities:filterAll(loopFilter,false,true)
    for _,loopEntity in pairs(fitEntities) do
      if loopEntity.mapIdentifier.value == entity.mapIdentifier.value then
        table.insert(chunks,loopEntity)
        Entities:remove(loopEntity._id)
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
    resultStcm.mapIdentifier = entity.mapIdentifier
    resultStcm.spriteMap = chunks[1].spriteMap
    resultStcm.camera = entity.camera
    entity.mapData.count = 1
    entity.mapData.merged = true
    Entities:add(resultStcm);
  end
end
