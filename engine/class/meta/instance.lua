Instance = {
  counter = 1,
  lookupTable = {}
}

Instance.create = function(obj, stepOrder, drawOrder)
  obj.id = 'inst_' .. Instance.counter
  obj.myStepOrder = stepOrder
  obj.myDrawOrder = drawOrder
  obj.children = {}
  Instance.counter = Instance.counter + 1

  Instance.lookupTable[obj.id] = obj
  stepOrder.add(obj)
  drawOrder.add(obj)

  obj.preDestroy = function() end

  return obj
end

Instance.exists = function(who)
  local _v = who and Instance.lookupTable[who.id] and true or false
  Shell.log(_v and 'true' or 'false')
  return _v
end

Instance.destroy = function(who)
  --do any necessary cleanup
  who.preDestroy()

  --remove from steporder
  who.myStepOrder.remove(who.id)

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
  Shell.log('---ACTIVE INSTANCES---')
  for key, value in pairs(Instance.lookupTable) do
    Shell.log(key .. ': ' .. value.name)
  end
  Shell.log('---')
end