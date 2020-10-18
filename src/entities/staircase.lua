module(...,package.seeall)

Components = require("src.components")
MapGenerator = require("src.entities.mapGenerator")
Filter = require("src.utilities.filter")
globals = require("src.utilities.globals")

function staircase(x,y)
  Stairs = {
    _type = "Staircase",
    classification = Components.classification(true),
    sprite = Components.sprite("stairs"),
    position = Components.position(x,y),
    camera = camera,
    collider = Components.collider(globals.CollisionEnum.Object)
  }

  --for now the staircase is a collider object but later I intend for it to be an interactable object
  --interaction just hasnt been implemented yet
  Stairs.collider.colfunc = function(e1,e2,world)
    --only trigger if its a player collider, we dont want this to work on enemies or something else\
    print(e2.collider.type,e2._type)
    if e2.collider.type == globals.CollisionEnum.Player then


      --look for entities to wipe
      local mapFilter = Filter.filter({"classification"})
      for key,entity in pairs(world) do
        if mapFilter:fit(entity) then
          --remove entities that get wiped on load
          if entity.classification.wipedOnNewFloor then
            world[key] = nil
          end

        end
      end

      --grab the player for later
      player = nil
      local playerFilter = Filter.filter({"player","position","camera"})
      for key,entity in pairs(world) do
        if playerFilter:fit(entity) then
          player = entity
        end
      end

      --generate new map and move player
      --maybe move player after world is fully gen'd to add some spice to spawn location
      --will do later
      if player ~= nil then
        --create another generator and insert it into the world
        mGen = MapGenerator.mapGenerator(10,5,5,{x = 1,y = 1},0)
        --set camera to stair camera
        mGen.camera = player.camera
        mGen.spriteMap.mapping[1] = {"wall_1","wall_2"}
        mGen.spriteMap.mapping[0] = {"floor_1"}
        table.insert(world,mGen)

        --move player
        player.position.x = 5
        player.position.y = 5
      end
    end
  end

  return Stairs
end
