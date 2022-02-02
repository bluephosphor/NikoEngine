function NewPlayer(x,y)
  local _p = NewActor(x,y)
  local _step_inherited = _p.step
  _p.name = _p.name .. "-> Player"

  _p.setSprite('asset/sprite/kitty.png', 32)

  _p.sprite.defineAnimation('idle', {
    frames = range(1,7),
    speed = 6
  })

  _p.sprite.defineAnimation('walk',{
    frames = range(8,11),
    speed = 5
  })

  _p.sprite.setAnimation(_p.sprite.animations.idle)

  _p.step = function()
    _p.inf = Controller.direction
    
    if _p.inf.x ~= 0 or _p.inf.y ~= 0 then
      _p.sprite.setAnimation(_p.sprite.animations.walk)
    else
      _p.sprite.setAnimation(_p.sprite.animations.idle)
    end
    
    if _p.facing == -_p.inf.x then
      _p.facing = _p.inf.x
    end
    _step_inherited()
  end

  return _p
end