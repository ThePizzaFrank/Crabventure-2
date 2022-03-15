module(...,package.seeall)


systems = {}
deletedEntities = {}
index = 1;


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
      if name ~= "_id" and name ~= "_type" then
        if not(self.components[name]) then
          self.components[name] = {}
        end
        self.components[name][id] = component
      end
    end
    local entityType = entity._type
    if not(entityType) then
      entityType = "entity"
    end
    self.entities[id] = entityType
    return self:get(id)
  end,
  --filter trims the get to only relevant components that match the filter if filter doesn't match returns nil
  get = function (self,entityId,filter)
    filter = filter or nil
    if not(self.entities[entityId]) then
      return nil
    end
    local entity = {
      _id = entityId,
      _type = self.entities[entityId]
    }
    if filter then
      for _,name in ipairs(filter.filters) do
        local matchedComp = self.components[name][entityId]
        if matchedComp then
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
    --delete all existing components
    for _, components in pairs(self.components) do
      components[id] = nil
    end
    --repopulate components tables with entity's components
    for name, component in pairs(entity) do
      if name ~= "_id" and name ~= "_type" then
        if not(self.components[name]) then
          self.components[name] = {}
        end
        self.components[name][id] = component
      end
    end
    if entity._type then
      self.entities[id] = entity._type
    end
    return self:get(id)
  end,
  --returns true if the filter matches, takes entity or entityId
  filter = function (self,entity,filter)
    local id = entity
    if type(entity) == "table" then
      id = entity._id
    end
    for _,component in ipairs(filter.filters) do
      if not(self.components[component] and self.components[component][id]) then
        return false
      end
    end
    return true
  end,
  --returns array of filtered Entities
  --onlyIds optional, defaults to true, if true will only select ids in array
  --trim optional, if true will only select components in the filter rather than all components
  filterAll = function (self,filter,onlyIds,trim)
    local getFilter = nil
    if onlyIds == nil then
      onlyIds = true
    end
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
    return list
  end,
  getComponent = function (self,entityId,componentName)
    return self.components[componentName][entityId]
  end,
  addComponent = function (self,entityId,componentName,component)
    if not(self.components[componentName]) then
      self.components[componentName] = {}
    end
    self.components[componentName][entityId] = component
  end,
  removeComponent = function (self,entityId,componentName)
    self.components[componentName][entityId] = nil
  end,
  exists = function (self,entityId)
    return self.entities[entityId] ~= nil
  end
}

Systems = {
  systems = {
  },
  run = function (self,type,...)
    local args = {...}
    local runSystems = self.systems[type]
    for _,system in pairs(runSystems) do
      if system.enabled then
        for k,entity in pairs(Entities:filterAll(system.filter,false,not(system.requireAll))) do
          --a check to make sure the entity hasn't been deleted
          --also check system is enabled again just in case system disables itself
          if Entities:exists(entity._id) and system.enabled then
            local update = system.update(entity,args[1],args[2],args[3],args[4])
            if(type == "special") then
              return update
            end
            if system.updateRequired and Entities:exists(entity._id) then
              Entities:update(entity)
            end
          end
        end
      end
    end
  end,
  new = function (self,type,file,requireAll,updateRequired)
    if requireAll == nil then
      requireAll = true
    end
    if not(self.systems[type]) then
      self.systems[type] = {}
    end
    local newSystem = {
      update = file.update,
      filter = file.filter,
      requireAll = requireAll,
      updateRequired = updateRequired or false,
      enabled = true,
    }
    table.insert(self.systems[type],newSystem)
    return newSystem
  end,
}
