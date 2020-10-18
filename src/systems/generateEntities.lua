module(...,package.seeall)
Filter = require("src.utilities.filter")

Components = require("src.components")
Staircase = require("src.entities.staircase")

globals = require('src.utilities.globals')
assets = require('src.assets')


local filter = Filter.filter({"collisionMap","genEntities","camera"})

function update(world)
  unionMap = Components.collisionMap();
  matched = false
  camera = nil
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      if not(matched) then
        camera = entity.camera
      end
      matched = true

      --here we're going to union all the complete collisionmaps so we know all tiles that can have entities placed on them
      for x,xval in pairs(entity.collisionMap.map) do
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
      --once this is all over remove the genEntities from the entity
      --might want to do this later if genentities contains useful data used later
      --but I'm not ready for that yet
      entity.genEntities = nil
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
    --then generate the entities, not sure how I want to do this yet though
    --for now I'll hardcode each entity I want to spawn but eventually
    --I want to fill genEntities with params that can be parsed for each set of entities

    --generate staircase
    --staircase must never have any adjacent things (walls, other entities, etc)
    --just makes it easier for me
    stairPlaced = false;
    --stair has to be more unique than other entities because of how important it is,
    --so the position its placed needs to be catalogued so other items don't interfere with it
    stairPos = {}
    while not(stairPlaced) do
      index = love.math.random(#openTiles);
      stairPos = openTiles[index]
      notSurrounded = true
      for x = -1, 1 do
        for y = -1, 1 do
          notSurrounded = notSurrounded and unionMap.map[stairPos.x+x][stairPos.y+y] == 0
        end
      end
      if notSurrounded then
        stairPlaced = true
        stairCase = Staircase.staircase(stairPos.x,stairPos.y)
        stairCase.camera = camera
        --place stair
        table.insert(world,stairCase)
        --remove stair position from openTiles
        table.remove(openTiles,index)
      end
    end
  end
end
