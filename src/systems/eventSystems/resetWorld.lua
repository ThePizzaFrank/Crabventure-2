module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities
MapGenerator = require("src.entities.mapGenerator")
Staircase = require("src.entities.stairCase")


filter = Filter.filter({"player","position"})

function update(entity,event,e1,e2)
  if event ~= "nextFloor" then
    return
  end
  --look for entities to wipe
  local mapFilter = Filter.filter({"classification"})
  local mapEntities = Entities:filterAll(mapFilter,false,true)
  for _,mapEntity in pairs(mapEntities) do
    --remove entities that get wiped on load
    if mapEntity.classification.wipedOnNewFloor then
      Entities:remove(mapEntity)
    end
  end

  --generate new map and move player
  --maybe move player after world is fully gen'd to add some spice to spawn location
  --will do later

  --create another generator and insert it into the world
  mGen = MapGenerator.mapGenerator(10,5,5,{x = 1,y = 1},0)
  --set camera to player camera
  mGen.camera = entity.camera
  mGen.spriteMap.mapping[1] = {"wall_1","wall_2"}
  mGen.spriteMap.mapping[0] = {"floor_1"}
  --add stair entity to required Entities
  stair = Staircase.staircase()
  table.insert(mGen.mapData.requiredEntities,stair)
  Entities:add(mGen)
  --move player
  entity.position.x = 5
  entity.position.y = 5
end
