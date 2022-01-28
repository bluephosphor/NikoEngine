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

    vec = nil,

    hsp = 0,
    vsp = 0,
    maxSpeed = 5,
    accel = 2,
    fric = 0.2,

    inf = { x = 0, y = 0 }
  }
  _e.step = function()
    _e.vec = nil
    
    if _e.inf.x ~= 0 or _e.inf.y ~= 0 then
      _e.hsp = _e.hsp + (_e.inf.x * (_e.accel))
      _e.vsp = _e.vsp + (_e.inf.y * (_e.accel))
    
      _e.vec = MovementVector(0,0, _e.hsp,_e.vsp)
  
      if _e.vec.distance >= _e.maxSpeed then
        _e.hsp = lengthdir_x(_e.maxSpeed, _e.vec.dirRad)
        _e.vsp = lengthdir_y(_e.maxSpeed, _e.vec.dirRad)
      end
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
      _e.x - (_e.width / 2),
      _e.y - (_e.height / 2),
      _e.width,
      _e.height
    )
  end

  _e.drawDebug = function(x,y)
    local _y = 0; local _unit = 16
    love.graphics.print('hsp:   ' .. _e.hsp,   x, y + _y);  _y = _y + _unit
    love.graphics.print('vsp:   ' .. _e.vsp,   x, y + _y);  _y = _y + _unit
    love.graphics.print('inf.x: ' .. _e.inf.x, x, y + _y);  _y = _y + _unit
    love.graphics.print('inf.y: ' .. _e.inf.y, x, y + _y);  _y = _y + _unit * 2
    if _e.vec ~= nil then
      love.graphics.print('vector: ', x, _y);                                    _y = _y + _unit
      love.graphics.print('direction: '   .. _e.vec.direction, x + 16, y + _y);  _y = _y + _unit
      love.graphics.print('radian: '      .. _e.vec.dirRad,    x + 16, y + _y);  _y = _y + _unit
      love.graphics.print('distance: '    .. _e.vec.distance,  x + 16, y + _y);  _y = _y + _unit
      love.graphics.print('xComponent: '  .. _e.vec.a,         x + 16, y + _y);  _y = _y + _unit
      love.graphics.print('yComponent: '  .. _e.vec.b,         x + 16, y + _y);  _y = _y + _unit

      love.graphics.setColor(1,0,0)
      love.graphics.line(
        _e.x,
        _e.y,
        _e.x + _e.vec.x2 * 16,
        _e.y + _e.vec.y2 * 16
      )
      love.graphics.setColor(0,0,1)
      love.graphics.line(
        _e.x,
        _e.y,
        _e.x + lengthdir_x(_e.vec.distance, _e.vec.dirRad) * 16,
        _e.y + lengthdir_y(_e.vec.distance, _e.vec.dirRad) * 16
      )
      love.graphics.setColor(1,1,1)
    end
  end

  return _e
end