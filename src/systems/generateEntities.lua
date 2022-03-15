module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities
Components = require("src.components")
Staircase = require("src.entities.staircase")

globals = require('src.utilities.globals')
assets = require('src.assets')


filter = Filter.filter({"mapIdentifier","mapData","camera"})

function update(entity)
  if not(entity.mapData.merged) or entity.mapData.generated then
    return
  end
  unionMap = Components.collisionMap();
  matched = false
  camera = entity.camera
  loopFilter = Filter.filter({"collisionMap","mapIdentifier","camera"})
  filterEntities = Entities:filterAll(loopFilter,false,true)

  for _,loopEntity in pairs(filterEntities) do
    if loopEntity.mapIdentifier.value == entity.mapIdentifier.value then
      matched = true

      --here we're going to union all the complete collisionmaps so we know all tiles that can have entities placed on them
      for x,xval in pairs(loopEntity.collisionMap.map) do
        for y,open in pairs(xval) do
          --if the tile is open on this particular collision map
          if open == 0 then
            --create row if doesnt exist, I should know what this does if I look @ it but I can be a dumbass sometimes
            if unionMap.map[x] == nil then
              unionMap.map[x] = {}
            end
            --Must also be open/nil on the union map, then it will stay open
            if unionMap.map[x][y] == nil or unionMap.map[x][y] == 0 then
              unionMap.map[x][y] = 0
            end
          elseif open == 1 then
            if unionMap.map[x] == nil then
              unionMap.map[x] = {}
            end
            --union will always become false if its not open on any individual map
            unionMap.map[x][y] = 1
          end
        end
      end

    end
  end
  if matched then
    openTiles = {}
    --then iterate through the unionMap and make a list of all X,Y values that are open
    for x,xval in pairs(unionMap.map) do
      for y,open in pairs(xval) do
        if open == 0 then
          table.insert(openTiles,{x=x,y=y})
        end
      end
    end
    --then generate the entities using mapData.requiredEntities and some hardcoded
    stairPos = {}
    for _,groundEntity in pairs(entity.mapData.requiredEntities) do
      --generate staircase
      --staircase must never have any adjacent things (walls, other entities, etc)
      --just makes it easier for me
      placed = false;
      pos = {}
      --stair has to be more unique than other entities because of how important it is,
      --so the position its placed needs to be catalogued so other items don't interfere with it
      isStairCase = groundEntity._type == 'stairCase'
      while not(placed) do
        index = love.math.random(#openTiles);
        if isStairCase then
          stairPos = openTiles[index]
        end
        pos = openTiles[index]
        notSurrounded = true
        for x = -1, 1 do
          for y = -1, 1 do
            notSurrounded = notSurrounded and unionMap.map[pos.x+x][pos.y+y] == 0
          end
        end
        if notSurrounded then
          placed = true
          groundEntity.position.x = pos.x
          groundEntity.position.y = pos.y
          groundEntity.camera = camera
          --place entity
          Entities:add(groundEntity)
          --remove stair position from openTiles
          if isStairCase then
            table.remove(openTiles,index)
          end
        end
      end
    end
  end
  entity.mapData.generated = true
end
