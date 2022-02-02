function NewActor(x,y)
  local _a = NewEntity(x,y)
  _a.name = _a.name .. '-> Actor'
  -- local _step_inherited = _a.step
  -- _a.step = function()
  --  _step_inherited()
  -- end
  
  return _a
end