function NewPlayer(x,y)
  local _p = NewActor(x,y)
  local _step_inherited = _p.step

  _p.setSprite('asset/sprite/kitty.png')

  _p.defineAnimation('idle', {
    frames = {1,2,3,4,5,6,7},
    speed = 6
  })

  _p.defineAnimation('walk',{
    frames = {8,9,10,11},
    speed = 5
  })

  _p.setAnimation(_p.animations.idle)

  _p.step = function()
    _p.inf = Controller.direction

    if _p.inf.x ~= 0 or _p.inf.y ~= 0 then
      _p.setAnimation(_p.animations.walk)
    else
      _p.setAnimation(_p.animations.idle)
    end

    if _p.facing == -_p.inf.x then
      _p.facing = _p.inf.x
    end

    _step_inherited()
  end

  return _p
end