function NewPlayer(x,y)
  local _p = NewActor(x,y)
  local _step_inherited = _p.step
  _p.lastSpeed = {}
  _p.name = _p.name .. "-> Player"
  _p.states = require('engine.class.world.player.states')
  _p.jump = 8

  _p.maxSpinDuration  = 30
  _p.spinTimer        = 30

  _p.setSprite('asset/sprite/player/player.png', 32)
  _p.setModel('asset/model/plane.obj')

  _p.sprite.defineAnimation('idle', {
    frames = {1},
    speed = 10
  })

  _p.sprite.defineAnimation('walk',{
    frames = range(1,4),
    speed = 5
  })

  _p.sprite.defineAnimation('spin',{
    frames = range(5,14),
    speed = 3
  })

  _p.currentState = _p.states.normal.set

  _p.onVoidOut = function()
    _p.x, _p.y, _p.z = _p.xStart, _p.yStart, _p.zStart
  end

  _p.step = function(dt)
    _p.currentState(_p, _step_inherited, dt)
    if Engine.State ~= 'GAMEPLAY' then
      _p.inf.x = 0
      _p.inf.y = 0
      return
    end
  end

  Camera.follow = _p
  return _p
end