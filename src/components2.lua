module(...,package.seeall)

globals = require('src.utilities.globals')

Components = {
  player = function ()
    return {}
  end,

  collider = function (type)
    Collider = {
      width = 1,
      height = 1,
      type = type,
      active = true,
      id = globals.currentCollider,
    }
    globals.currentCollider = globals.currentCollider + 1
    return Collider
  end,

  collisionMap = function ()
    CollisionMap = {
      map = {}
    }
    return CollisionMap
  end,

  sprite = function (key)
    Sprite = {
      key = key,
    }
    return Sprite
  end,

  spriteMap = function ()
    SpriteMap = {
      --key is a number
      --0 for floor
      --1 for wall
      --value is an array of possible sprites
      mapping = {}
    }
    return SpriteMap
  end,

  batchMap = function ()
    BatchMap = {
      mapping = {}
    }
    return BatchMap
  end,

  movement = function (x,y, turns)
    Movement = {
      x = x,
      y = y,
      turns = turns
    }
    return Movement
  end,

  dirtyBit = function (bool)
    DirtyBit = {
      bit = bool,
      --target contains key to the sprite x and y position coordinates
      target = {}
    }
    return DirtyBit
  end,

  --delay after you do something
  action = function (turns)
    Action = {
      turns = turns
    }
    return Action
  end,

  stats = function (movement)
    Stats = {
      movement = movement
    }
    return Stats
  end,

  directionControls = function (up,down,left,right)
    DirectionControls = {
      up = up,
      down = down,
      left = left,
      right = right
    }
    return DirectionControls
  end,

  --currently only used for quitting game
  gameControls = function (quit)
    GameControls = {
      quit = quit
    }
    return GameControls
  end,

  position = function (x,y)
    Position = {
      x = x,
      y = y
    }
    return Position
  end,

  camera = function (x,y)
    Camera = {
      x = x,
      y = y
    }
    return Camera
  end,

  cameraTarget = function (x,y)
    CameraTarget = {
      x = x,
      y = y
    }
    return CameraTarget
  end,

  chunks = function ()
    Chunks = {
      chunks = {}
    }
    return Chunks
  end

  --chunk width is the size of chunk whereas width and height are the number of
  --chunks wide/high the map is
  chunkData(chunkWidth, width, height, start)
    ChunkData = {
      chunkWidth = chunkWidth,
      width = width,
      height = height,
      start = start
    }
    return ChunkData
  end

  function builder(type,width,height)
    Builder = {
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
    ScrollData = {
      scrollPosition = 0,
      --if min/max is not nil scrollPosition cannot go below min and cannot go above max respectively
      scrollMin = min,
      scrollMax = max
    }
    return ScrollData
  end

  function debugData()
    DebugData = {
      expanded = false
    }
    return DebugData
  end

  function id(val)
    Id = {
      value = val
    }
    return Id
  end

  function mapMetaData()
    MapMetaData = {
      floor = floor
    }
    return MapMetaData
  end

  function genEntities()
    GenEntities = {
      generated = true
    }
    return GenEntities;
  end

  function classification(wipe)
    --used for determining some stuff like whether or not it gets removed when the next floor is generated
    Classification = {
      wipedOnNewFloor = wipe;
    }
    return Classification
  end

  function visible(visible)
    Visible = {
      visible = visible
    }
    return Visible
  end

  function toggleVisibleEvent(event)
    ToggleVisibleEvent = {
      event = event
    }
    return ToggleVisibleEvent
  end

  function window(width,height)
    Window = {
      width = width,
      height = height
    }
    return Window
  end

  function mouseCollider(width,height)
    MouseCollider = {
      width = width,
      height = height,
    }
    return MouseCollider
  end

  function hover()
    Hover = {
      hover = false
    }
    return Hover
  end

  --emits an event depending on certain situations
  --trigger is determined by other components attached to the entity
  function eventEmitter(event)
    EventEmitter = {
      event = event
    }
    return EventEmitter
  end

  --depending on how its named can perform different functions based on systems
  --ex. hoverSwap will swap sprite to alt when hovered
  function spriteSwap(default,alt)
    SpriteSwap = {
      default = default,
      alt = alt
    }
    return SpriteSwap
  end

  function collision(colliderType,colliderId)
    Collision = {
      colliderType = colliderType,
      colliderId = colliderId
    }
    return Collision
  end
}
