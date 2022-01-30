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
  --remove form lookup table
  table.remove(Instance.lookupTable, id)

  --remove from steporder
  StepOrder.remove(id)

  --remove from draworder
  for key, t in pairs(DrawOrder) do
    t.remove(id)
  end
end