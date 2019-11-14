module(...,package.seeall)
Filter = require("src.utilities.filter")
Maze = require("src.utilities.maze")
--entities
StaticTexturedCollisionMap = require("src.entities.staticTexturedCollisionMap")
staticTCMGrower = require("src.entities.staticTCMGrower")
--component
Components = require("src.components")
--systems
StaticDraw = require("src.systems.staticDraw")
MultiDraw = require("src.systems.multiDraw")
UpdateBatch = require("src.systems.updateBatch")
PlayerControl = require("src.systems.playerControl")
PlayerAction = require("src.systems.playerAction")
ActionStep = require("src.systems.actionStep")
Movement = require("src.systems.movement")
Collision = require("src.systems.collision")
CameraFollow = require("src.systems.cameraFollow")
BuildMap = require("src.systems.buildMap")
Debug = require("src.systems.debug")
--Some global vars
globals = require('src.utilities.globals')



UpdateSystems = {
  BuildMap,
  UpdateBatch,
  Collision
}

TurnSystems = {
  ActionStep,
  Movement
}

DrawSystems = {
  CameraFollow,
  MultiDraw,
  StaticDraw,
  Debug
}

KeyUpSystems = {
  PlayerControl
}

function love.load(arg)
  world = {}
  --global components
  camera = Components.camera(0,0)
  gameInfo = Components.gameInfo

  blob = {
    player = Components.player(),
    sprite = Components.sprite("enemy"),
    position = Components.position(10,10),
    camera = camera,
    action = Components.action(0),
    stats = Components.stats(6),
    directionControls = Components.directionControls("w","s","a","d"),
    collider = Components.collider(globals.CollisionEnum.Player),
    cameraTarget = Components.cameraTarget(-love.graphics.getWidth()/2,-love.graphics.getHeight()/2)
  }
  blob2 = {
    sprite = Components.sprite("wall_1"),
    position = Components.position(12,10),
    camera = camera,
    collider = Components.collider(globals.CollisionEnum.Wall)
  }
  builder = staticTCMGrower.staticTCMGrower()
  builder.builder.types = {1,2,5}
  builder.builder.parameters[3] = {width = 3, sPos = {x = 3, y = 14}, ePos = {x = 14,y = 3}}
  builder.builder.parameters[4] = {width = 3, height = 1, position = {x = 3, y = 10}}
  builder.builder.width = 16
  builder.builder.height = 16
  builder.spriteMap.mapping[1] = {"wall_1","wall_2"}
  builder.spriteMap.mapping[0] = {"floor_1"}
  builder.camera = camera
  multiblob = StaticTexturedCollisionMap.staticTexturedCollisionMap()
  table.insert(multiblob.dirtyBit.target, {x = 1*globals.tileSize,y = 3*globals.tileSize})
  multiblob.camera = camera
  table.insert(world,blob)
  --table.insert(world,blob2)
  table.insert(world,builder)
  Maze.maze1(4,4,{x = 1,y = 1})
end

function love.draw()
  for _,v in pairs(DrawSystems) do
    v.update(world)
  end
  love.graphics.print(globals.turns,0,0)
end

function love.update(dt)
  for _,v in ipairs(UpdateSystems) do
    v.update(world)
  end
  for x = 0, PlayerAction.update(world)-1 do
    takeTurn()
    globals.turns = globals.turns + 1
  end
end

function takeTurn()
  for _,v in ipairs(TurnSystems) do
    v.update(world)
  end
end

function love.keyreleased(key)
    for _,v in ipairs(KeyUpSystems) do
      v.update(world,key)
    end
end
