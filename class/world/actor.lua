function NewActor(_x,_y)
  local _a = NewEntity(_x,_y)
  _a.name = _a.name .. '-> Actor'

  return _a
end