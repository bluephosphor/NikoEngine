Instance = {
  counter = 1,
  lookupTable = {}
}

Instance.assign = function(inst)
  inst.id = Instance.counter

  table.insert(Instance.lookupTable, inst.id, inst)
  Instance.counter = Instance.counter + 1
end

Instance.exists = function(who)
  return who and Instance.lookupTable[who.id] and true or false
end

Instance.destroy = function(id)

  --remove from steporder
  StepOrder.remove(id)
  
  --remove from draworder
  local _flag = false
  for key, t in pairs(DrawOrder) do
    _flag = t.remove(id)
    if _flag then break end
  end
  
  --remove form lookup table
  table.remove(Instance.lookupTable, id)
end

Instance.list = function()

  for key, value in pairs(Instance.lookupTable) do
    print(key, ': ', value.name, value)
    print('id: ', value.id)
  end

end