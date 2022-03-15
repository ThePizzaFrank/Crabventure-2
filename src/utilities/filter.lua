module(...,package.seeall)
function filter(filterList,optional)
  local Filter = {
    filters = filterList,
    optional = optionals,
  }
  function Filter:debug(entity)
    fit = true
    for _,component in pairs(filterList) do
      if not(fit and entity[component]) then
        print(component)
      end
      fit = fit and entity[component]
    end
  end

  return Filter
end
