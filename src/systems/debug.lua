module(...,package.seeall)

Filter = require("src.utilities.filter")

local filter = Filter.filter({"scrollData","debugData"})

function update(world)
  i = 0
  sp = 0
  ln = 0
  expanded = false
  for _,entity in ipairs(world) do
    if(filter:fit(entity)) then
      sp = entity.scrollData.scrollPosition
      expanded = entity.debugData.expanded
    end
  end
  for _,entity in ipairs(world) do
    i = i + 1
    ln = ln + 1
    if entity._type == nil then
      love.graphics.print("entity unknown",0,13*(ln+sp))
    else
      love.graphics.print("entity "..entity._type,0,13*(ln+sp))
    end
    for name,componentValue in pairs(entity) do
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
