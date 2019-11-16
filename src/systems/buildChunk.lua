module(...,package.seeall)
Filter = require("src.utilities.filter")
Components = require("src.components")
StaticTexturedCollisionMap = require("src.entities.staticTexturedCollisionMap")

globals = require("src.utilities.globals")
local filter = Filter.filter({"builder","spriteMap","position"})


empty = function(world,cMap,width,height,parameters)
  for i = 1, width do
    cMap[i] = {}
    for j = 1, height do
      cMap[i][j] = 0
    end
  end
  return cMap
end

full = function(world,cMap,width,height,parameters)
  for i = 1, width do
    cMap[i] = {}
    for j = 1, height do
      cMap[i][j] = 1
    end
  end
  return cMap
end

walled = function(world,cMap,width,height,parameters)
  for i = 1, width do
    for j = 1, height do
      if(i == 1 or i == width or j == 1 or j == height) then
        cMap[i][j] = 1
      end
    end
  end
  return cMap
end

--takes parameters:
--width -> a number
--height -> a number
--position is the position of the upper-leftmost square of the entry
--example {width = 2, height = 2, position = {x = 3, y = 1}}
emptychunk = function(world,cMap,width,height,parameters)
  for i = parameters.position.x,parameters.width + parameters.position.x-1 do
    for j = parameters.position.y,parameters.height + parameters.position.y-1 do
      if(cMap[i] ~= nil and cMap[i][j] ~= nil) then
        cMap[i][j] = 0
      end
    end
  end
  return cMap
end
--takes parameters:
--width -> width of the tube
--sPos -> upper left position of the width x width square that starts the tube
--ePos -> upper left position of the width x width square that ends the tube
tube = function(world,cMap,width,height,parameters)
  ePos = parameters.ePos
  sPos = parameters.sPos
  print(width,parameters.width)
  distance = {x = ePos.x - sPos.x, y = ePos.y - sPos.y}
  cMap = emptychunk(world,cMap,width,height,
  {
    width = parameters.width,
    height = parameters.width,
    position = sPos
  })
  while(distance.x ~= 0 or distance.y ~= 0) do
    xSign = 1
    ySign = 1
    if distance.x < 0 then
      xSign = -1
    end
    if distance.y < 0 then
      ySign = -1
    end
    newDistance = {
      x = distance.x,
      y = distance.y
    }
    attempts = 0
    --make sure the maker is actually making progress by ensuring the next point is
    --closer to the endpoint than the last
    while math.sqrt(math.pow(newDistance.x,2) + math.pow(newDistance.y,2)) >=
      math.sqrt(math.pow(distance.x,2) + math.pow(distance.y,2)) do
      newDistance.x = distance.x
      newDistance.y = distance.y

      movex = xSign*love.math.random(
        math.min(-(parameters.width-2),math.abs(distance.x)),
        math.min(parameters.width-1,math.abs(distance.x))
      )
      movey = ySign*love.math.random(
        math.min(-(parameters.width-2),math.abs(distance.y)),
        math.min(parameters.width-1,math.abs(distance.y))
      )
      if(attempts > 50) then
        movex = xSign*math.min(1,math.abs(distance.x))
        movey = ySign*math.min(1,math.abs(distance.y))
      end
      --print(movex,movey)
      newDistance.x = newDistance.x-movex
      newDistance.y = newDistance.y-movey
      posx = ePos.x-newDistance.x
      posy = ePos.y-newDistance.y
      if posx < 1 then
        newDistance.x = newDistance.x - posx + 1
      end
      if posx > width-parameters.width/2 then
        newDistance.x = newDistance.x-(posx-(width-parameters.width/2))
        print("yee",posx, width-parameters.width)
      end
      if posy < 1 then
        newDistance.y = newDistance.y - posy + 1
      end
      if posy > width-parameters.width/2 then
        newDistance.y = newDistance.y-(posy-(width-parameters.width/2))
      end
      attempts = attempts + 1
    end
    --set distance to the new distance after the next point has been chosen
    distance = newDistance
    cMap = emptychunk(world,cMap,width,height,
    {
      width = parameters.width,
      height = parameters.width,
      position = {x = ePos.x-distance.x, y = ePos.y-distance.y}
    })
  end
  return cMap
end

local types = {empty,full,walled,emptychunk,tube}
--builds a map from a buildType
function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      local buildType = entity.builder.types
      local buildParameters = entity.builder.parameters
      local width = entity.builder.width
      local height = entity.builder.height
      dbit = Components.dirtyBit(true)
      cMap = {}

      for k,v in ipairs(buildType) do
        local bp = buildParameters[k];
        cMap = types[v](world,cMap,width,height,bp);
      end
      entity.collisionMap = Components.collisionMap()
      entity.collisionMap.map = cMap;
      i = 1
      for x,v in ipairs(cMap) do
        for y,b in ipairs(cMap[x]) do
          table.insert(dbit.target,{key = cMap[x][y], x = x*globals.tileSize, y = y*globals.tileSize})
        end
      end
      entity.dirtyBit = dbit;
      entity.batchMap = Components.batchMap()
      entity.builder = nil
    end
  end
end
