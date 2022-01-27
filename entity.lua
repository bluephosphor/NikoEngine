require "lib.math"

function NewEntity(x,y)
  local _e = {
    x = x,
    y = y,
    width = 32,
    height = 32,

    direction = nil,
    dirRad = nil,
    distance = 0;

    hsp = 0,
    vsp = 0,
    maxSpeed = 5,
    accel = 2,
    fric = 0.2,

    inf = { x = 0, y = 0 }
  }
  _e.step = function()
    
    if _e.inf.x ~= 0 or _e.inf.y ~= 0 then
      _e.hsp = _e.hsp + (_e.inf.x * (_e.accel))
      _e.vsp = _e.vsp + (_e.inf.y * (_e.accel))
    end
    
    local _vec = Vector(0,0, _e.hsp,_e.vsp);

    _e.dirRad = _vec.dirRad
    _e.direction = _vec.direction
    _e.distance = _vec.distance

    if _vec.distance > _e.maxSpeed then
      _e.hsp = lengthdir_x(_e.maxSpeed, _vec.dirRad)
      _e.vsp = lengthdir_y(_e.maxSpeed, _vec.dirRad)
    end
    
    if _e.inf.x == 0 then
      _e.hsp = lerp(_e.hsp, 0, _e.fric)
    end
    
    if _e.inf.y == 0 then
      _e.vsp = lerp(_e.vsp, 0, _e.fric)
    end

    _e.hsp = floorToPrecision(_e.hsp, 2)
    _e.vsp = floorToPrecision(_e.vsp, 2)
     
    _e.x = _e.x + _e.hsp
    _e.y = _e.y + _e.vsp

  end

  _e.draw = function()
    love.graphics.rectangle(
      'fill',
      _e.x,
      _e.y,
      _e.width,
      _e.height
    )
  end

  return _e
end