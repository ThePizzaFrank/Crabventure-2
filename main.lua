module(...,package.seeall)

--we want nearest neighbor when filtering
love.graphics.setDefaultFilter( "nearest","nearest" )

Filter = require("src.utilities.filter")
Maze = require("src.utilities.maze")
--entities
StaticTexturedCollisionMap = require("src.entities.staticTexturedCollisionMap")
StaticTCMGrower = require("src.entities.staticTCMGrower")
MapGenerator = require("src.entities.mapGenerator")
Inventory = require("src.entities.inventory")
--component
Components = require("src.components")
--systems
OverlayDraw = require("src.systems.overlayDraw")
StaticDraw = require("src.systems.staticDraw")
MultiDraw = require("src.systems.multiDraw")
WindowDraw = require("src.systems.windowDraw")
UpdateBatch = require("src.systems.updateBatch")
PlayerControl = require("src.systems.playerControl")
PlayerAction = require("src.systems.playerAction")
ActionStep = require("src.systems.actionStep")
Movement = require("src.systems.movement")
Collision = require("src.systems.collision")
CameraFollow = require("src.systems.cameraFollow")
BuildChunk = require("src.systems.buildChunk")
BuildMap = require("src.systems.buildMap")
Debug = require("src.systems.debug")
ScrollBar = require("src.systems.scrollBar")
CombineChunks = require("src.systems.combineChunks")
DebugExpand = require("src.systems.debugExpand")
GenerateEntities = require("src.systems.generateEntities")
ButtonClick = require("src.systems.buttonClick")
StairCollision = require("src.systems.stairCollision")
RemoveCollisions = require("src.systems.removeCollisions")
--event systems
ToggleVisibleEvent = require("src.systems.eventSystems.toggleVisibleEvent")
--Some global vars
globals = require('src.utilities.globals')

UpdateSystems = {
  BuildMap,
  BuildChunk,
  CombineChunks,
  GenerateEntities,
  UpdateBatch,
  Collision,
  --Collisions
  StairCollision,
  RemoveCollisions,
}

EventSystems = {
  ToggleVisibleEvent
}

TurnSystems = {
  ActionStep,
  Movement
}

DrawSystems = {
  CameraFollow,
  MultiDraw,
  StaticDraw,
  WindowDraw,
  OverlayDraw,
  Debug
}

KeyUpSystems = {
  PlayerControl,
  DebugExpand
}

MouseClickSystems = {
  ButtonClick
}

ScrollSystems = {
  ScrollBar
}

function love.load(arg)

  world = {}

  eventHandler = function (event,arg1,arg2)
    for _,v in ipairs(EventSystems) do
      v.update(world,event,arg1,arg2)
    end
  end

  love.handlers["gameEvent"] = eventHandler
  --global components
  camera = Components.camera(0,0)
  gameInfo = Components.gameInfo

  debugScroller = {
    _type = "Debug Scroller",
    classification = Components.classification(false),
    scrollData = Components.scrollData(nil,0),
    debugData = Components.debugData()
  }

  blob = {
    _type = "Player",
    classification = Components.classification(false),
    player = Components.player(),
    sprite = Components.sprite("crab"),
    position = Components.position(5,5),
    camera = camera,
    action = Components.action(0),
    stats = Components.stats(6),
    directionControls = Components.directionControls("w","s","a","d"),
    gameControls = Components.gameControls("escape"),
    collider = Components.collider(globals.CollisionEnum.Player),
    cameraTarget = Components.cameraTarget(-love.graphics.getWidth()/2,-love.graphics.getHeight()/2)
  }
  blob.collider.colfunc = function(e1,e2,world)
    movement = Filter.filter({"movement"})
    if movement:fit(e1) then
      e1.movement = nil
    end
  end
  blob2 = {
    _type = "Individual Wall",
    sprite = Components.sprite("wall_1"),
    position = Components.position(12,10),
    camera = camera,
    collider = Components.collider(globals.CollisionEnum.Wall)
  }
  inventory = Inventory.inventory()
  inventoryCloseButton = Inventory.inventoryCloseButton()

  mGen = MapGenerator.mapGenerator(10,5,5,{x = 1,y = 1},0)
  mGen.camera = camera
  mGen.spriteMap.mapping[1] = {"wall_1","wall_2"}
  mGen.spriteMap.mapping[0] = {"floor_1"}
  table.insert(world,blob)
  table.insert(world,mGen)
  table.insert(world,debugScroller)
  table.insert(world,inventoryCloseButton)
  table.insert(world,inventory)
  --table.insert(world,builder)
end

function love.draw()
  for _,v in pairs(DrawSystems) do
    v.update(world)
  end
end

function love.update(dt)
  for _,v in ipairs(UpdateSystems) do
    v.update(world)
  end
  --[[
  --checks if there are any events
  hasEvents = false
  for n, a, b, c, d, e, f in love.event.poll() do
    hasEvents = true
    break
  end
  --if there are no events then we don't have to run through all the event systems
  --and improve performance!
  if hasEvents then
    for _,v in ipairs(EventSystems) do
      v.update(world,love.event.poll())
    end
  end
  ]]
  if PlayerAction.update(world) > 0 then
    takeTurn()
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

function love.wheelmoved(x, y)
  for _,v in ipairs(ScrollSystems) do
    v.update(world,y)
  end
end

function love.mousereleased(x, y, button, isTouch)
  if button == 1 then
    for _,v in ipairs(MouseClickSystems) do
      v.update(world,x,y,button)
    end
  end
end
