module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"userInterface"})

function update(entity,event)
  if event == "closeAll" and entity.userInterface.open then
    for _,id in pairs(entity.userInterface.elements) do
      childEntity = Entities:get(id,Filter.filter({"interfaceVisible"}))
      if childEntity then
        childEntity.interfaceVisible.visible = not(childEntity.interfaceVisible.visible)
      end
    end
    entity.userInterface.open = false
  end
end
