local _step  = require "class.world.entity.e_step"
local _draw  = require "class.world.entity.e_draw"

function NewEntity(x,y,z)
  local _e = Instance.create({
    name = 'Entity',

    x      = x and x or 0,
    y      = y and y or 0,
    z      = z and z or 0.95,
    xStart = x and x or 0,
    yStart = y and y or 0,
    zStart = z and z or 0.95,
    width  = 32,
    height = 32,

    direction = nil,
    dirRad    = nil,
    distance  = 0;

    vec = nil,

    sprite = nil,
    scale  = 3,
    angle  = 0,
    facing = 1,
    radius = 0.2,

    hsp = 0,
    vsp = 0,
    zsp = 0,
    maxSpeed = 5,
    trueMaxSpeed = 5,
    maxFallSpeed = 10,
    trueMaxFallSpeed = 10,
    accel = 2,
    fric  = 0.2,
    grav  = 0.5,

    onGround = false,
    collisionModels = {},

    inf = { x = 0, y = 0 }
  }, StepOrder.world, DrawOrder.world)

  _e.setSprite = function(path, frameWidth)
    _e.sprite  = Sprite(path, frameWidth)
    _e.width   = _e.sprite.width  * _e.scale
    _e.height  = _e.sprite.height * _e.scale
  end

  _e.setModel = function(path)
    _e.model = G3D.newModel(
      path,
      nil,
      {0,0,0},
      {math.pi/2,-1.56,0}
    )
    _e.model.surface = love.graphics.newCanvas(_e.width, _e.height)
    _e.model.id = _e.id .. '_MODEL'
    _e.model.name = _e.name .. ' (model)'
    _e.model.myDrawOrder = DrawOrder.world3D
    _e.model.myDrawOrder.add(_e.model)
    Instance.lookupTable[_e.model.id] = _e.model
  end

  _e.preDestroy = function()
    _e.sprite.free()
  end

  _e.onVoidOut = function()
    _e.preDestroy()
    Instance.destroy(_e)
  end

  _e.step = function(dt)
    _step(_e, dt)
    if _e.z < Room.zDeadZone then
      _e.onVoidOut()
    end
  end

  _e.draw = function()
    _draw(_e)
  end

  return _e
end