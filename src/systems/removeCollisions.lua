module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

filter = Filter.filter({"collision"})

function update(entity)
  Entities:removeComponent(entity._id,"collision")
end
