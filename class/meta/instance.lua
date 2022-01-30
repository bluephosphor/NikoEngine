Instance = {
  counter = 0,
  lookupTable = {}
}

Instance.assign = function(inst)
  inst.id = Instance.counter

  table.insert(Instance.lookupTable, inst.id, inst)
  Instance.counter = Instance.counter + 1
end

Instance.destroy = function(id)
  --remove form lookup table
  local _inst = table.remove(Instance.lookupTable, id)

  --remove from steporder
  for index, value in ipairs(StepOrder.list) do
    if value.id == id then
      table.remove(StepOrder.list, index)
      break
    end
  end

  --remove from draworder
  for key, t in pairs(DrawOrder) do
    for index, value in ipairs(t.list) do
      if value.id == id then
        table.remove(t.list, index)
        break
      end
    end
  end

  _inst = nil
end