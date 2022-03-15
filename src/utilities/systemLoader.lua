module(...,package.seeall)
Systems = require("src.utilities.entityComponentSystems").Systems
globals = require("src.utilities.globals")

--load your systems in here
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
ResetWorld = require("src.systems.eventSystems.resetWorld")
Interact = require("src.systems.eventSystems.interact")
OpenChest = require("src.systems.eventSystems.openChest")

function initializeSystems()
  --update Systems
  local type = "update"
  Systems:new(type,BuildMap,true,false)
  Systems:new(type,BuildChunk,true,true)
  Systems:new(type,CombineChunks,false,false)
  Systems:new(type,GenerateEntities,true,false)
  Systems:new(type,UpdateBatch,true,false)
  Systems:new(type,Collision,true,false)
  --collisions
  Systems:new(type,StairCollision,true,false)
  Systems:new(type,RemoveCollisions,true,false)
  --draw systems
  type = "draw"
  Systems:new(type,CameraFollow,true,false)
  Systems:new(type,MultiDraw,true,false)
  Systems:new(type,StaticDraw,true,false)
  Systems:new(type,WindowDraw,true,false)
  Systems:new(type,OverlayDraw,true,false)
  Systems:new(type,Debug,true,false)
  --event systems
  type = "event"
  Systems:new(type,ToggleVisibleEvent,true,false)
  Systems:new(type,ResetWorld,true,false)
  Systems:new(type,Interact,true,false)
  Systems:new(type,OpenChest,true,false)
  --turn systems
  Systems:new(type,ActionStep,true,false)
  Systems:new(type,Movement,true,false)
  --key up systems
  type = "keyUp"
  Systems:new(type,PlayerControl,true,false)
  Systems:new(type,DebugExpand,true,false)
  --mouse click systems
  type = "click"
  Systems:new(type,ButtonClick,true,false)
  --scroll systems
  type = "scroll"
  Systems:new(type,ScrollBar,true,false)
  --special
  type = "special"
  Systems:new(type,PlayerAction,true,false)
  --turns
  type = "turn"
  Systems:new(type,ActionStep,true,false)
  Systems:new(type,Movement,true,false)
end
