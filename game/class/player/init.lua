function NewPlayer(x,y)
  local _p = NewActor(x,y)
  local _step_inherited = _p.step
  local _draw_inherited = _p.draw
  _p.lastSpeed = {}
  _p.name = _p.name .. "-> Player"
  _p.states = require('game.class.player.states')
  _p.jump = 8

  _p.maxSpinDuration = 40
  _p.spinTimer       = 30

  _p.setSprite('asset/sprite/player/player.png', 32)
  _p.setModel('asset/model/plane.obj')

  _p.light      = G3D.newModel('asset/model/sphere.obj', nil, {0,0,1}, nil, {0.2,0.2,0.2})
  _p.light.id   = _p.id .. 'L_MODEL'
  _p.light.name = _p.name .. ' (light)'
  _p.light.myDrawOrder = DrawOrder.world3D
  _p.light.myDrawOrder.add(_p.light)
  _p.light.spshader = Shader.whiteout
  Instance.lookupTable[_p.light.id] = _p.light

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

  Particles.define('spinpixel', 'asset/sprite/parts/p_pixel.png', {
    lifetime = 32,
    size     = 0.05,
    speed    = {0,0,0.01},
    shader   = Shader.trans,
    alphaSteps = {
      0,1,0,1,0
    }
  })

  Particles.define('bubble', 'asset/sprite/parts/p_bubble.png', {
    lifetime = 128,
    size     = 0.2,
    speed    = {0,0,0.02},
    shader   = Shader.trans,
    alphaSteps = {
      0,1,0
    }
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
    local _lightPos = {_p.x,_p.y + 0.5,_p.z + 1.5}
    _p.light:setTranslation(unpack(_lightPos))
    G3D.shader:send('lightPos', _lightPos)
    G3D.shader:send('lightColor', {1,1,1})
  end

  Camera.follow = _p
  return _p
end