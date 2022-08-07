module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities
ChestInventory = require("src.entities.chestInventory")
filter = Filter.filter({"userInterface"})

function update(entity,event,entityId)
  if event == entity.userInterface.openEvent then
    if not(entity.userInterface.open) then
      local entities = Entities:filterAll(filter,false,true)
      for _,e in pairs(entities) do
        if e.userInterface.open then
          for _,id in pairs(e.userInterface.elements) do
            childEntity = Entities:get(id,Filter.filter({"interfaceVisible"}))
            if childEntity then
              childEntity.interfaceVisible.visible = not(childEntity.interfaceVisible.visible)
            end
          end
          e.userInterface.open = false
        end
      end
    end

    for _,id in pairs(entity.userInterface.elements) do
      childEntity = Entities:get(id,Filter.filter({"interfaceVisible"}))
      if childEntity then
        childEntity.interfaceVisible.visible = not(childEntity.interfaceVisible.visible)
      end
    end
    entity.userInterface.open = not(entity.userInterface.open)
  end
end
