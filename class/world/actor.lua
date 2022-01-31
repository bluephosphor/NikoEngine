function NewActor(x,y)
  local _a = NewEntity(x,y)
  _a.name = _a.name .. '-> Actor'
  -- local _step_inherited = _a.step
  -- _a.step = function()
  --  _step_inherited()
  -- end

  _a.setAnimation = function(anim)
    if _a.animations.current == anim then return end
    _a.animations.current = anim
    _a.sprite.setAnimation(anim)
  end
  
  return _a
end