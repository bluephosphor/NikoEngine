local _state = {
  normal = {
    set  = function(_p, _, _)
      _p.maxSpeed = 5
      _p.maxFallSpeed = 10
      _p.accel = 2
      _p.fric = 0.2
      _p.grav = 0.5
      _p.sprite.setFrame(1)

      _p.currentState = _p.states.normal.step
    end,
    step = function(_p, _inherited, dt)
      _inherited(dt)

      if Game.State == 'GAMEPLAY' then
        _p.inf.x = Controller.direction.x
        _p.inf.y = Controller.direction.y
        if Controller.key['x'] and _p.onGround then
          _p.zsp = _p.jump
        end
        if Controller.key['z'] then
          _p.currentState = _p.states.spin.set
        end
      end

      if _p.inf.x ~= 0 or _p.inf.y ~= 0 then
        _p.sprite.setAnimation(_p.sprite.animations.walk)
      else
        _p.sprite.setFrame(1)
      end

      if not _p.onGround then
        local _val = _p.zsp
        local threshhold = 0.99
        local frame
        if _val > threshhold then
          frame = 4
        elseif _val < -threshhold then
          frame = 2
        else
          frame = 3
        end
        _p.sprite.setFrame(frame)
      end

      if _p.facing == -_p.inf.x then
        _p.facing = _p.inf.x
      end
    end,
  },
  spin = {
    set = function(_p, _, _)
      _p.maxSpeed = 15
      _p.maxFallSpeed = 7
      _p.accel = 0.5
      _p.fric = 0.01
      _p.grav = 0.4
      _p.sprite.setAnimation(_p.sprite.animations.spin)
      _p.spinTimer = _p.maxSpinDuration
      if not _p.onGround then 
        _p.zsp = _p.zsp + _p.jump/2
        _p.maxSpeed = 10
      end

      _p.currentState = _p.states.spin.step
    end,
    step = function(_p, _inherited, dt)
      _inherited(dt)

      if Game.State == 'GAMEPLAY' then
        _p.inf.x = Controller.direction.x
        _p.inf.y = Controller.direction.y
        if Controller.key['x'] and _p.onGround then
          _p.zsp = _p.jump
        end
        if Controller.key['z'] then
          _p.currentState = _p.states.normal.set
        end
      end

      _p.spinTimer = approach(_p.spinTimer, 0 , 1)
      if _p.spinTimer <= 0 then
        _p.currentState = _p.states.normal.set
      end
    end
  }
}

return _state