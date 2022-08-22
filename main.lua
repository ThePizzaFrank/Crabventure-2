module(...,package.seeall)

--we want nearest neighbor when filtering
love.graphics.setDefaultFilter( "nearest","nearest" )

Filter = require("src.utilities.filter")
ECS = require("src.utilities.entityComponentSystems")
SystemLoader = require("src.utilities.systemLoader")
Maze = require("src.utilities.maze")
--entities
StaticTexturedCollisionMap = require("src.entities.staticTexturedCollisionMap")
StaticTCMGrower = require("src.entities.staticTCMGrower")
MapGenerator = require("src.entities.mapGenerator")
PlayerInventory = require("src.entities.playerInventory")
Staircase = require("src.entities.staircase")
Chest = require("src.entities.chest")
--component
Components = require("src.components")
--Some global vars
globals = require('src.utilities.globals')

Debug = require("src.systems.debug")

Entities = ECS.Entities
Systems = ECS.Systems



function love.load(arg)

  world = {}
  SystemLoader.initializeSystems()
  eventHandler = function (event,arg1,arg2)
    Systems:run("event",event,arg1,arg2)
    --for _,v in ipairs(EventSystems) do
      --v.update(world,event,arg1,arg2)
    --end
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
    stats = Components.stats(6, 100),
    directionControls = Components.directionControls("w","s","a","d"),
    gameControls = Components.gameControls("`","e","escape"),
    collider = Components.collider(globals.CollisionEnum.Player),
    cameraTarget = Components.cameraTarget(-love.graphics.getWidth()/2,-love.graphics.getHeight()/2),
    damageable = Components.damageable(),
    canAttack = Components.canAttack(10),
    alliance = Components.alliance(1)
  }
  blob2 = {
    _type = "Individual Wall",
    sprite = Components.sprite("wall_1"),
    position = Components.position(12,10),
    camera = camera,
    collider = Components.collider(globals.CollisionEnum.Wall)
  }
  blob3 = {
    _type = "Enemy",
    sprite = Components.sprite("enemy"),
    position = Components.position(),
    action = Components.action(0),
    camera = camera,
    collider = Components.collider(globals.CollisionEnum.Enemy),
    ai = Components.ai(1,blob.position),
    stats = Components.stats(7, 100),
    damageable = Components.damageable(),
    canAttack = Components.canAttack(5),
    alliance = Components.alliance(2)
  }

  inventory = PlayerInventory.playerInventory()
  mGen = MapGenerator.mapGenerator(10,5,5,{x = 1,y = 1},0)
  mGen.camera = camera
  mGen.spriteMap.mapping[1] = {"wall_1","wall_2"}
  mGen.spriteMap.mapping[0] = {"floor_1"}
  stair = Staircase.staircase()
  chestStatic = Chest.chest(6,6,camera)
  chest = Chest.chest()
  table.insert(mGen.mapData.requiredEntities,stair)
  table.insert(mGen.mapData.requiredEntities,chest)
  table.insert(mGen.mapData.requiredEntities,blob3)
  Entities:add(blob)
  Entities:add(mGen)
  Entities:add(debugScroller)
  Entities:add(inventory)
  --Entities:add()
  --table.insert(world,builder)
end

function love.draw()
  Systems:run("draw")
end

function blockFPS(max,dt) -- Call this function in love.update
	if dt < 1/max then
		love.timer.sleep(1/max-dt)
	end
end

function love.update(dt)
  blockFPS(60,dt)
  Systems:run("update")
  --for _,v in ipairs(UpdateSystems) do
    --v.update(world)
  --end
  if Systems:run("special") > 0 then
    takeTurn()
  end
end

function takeTurn()
  Systems:run("turn")
  --for _,v in ipairs(TurnSystems) do
    --v.update(world)
  --end
end

function love.keyreleased(key)
  Systems:run("keyUp",key)
    --for _,v in ipairs(KeyUpSystems) do
      --v.update(world,key)
    --end
end

function love.wheelmoved(x, y)
  Systems:run("scroll",y)
  --for _,v in ipairs(ScrollSystems) do
    --v.update(world,y)
  --end
end

function love.mousereleased(x, y, button, isTouch)
  if button == 1 then
    Systems:run("click",x,y,button)
  end
  --if button == 1 then
    --for _,v in ipairs(MouseClickSystems) do
      --v.update(world,x,y,button)
    --end
  --end
end
