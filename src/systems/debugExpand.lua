module(...,package.seeall)

Components = require("src.components")
Filter = require("src.utilities.filter")

filter = Filter.filter({"debugData"})

function update(entity,key)
  if key == "x" then
    entity.debugData.expanded = not(entity.debugData.expanded)
  end
end
