module(...,package.seeall)
Filter = require("src.utilities.filter")
Entities = require("src.utilities.entityComponentSystems").Entities

globals = require('src.utilities.globals')

filter = Filter.filter({"scrollData","debugData"})


function update(entity)
  local i = 0
  local sp = entity.scrollData.scrollPosition
  local ln = 1
  local fps = love.timer.getFPS( )
  local expanded = entity.debugData.expanded
  love.graphics.print(globals.turns,0,0)
  love.graphics.print(fps,0,13)
  for entityId,_ in pairs(Entities.entities) do
    menuEntity = Entities:get(entityId)
    i = i + 1
    ln = ln + 1
    if menuEntity._type == nil then
      love.graphics.print("entity unknown",0,13*(ln+sp))
    else
      love.graphics.print("entity "..menuEntity._type,0,13*(ln+sp))
    end
    for name,componentValue in pairs(menuEntity) do
      ln = ln + 1
      if expanded then
        if type(componentValue) == "table" then
          love.graphics.print("\t".. name,0,13*(ln+sp))
          for varname,val in pairs(componentValue) do
            ln = ln + 1
            printVariable = tostring(val)
            love.graphics.print("\t\t".. varname,0,13*(ln+sp))
            love.graphics.print(printVariable,200,13*(ln+sp))
          end
        else
          love.graphics.print("\t".. name .. "\t\t" .. tostring(componentValue),0,13*(ln+sp))
        end
      else
        love.graphics.print("\t".. name,0,13*(ln+sp))
      end
    end
  end
end
