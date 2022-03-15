module(...,package.seeall)
Filter = require("src.utilities.filter")

filter = Filter.filter({"classification"})

function update(world,event,e1,e2)
  if event == "sa" then
    for key,entity in pairs(world) do
      if filter:fit(entity) then

      end
    end
  end
end
