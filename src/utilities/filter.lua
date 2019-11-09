module(...,package.seeall)
function filter(filterList)
  local Filter = {
    filters = filterList,
  }
  --checks if an entity has a set of components
  function Filter:fit(entity)
    fit = true
    for _,component in pairs(filterList) do
      fit = fit and entity[component]
    end
    return fit
  end

  function Filter:debug(entity)
    fit = true
    for _,component in pairs(filterList) do
      if not(fit and entity[component]) then
        print(component)
      end
      fit = fit and entity[component]
    end
  end

  function Filter:allFit(entities)
    result = {}
    count = 0
    for _,entity in ipairs(entities) do
      if self:fit(entity) then
        table.insert(result,entity)
        count = count + 1
      end
    end
    print(count)
    return result;
  end

  return Filter
end
