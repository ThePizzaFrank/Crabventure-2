module(...,package.seeall)

local globals = require('src.utilities.globals')

function player()
  local Player = {
    canAct = true
  }
  return Player
end

function collider(type,name,solid)
  local Collider = {
    width = 1,
    height = 1,
    type = type,
    active = true,
    id = globals.currentCollider,
    name = name,
    solid = solid or false
  }
  globals.currentCollider = globals.currentCollider + 1
  return Collider
end

function collisionMap()
  local CollisionMap = {
    map = {}
  }
  return CollisionMap
end

function sprite(key)
  local Sprite = {
    key = key,
  }
  return Sprite
end

function spriteMap()
  local SpriteMap = {
    --key is a number
    --0 for floor
    --1 for wall
    --value is an array of possible sprites
    mapping = {}
  }
  return SpriteMap
end

function batchMap()
  local BatchMap = {
    mapping = {}
  }
  return BatchMap
end

function movement(x,y, turns)
  local Movement = {
    x = x,
    y = y,
    turns = turns
  }
  return Movement
end

function dirtyBit(bool)
  local DirtyBit = {
    bit = bool,
    --target contains key to the sprite x and y position coordinates
    target = {}
  }
  return DirtyBit
end


--delay after you do something
function action(turns)
  local Action = {
    turns = turns
  }
  return Action
end

function stats(movement, maxHp)
  local Stats = {
    movement = movement,
    maxHp = maxHp,
    currentHp = maxHp
  }
  return Stats
end

function directionControls(up,down,left,right)
  local DirectionControls = {
    up = up,
    down = down,
    left = left,
    right = right
  }
  return DirectionControls
end

function gameControls(quit,interact,close)
  local GameControls = {
    quit = quit, --probably remove this later
    interact = interact,
    close = close,
  }
  return GameControls
end

function position(x,y)
  local Position = {
    x = x,
    y = y
  }
  return Position
end

function camera(x,y)
  local Camera = {
    x = x,
    y = y
  }
  return Camera
end

function cameraTarget(x,y)
  local CameraTarget = {
    x = x,
    y = y
  }
  return CameraTarget
end

function chunks()
  local Chunks = {
    chunks = {}
  }
  return Chunks
end

--chunk width is the size of chunk whereas width and height are the number of
--chunks wide/high the map is
function chunkData(chunkWidth, width, height, start)
  local ChunkData = {
    chunkWidth = chunkWidth,
    width = width,
    height = height,
    start = start
  }
  return ChunkData
end

function builder(type,width,height)
  local Builder = {
    types = {},
    --parameter contains elements whose indice correspond to the indices of the
    --types array in the builder
    parameters = {},
    width = width,
    height = height
  }
  return Builder
end

function scrollData(min,max)
  local ScrollData = {
    scrollPosition = 0,
    --if min/max is not nil scrollPosition cannot go below min and cannot go above max respectively
    scrollMin = min,
    scrollMax = max
  }
  return ScrollData
end

function debugData()
  local DebugData = {
    expanded = false
  }
  return DebugData
end

function mapIdentifier(val)
  local MapIdentifier = {
    value = val
  }
  return MapIdentifier
end

function mapMetaData()
  local MapMetaData = {
    floor = floor
  }
  return MapMetaData
end

function mapData(floor)
  local MapData = {
    generated = false,
    merged = false,
    requiredEntities = {},
    floor = floor,
    count = 0
  }
  return MapData;
end

function classification(wipe)
  --used for determining some stuff like whether or not it gets removed when the next floor is generated
  local Classification = {
    wipedOnNewFloor = wipe;
  }
  return Classification
end

function visible(visible)
  local Visible = {
    visible = visible
  }
  return Visible
end

function interfaceVisible(visible)
  local InterfaceVisible = {
    visible = visible
  }
  return InterfaceVisible
end

function toggleVisibleEvent(event)
  local ToggleVisibleEvent = {
    event = event
  }
  return ToggleVisibleEvent
end

function window(width,height)
  local Window = {
    width = width,
    height = height
  }
  return Window
end

function mouseCollider(width,height)
  local MouseCollider = {
    width = width,
    height = height,
  }
  return MouseCollider
end

function hover()
  local Hover = {
    hover = false
  }
  return Hover
end

--emits an event depending on certain situations
--trigger is determined by other components attached to the entity
function eventEmitter(event)
  local EventEmitter = {
    event = event
  }
  return EventEmitter
end

--depending on how its named can perform different functions based on systems
--ex. hoverSwap will swap sprite to alt when hovered
function spriteSwap(default,alt)
  local SpriteSwap = {
    default = default,
    alt = alt
  }
  return SpriteSwap
end

function collision(colliderType,colliderId,colliderName,entityId)
  local Collision = {
    colliderType = colliderType,
    colliderId = colliderId,
    colliderName = colliderName,
    entityId = entityId,
  }
  return Collision
end

function inventory()
  local Inventory = {
    items = {}
  }
  return Inventory
end

function deleteEvent(event)
  local DeleteEvent = {
    event = event
  }
  return DeleteEvent
end

function userInterface(elements,open,openEvent)
  local UserInterface = {
    elements = elements or {},
    open = open,
    openEvent = openEvent
  }
  return UserInterface
end

function ai(type,target,world, recalcTurns)
  local AI = {
    type = type,
    target = target,
    existingPath = {},
    recalcTurns = recalcTurns,
    remainingTurns = recalcTurns,
  }
  return AI
end

function damageable()
  local Damageable = {
    invulnerability = 0
  }
  return Damageable
end

function canAttack(baseDamage)
  local CanAttack = {
    baseDamage = baseDamage
  }
  return CanAttack
end

function attack(x, y, baseDamage, turns)
  local Attack = {
    baseDamage = baseDamage,
    turns = turns,
    x = x,
    y = y,
  }
  return Attack
end

function alliance(allianceId)
  local Alliance = {
    allianceId = allianceId
  }
  return Alliance
end
