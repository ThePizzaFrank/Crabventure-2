module(...,package.seeall)
Filter = require("src.utilities.filter")
Maze = require("src.utilities.maze")
Components = require("src.components")
StaticTCMGrower = require("src.entities.staticTCMGrower")

local filter = Filter.filter({"chunks","chunkData","position","spriteMap","camera"})

function update(world)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      mwid = entity.chunkData.width
      mhei = entity.chunkData.height
      wid = entity.chunkData.chunkWidth
      chunks = entity.chunks.chunks
      maze = Maze.maze1(mwid,mhei,entity.chunkData.start)
      print(maze)
      for x = 1, mwid do
        chunks[x] = {}
        for y = 1, mhei do
          chunks[x][y] = {}
          print(x,y)
          mazeSpot = maze[x][y]
          holes = mazeSpot.holes

          for _,hole in ipairs(holes) do
            currentHole = {x = 0, y = 0,width = 0}
            if chunks[x+hole.x] and chunks[x+hole.x][y+hole.y] then
              found = searchPair(hole,chunks[x+hole.x][y+hole.y])
              if found ~= nil then
                currentHole = pairOpening(hole,wid,3,found)
              else
                currentHole = genOpening(hole,wid,3)
              end
            else
              currentHole = genOpening(hole,wid,3)
            end
            table.insert(chunks[x][y],currentHole)
          end
          builder = StaticTCMGrower.staticTCMGrower()
          if #chunks[x][y] == 2 then
            builder.builder.types = {2,5}
            builder.builder.parameters[2] = {
              width = chunks[x][y][1].width,
              sPos =
                {x = chunks[x][y][1].x, y = chunks[x][y][1].y},
              ePos =
                {x = chunks[x][y][2].x, y = chunks[x][y][2].y}
            }

          else
            builder.builder.types = {1}
          end
          builder.builder.width = wid
          builder.builder.height = wid
          builder.position.x = wid*(x-1)
          builder.position.y = wid*(y-1)
          builder.spriteMap = entity.spriteMap
          builder.camera = entity.camera
          table.insert(world,builder)
        end
      end
      entity.chunks = nil
      entity.chunkData = nil
    end
  end
end

function genOpening(hole,cwid,hwid)
  osx = 0;
  osy = 0

  if math.abs(hole.x) ~= 0 then
    center = (cwid+1-hwid+1.0)/2
    osx = center + hole.x * (center - 1)
    osy = love.math.random(2,cwid-hwid)
  end
  if math.abs(hole.y) ~= 0 then
    center = (cwid+1-hwid+1.0)/2
    osy = center + hole.y * (center - 1)
    osx = love.math.random(2,cwid-hwid)
  end
  return {x = osx, y = osy, width = hwid,hx = hole.x,hy = hole.y}
end

function pairOpening(hole,cwid,hwid,phole)
  osx = 0;
  osy = 0

  if math.abs(hole.x) ~= 0 then
    center = (cwid+1-hwid+1.0)/2
    osx = center + hole.x * (center - 1)
    osy = phole.y
  end
  if math.abs(hole.y) ~= 0 then
    center = (cwid+1-hwid+1.0)/2
    osy = center + hole.y * (center - 1)
    osx = phole.x
  end
  return {x = osx, y = osy, width = hwid,hx = hole.x,hy = hole.y}
end

function searchPair(hole,chunk)
  for _,h in pairs(chunk) do
    if(-hole.x == h.hx and -hole.y == h.hy) then
      return h
    end
  end
  return nil
end
