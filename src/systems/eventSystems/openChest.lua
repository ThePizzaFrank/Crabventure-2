module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities
ChestInventory = require("src.entities.chestInventory")
filter = Filter.filter({"inventory"})

function update(entity,event,entityId)
  if event == "openChest" and entity._id == entityId then
    camera = entity.camera or {x=0,y=0}
    position = entity.position or {x=0,y=0}
    Entities:bulkAdd(ChestInventory.chestMenu(entity._id,entity.inventory,camera,position.x,position.y))
  end
end
