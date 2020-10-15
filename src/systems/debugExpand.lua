module(...,package.seeall)

Components = require("src.components")
Filter = require("src.utilities.filter")

local filter = Filter.filter({"debugData"})

function update(world,key)
  for _,entity in pairs(world) do
    if filter:fit(entity) then
      if key == "x" then
        entity.debugData.expanded = not(entity.debugData.expanded)
      end
    end
  end
end
