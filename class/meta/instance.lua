Instance = {
  counter = 1,
  lookupTable = {}
}

Instance.create = function(obj, drawOrder)
  obj.id = 'inst_' .. Instance.counter
  obj.myDrawOrder = drawOrder
  obj.children = {}
  Instance.counter = Instance.counter + 1

  Instance.lookupTable[obj.id] = obj
  StepOrder.add(obj)
  drawOrder.add(obj)
  return obj
end

Instance.exists = function(who)
  return who and Instance.lookupTable[who.id] and true or false
end

Instance.destroy = function(who)

  --remove from steporder
  StepOrder.remove(who.id)
  
  --remove from draworder
  who.myDrawOrder.remove(who.id)
  
  --remove form lookup table
  Instance.lookupTable[who.id] = nil

  --remove children
  for index, value in ipairs(who.children) do
    Instance.destroy(value)
  end

  who = nil
end

Instance.list = function()
  print('---ACTIVE INSTANCES---')
  for key, value in pairs(Instance.lookupTable) do
    print(key .. ': ' .. value.name)
  end
  print('---')
end