module(...,package.seeall)

globals = require('src.utilities.globals')

function player()
  return {}
end

function collider(type)
  Collider = {
    width = 1,
    height = 1,
    type = type,
    active = true,
    id = globals.currentCollider
  }
  globals.currentCollider = globals.currentCollider + 1
  return Collider
end

function collisionMap()
  CollisionMap = {
    map = {}
  }
  return CollisionMap
end

function sprite(key)
  Sprite = {
    key = key
  }
  return Sprite
end

function spriteMap()
  SpriteMap = {
    mapping = {}
  }
  return SpriteMap
end

function batchMap()
  BatchMap = {
    mapping = {}
  }
  return BatchMap
end

function movement(x,y, turns)
  Movement = {
    x = x,
    y = y,
    turns = turns
  }
  return Movement
end

function dirtyBit(bool)
  DirtyBit = {
    bit = bool,
    target = {}
  }
  return DirtyBit
end

--delay after you do something
function action(turns)
  Action = {
    turns = turns
  }
  return Action
end

function stats(movement)
  Stats = {
    movement = movement
  }
  return Stats
end

function directionControls(up,down,left,right)
  DirectionControls = {
    up = up,
    down = down,
    left = left,
    right = right
  }
  return DirectionControls
end

function position(x,y)
  Position = {
    x = x,
    y = y
  }
  return Position
end

function camera(x,y)
  Camera = {
    x = x,
    y = y
  }
  return Camera
end

function cameraTarget(x,y)
  CameraTarget = {
    x = x,
    y = y
  }
  return CameraTarget
end
