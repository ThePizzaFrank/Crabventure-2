module(...,package.seeall)

function update(world)
  i = 0;
  for _,entity in ipairs(world) do
    i = i + 1
    love.graphics.print("entity"..i,0,12*i)
    for name,_ in pairs(entity) do
      i = i + 1
      love.graphics.print("\t".. name,0,12*i)
    end
  end
end
