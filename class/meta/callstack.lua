function CallStack(type)
  local _c = {
    list = {},
    idcounter = 0
  }

  _c.add = function(who)
    table.insert(_c.list, who.id)
  end

  _c.remove = function(id)
    for index, value in ipairs(_c.list) do
      if value == id then
        table.remove(_c.list, index)
        return true
      end
    end
    return false
  end

  _c.eval = function()
    for index, value in ipairs(_c.list) do
      local _inst = Instance.lookupTable[value]
      if _inst then _inst[type]() end
    end
  end
  
  return _c
end