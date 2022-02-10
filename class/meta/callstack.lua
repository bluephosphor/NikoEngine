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

  _c.eval = function(dt)
    for index, value in ipairs(_c.list) do
      local _inst = Instance.lookupTable[value]
      if _inst then
        if string.find(value, "_MODEL") then
          _inst:draw(_inst.spshader and _inst.spshader or nil)
        else
          if _inst[type] then _inst[type](dt and dt or nil) end
        end
      end
    end
  end

  return _c
end