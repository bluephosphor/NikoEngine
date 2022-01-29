require "class.entity"

function NewActor(x,y)
  local _actor = NewEntity(x,y)
  
  
  -- local _step_inherited = _actor.step
  -- _actor.step = function()
  --  _step_inherited()
  -- end
  
  return _actor
end