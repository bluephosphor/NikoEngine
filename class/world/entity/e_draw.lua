local function drawBbox(_e)
  love.graphics.setColor(1,0,0)
  love.graphics.rectangle(
    'line',
    _e.x - (_e.width / 2),
    _e.y - (_e.height / 2),
    _e.width,
    _e.height
  )
  love.graphics.setColor(1,1,1)
end

local function drawDebug(_e,x,y)
  local _y = 0; local _unit = 16
  love.graphics.print('hsp:   ' .. _e.hsp,   x, y + _y);  _y = _y + _unit
  love.graphics.print('vsp:   ' .. _e.vsp,   x, y + _y);  _y = _y + _unit
  love.graphics.print('inf.x: ' .. _e.inf.x, x, y + _y);  _y = _y + _unit
  love.graphics.print('inf.y: ' .. _e.inf.y, x, y + _y);  _y = _y + _unit * 2
  if _e.vec ~= nil then
    love.graphics.print('vector: ', x, y + _y);                                _y = _y + _unit
    love.graphics.print('direction:  '  .. _e.vec.direction, x + 16, y + _y);  _y = _y + _unit
    love.graphics.print('radian:     '  .. _e.vec.dirRad,    x + 16, y + _y);  _y = _y + _unit
    love.graphics.print('distance:   '  .. _e.vec.distance,  x + 16, y + _y);  _y = _y + _unit
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

local function draw(_e)
  if _e.model ~= nil then

    love.graphics.setCanvas(_e.model.surface)
    love.graphics.clear(0,0,0,0)
    _e.sprite.draw(
      0, --_e.facing == 1 and _e.width or 0,
      0,
      _e.angle,
      _e.scale, -- * -_e.facing,
      _e.scale
    )
    --love.graphics.setCanvas(WorldSurface)
    _e.model.mesh:setTexture(_e.model.surface)
  elseif _e.sprite ~= nil then
    _e.sprite.draw(
      _e.x - (_e.width / 2) * _e.facing,
      _e.y - (_e.height / 2),
      _e.angle,
      _e.scale * _e.facing,
      _e.scale
    )
  end
  if Debug.ShowBoxes or _e.sprite == nil then
    drawBbox(_e)
  end
  if Debug.ShowEntityInfo then
    drawDebug(_e,_e.x, _e.y)
  end
end

return draw