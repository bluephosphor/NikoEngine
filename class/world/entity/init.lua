local _step  = require "class.world.entity.e_step"
local _draw  = require "class.world.entity.e_draw"

function NewEntity(x,y,z)
  local _e = Instance.create({
    name = 'Entity',

    x = x,
    y = y,
    z = z and z or 0.95,
    width = 32,
    height = 32,

    direction = nil,
    dirRad = nil,
    distance = 0;

    vec = nil,

    sprite = nil,
    scale = 3,
    angle = 0,
    facing = 1,
    radius = 0.2,

    hsp = 0,
    vsp = 0,
    zsp = 0,
    maxSpeed = 5,
    maxFallSpeed = 10,
    accel = 2,
    fric = 0.2,
    grav = 0.5,

    onGround = false,

    collisionModels = {
      Room.current.model
    },

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
    _e.model.myDrawOrder = DrawOrder.world3D
    _e.model.myDrawOrder.add(_e.model)
    Instance.lookupTable[_e.model.id] = _e.model
  end

  _e.step = function()
    _step(_e)
  end

  _e.draw = function()
    _draw(_e)
  end

  _e.preDestroy = function()
    _e.sprite.free()
  end

  return _e
end