module(...,package.seeall)


systems = {}
deletedEntities = {}
index = 1;

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


Entities = {
  entities = {},
  components = {},
  add = function (self,entity)
    --generate new ID or re-use one of the deleted ones
    if #deletedEntities > 0 then
      id = table.remove(deletedEntities)
    else
      id = #(self.entities) + 1
    end
    --populate components tables with entity's components
    for name, component in pairs(entity) do
      if name ~= "_id" then
        if not(self.components[name]) then
          self.components[name] = {}
        end
        self.components[name][id] = component
      end
    end
    self.entities[id] = true
    return self:get(id)
  end,
  --filter trims the get to only relevant components that match the filter if filter doesn't match returns nil
  get = function (self,entityId,filter)
    filter = filter or nil
    if not(self.entities[entityId]) then
      return nil
    end
    local entity = {
      _id = entityId
    }
    if filter then
      for _,name in ipairs(filter) do
        if self.components[name][entityId] then
          entity[name] = matchedComp
        else
          entity = nil
          return nil
        end
      end
    else
      for name,component in pairs(self.components) do
        local entityComponent = component[entityId]
        if entityComponent then
          entity[name] = entityComponent
        end
      end
    end
    return entity
  end,
  remove = function (self,entity)
    local id = entity
    if type(entity) == "table" then
      id = entity._id
    end
    self.entities[id] = nil
    for name,component in pairs(self.components) do
      component[id] = nil
    end
    table.insert(deletedEntities,id)
  end,
  --mostly just to add new components to an existing entity if you have the entity object,
  --not super efficient
  update = function (self,entity)
    local id = entity._id
    --populate components tables with entity's components
    for name, component in pairs(entity) do
      if not(self.components[name]) then
        self.components[name] = {}
      end
      self.components[name][id] = component
    end
    return self:get(id)
  end,
  --returns true if the filter matches, takes entity or entityId
  filter = function (self,entity,filter)
    local id = entity
    if type(entity) == "table" then
      id = entity._id
    end
    for _,component in ipairs(filter) do
      if not(self.components[component][id]) then
        return false
      end
    end
    return true
  end,
  --returns array of filtered Entities
  --onlyIds optional, defaults to true, if true will only select ids in array
  --trim optional, if true will only select components in the filter rather than all components
  filterAll = function (self,filter,onlyIds,trim)
    onlyIds = onlyIds or true
    local getFilter = nil
    if trim then
      getFilter = filter
    end
    local list = {}
    for id,_ in pairs(self.entities) do
      if self:filter(id,filter) then
        if onlyIds then
          table.insert(list,id)
        else
          table.insert(list,self:get(id,getFilter))
        end
      end
    end
  end
}

Systems = {
  systems = {
  },
  run = function (self,entity,type,...)
    local runSystems = self.systems[type]

  end,
  new = function (self,type,file,requireAll,updateRequired)
    if requireAll == nil then
      requireAll = true
    end
    if not(self.systems[type]) then
      self.systems[type] = {}
    end
    table.insert(self.systems[type],
    {
      update = file.update,
      filter = file.filter,
      requireAll = requireAll,
      updateRequired = updateRequired or false,
      enabled = true,
    })
  end,
}

function initializeSystems()
  --update Systems
  local type = "update"
  Systems:new(type,BuildMap,true,true)
  Systems:new(type,BuildChunk,true,true)
  Systems:new(type,CombineChunks,true,true)
  Systems:new(type,GenerateEntities,true,true)
  Systems:new(type,UpdateBatch,true,true)
  Systems:new(type,Collision,true,true)
  --collisions
  Systems:new(type,StairCollision,true,true)
  Systems:new(type,RemoveCollisions,true,true)
  --draw systems
  type = "draw"
  Systems:new(type,CameraFollow,true,true)
  Systems:new(type,MultiDraw,true,true)
  Systems:new(type,StaticDraw,true,true)
  Systems:new(type,WindowDraw,true,true)
  Systems:new(type,OverlayDraw,true,true)
  Systems:new(type,Debug,true,true)
  --event systems
  type = "event"
  Systems:new(type,ToggleVisibleEvent,true,true)
  --turn systems
  Systems:new(type,ActionStep,true,true)
  Systems:new(type,Movement,true,true)
  --key up systems
  type = "keyUp"
  Systems:new(type,PlayerControl,true,true)
  Systems:new(type,DebugExpand,true,true)
  --mouse click systems
  type = "click"
  Systems:new(type,ButtonClick,true,true)
  --scroll systems
  type = "scroll"
  Systems:new(type,ScrollBar,true,true)
end
