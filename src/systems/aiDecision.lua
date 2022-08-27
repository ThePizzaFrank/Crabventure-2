module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities
Components = require("src.components")
BinaryHeap = require("src.utilities.binaryHeap")

filter = Filter.filter({"action","ai","position","stats"})

function update(entity)
  if entity.action.turns <= 0 then
    if entity.ai.type == 1 then
      basic(entity)
    end
    --inefficient a*
    if entity.ai.type == 2 then
      aStar(entity,false)

    end
    --efficient a*
    if entity.ai.type == 3 then
      aStar(entity,true)
    end
  end
end

function basic(entity)
  local xDif = entity.ai.target.x-entity.position.x
  local yDif = entity.ai.target.y-entity.position.y
  --get the direction of x movement
  local movement = Components.movement(xDif/math.max(1,math.abs(xDif)),0,entity.stats.movement)
  --if y dif has higher magnitude then shift from moving in x to moving in y
  if math.abs(yDif) > math.abs(xDif) then
    movement.x = 0
    movement.y = yDif/math.max(1,math.abs(yDif))
  end
  entity.movement = movement
end

function aStar(entity, reusePathway)
  if reusePathway and #entity.ai.existingPath > 0 and entity.ai.remainingTurns > 0 then
    local nextTile = table.remove(entity.ai.existingPath)
    local movement = Components.movement(nextTile.x - entity.position.x, nextTile.y - entity.position.y, entity.stats.movement)
    entity.ai.remainingTurns = entity.ai.remainingTurns - 1
    entity.movement = movement
  else
    local pathway = aStarAlgorithm(entity)
    local nextTile = table.remove(pathway)
    local movement = Components.movement(nextTile.x - entity.position.x, nextTile.y - entity.position.y, entity.stats.movement)
    if reusePathway then
      entity.ai.existingPath = reusePathway
      entity.ai.remainingTurns = entity.ai.recalcTurns
    end
    entity.movement = movement
  end
end

function aStarAlgorithm(entity)
  local heuristic = function(position,target)
    return math.abs(position.x-target.x + position.y -target.y)
  end

  local target = entity.ai.target
  local cMap = buildCollisionMap(entity.ai.target,entity._id)
  local priorityQueue = BinaryHeap.binaryHeap()
  local currentNode = queueItem(entity.position.x, entity.position.y, 0, heuristic(entity.position,target))
  local route = {}
  route[currentNode] = nil
  cMap[currentNode.x][currentNode.y].distance = 0
  priorityQueue:insert(currentNode.f, currentNode)
  local ct = 0
  while priorityQueue.current_heap_size > 0 and not(currentNode.x == target.x and currentNode.y == target.y) do
    currentNode = priorityQueue:pop()
    local neighbors = moveableTiles(cMap,currentNode)
    for k,neighbor in pairs(neighbors) do
      if not(cMap[neighbor.x][neighbor.y].visited) then
        oldDistance = cMap[neighbor.x][neighbor.y].distance
        newDistance = cMap[currentNode.x][currentNode.y].distance + 1 -- for now all tiles take 1 effort to traverse

        if oldDistance == nil or newDistance < oldDistance then
          cMap[neighbor.x][neighbor.y].distance = newDistance
          newNode = queueItem(neighbor.x,neighbor.y, newDistance, heuristic(neighbor,target))
          priorityQueue:insert(newNode.f, newNode)
          route[newNode] = currentNode
        end
      end
    end
    cMap[currentNode.x][currentNode.y].visited = true
  end

  --reconstruct path
  local path = {}
  local cur = currentNode
  local str = ""
  while route[cur] do
    if not(entity.position.x == cur.x and entity.position.y == cur.y) then
      table.insert(path,{x = cur.x, y = cur.y})
    end
    cur = route[cur]
  end
  return path
end

function moveableTiles(cMap, pos)
  local tiles = {}
  for x = -1,1,1 do
    for y = -1,1,1 do
      if math.abs(x) ~= math.abs(y) and cMap[pos.x + x] and cMap[pos.x + x][pos.y + y] and not(cMap[pos.x + x][pos.y + y].solid) then
        table.insert(tiles, {
          x = pos.x + x,
          y = pos.y + y
        })
      end
    end
  end
  return tiles
end

--TODO: look into caching this
function buildCollisionMap(target,id)
  local cMap
  --find all static colliders
  local searchFilterStatic = Filter.filter({"position","collisionMap"})
  local activeStaticColliders = Entities:filterAll(searchFilterStatic,false,true)
  for _,static in pairs(activeStaticColliders) do
    if not(cMap) then
      cMap = {}
    end
    for x,xval in pairs(static.collisionMap.map) do
      if not(cMap[x]) then
        cMap[x] = {}
      end
      for y,yval in pairs(xval) do
        cMap[x][y] = { solid = yval >= 1, visited = false, distance = nil }
      end
    end
  end
  --build out active colliders
  local searchFilterDynamic = Filter.filter({"position","collider"})
  local activeDynamicColliders = Entities:filterAll(searchFilterDynamic,false,true)
  for _,e2 in pairs(activeDynamicColliders) do
    if not(cMap[e2.position.x]) then
      cMap[e2.position.x] = {}
    end
    if e2.collider.solid then
      if e2._id == id or (e2.position.x == target.x and e2.position.y == target.y) then
        cMap[e2.position.x][e2.position.y] = { solid = false, visited = false, distance = nil }
      else
        cMap[e2.position.x][e2.position.y] = { solid = true, visited = false, distance = nil }
      end
    end
  end

  return cMap
end

function queueItem(x,y,cost,heuristic)
  local QueueItem = {
    x = x,
    y = y,
    g = cost,
    h = heuristic,
    f = cost + heuristic
  }
  return QueueItem
end
