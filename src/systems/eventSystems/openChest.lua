module(...,package.seeall)
Filter = require("src.utilities.filter")

filter = Filter.filter({"inventory"})

function update(entity,event,entityId)
  if event == "openChest" and entity._id == entityId then
    print("Opened: ",entityId)
  end
end
