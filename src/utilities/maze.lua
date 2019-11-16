module(...,package.seeall)

function mazeRoom()
  MazeRoom = {
    holes = {},
    visited = false
  }
  return MazeRoom
end

function neighbors1(maze,position)
  neighbors = {}
  for x = -1, 1 do
    for y = -1, 1 do
      if math.abs(x) ~= math.abs(y) then
        xPos = position.x + x
        yPos = position.y + y
        if maze[xPos] ~= nil and maze[xPos][yPos] ~= nil and maze[xPos][yPos].visited == false then
          table.insert(neighbors,{x = x, y = y})
        end
      end
    end
  end
  return neighbors
end

function maze1(width,height,start)
  maze = {}
  for x = 1, width do
    maze[x] = {}
    for y = 1, height do
      maze[x][y] = mazeRoom()
    end
  end
  maze[start.x][start.y].visited = true
  maze = maze1recur(maze,start,{{x = start.x, y = start.y}})
  --[[for y = 1, #maze[1] do
    line = "okay"
    for x = 1, #maze do
      for hole in pairs(maze[x][y].holes) do
        print(hole)
        if(hole.x == -1) then
          line = line .. "<"
        elseif(hole.x == 1) then
          line = line .. ">"
        elseif(hole.y == 1) then
          line = line .. "v"
        elseif(hole.y == -1) then
          line = line .. "^"
        end
      end
      line = line .. " "
    end
    print(line)
  end]]
  return maze
end

function maze1recur(maze,pos,stack)
  neighbors = neighbors1(maze,pos)
  print(#neighbors)
  while #neighbors > 0 do
    neighbor = neighbors[love.math.random(#neighbors)]
    table.insert(maze[pos.x][pos.y].holes,{x = neighbor.x, y = neighbor.y})
    pos.x = neighbor.x + pos.x
    pos.y = neighbor.y + pos.y
    print(pos.x,pos.y)
    maze[pos.x][pos.y].visited = true
    table.insert(maze[pos.x][pos.y].holes,{x = -neighbor.x, y = -neighbor.y})
    neighbors = neighbors1(maze,pos)
    table.insert(stack,{x = pos.x, y = pos.y})
  end
  while #neighbors == 0 do
    if(#stack == 0) then
      return maze
    end
    pos = stack[#stack]
    table.remove(stack)
    neighbors = neighbors1(maze,pos)
  end
  return maze1recur(maze,pos,stack)
end
