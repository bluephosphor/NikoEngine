local _state = {}

_state.normal = {
  set  = function(_p, _, _)
    _p.maxSpeed = 7
    _p.maxFallSpeed = 25
    _p.jump = 9
    _p.accel = 1
    _p.fric = 15
    _p.grav = 2
    _p.sprite.setFrame(1)

    _p.currentState = _p.states.normal.step
  end,
  step = function(_p, _inherited, dt)
    _inherited(dt)

    if Engine.State == 'GAMEPLAY' then
      _p.inf.x = Controller.direction.x
      _p.inf.y = Controller.direction.y
      if Controller.key['x'] and _p.onGround then
        _p.zsp = _p.jump * dt
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
      local threshhold = 0.01
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

    if _p.inWater then
      _p.currentState = _p.states.swim.set
    end

    if _p.facing == -_p.inf.x then
      _p.facing = _p.inf.x
    end
  end,
}

_state.spin = {
  set = function(_p, _, dt)
    _p.maxSpeed = 16
    _p.maxFallSpeed = 7
    _p.jump = 5
    _p.accel = 0.5
    _p.fric = 0.5
    _p.grav = 0.6
    _p.sprite.setAnimation(_p.sprite.animations.spin)
    _p.spinTimer = _p.maxSpinDuration
    if not _p.onGround then 
      _p.zsp = _p.zsp + (_p.initSpinJump * dt)
      _p.maxSpeed = 10
    end
    _p.currentState = _p.states.spin.step
  end,
  step = function(_p, _inherited, dt)
    _inherited(dt)

    if Engine.State == 'GAMEPLAY' then
      _p.inf.x = Controller.direction.x
      _p.inf.y = Controller.direction.y
      if Controller.key['x'] and _p.onGround then
        _p.zsp = _p.jump * dt
      end
      if Controller.key['z'] then
        _p.currentState = _p.states.normal.set
      end
    end

    Particles.emit('spinpixel', {
      _p.x + (math.random() - 0.5)*2,
      _p.y + (math.random() - 0.5)*2,
      _p.z + (math.random() - 0.5)*2
    })

    local _timerInc = dt

    if _p.inWater then
      _p.gravity = 0
      _p.zsp = 0.01
      _timerInc = 0.5 * dt
    end

    _p.spinTimer = approach(_p.spinTimer, 0 , _timerInc)
    if _p.spinTimer <= 0 then
      _p.currentState = _p.states.normal.set
    end
  end
}

_state.swim = {
  set  = function(_p, _, _)
    _p.maxSpeed = 5
    _p.maxFallSpeed = 5
    _p.accel = 0.5
    _p.fric = 1
    _p.grav = 0.1
    _p.sprite.setFrame(1)
    _p.zsp = 0

    _p.currentState = _p.states.swim.step
  end,
  step = function(_p, _inherited, dt)
    _inherited(dt)

    if Engine.State == 'GAMEPLAY' then
      _p.inf.x = Controller.direction.x
      _p.inf.y = Controller.direction.y
      if Controller.key['x'] then
        _p.zsp = _p.zsp + (_p.swimjump * dt)
      end
      -- if Controller.key['z'] then
      --   someday a cool swimming dash
      -- end
    end

    if _p.inf.x ~= 0 or _p.inf.y ~= 0 then
      _p.sprite.setAnimation(_p.sprite.animations.walk)
      _p.sprite.animation.speed = 0.1
    else
      _p.sprite.setFrame(1)
    end

    if not _p.inWater then
      _p.currentState = _p.states.normal.set
    end

    if _p.facing == -_p.inf.x then
      _p.facing = _p.inf.x
    end

    local _n = math.random(5)
    if _n == 5 then
      Particles.emit('bubble', {
      _p.x + (math.random() - 0.5)*4,
      _p.y + (math.random() - 0.5)*4,
      _p.z + (math.random() - 0.5)*4
    })
    end
  end,
}

return _state