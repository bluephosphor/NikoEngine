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
  Shell.clear()
  Shell.log('hsp:   ' .. _e.hsp )
  Shell.log('vsp:   ' .. _e.vsp )
  Shell.log('inf.x: ' .. _e.inf.x)
  Shell.log('inf.y: ' .. _e.inf.y)
  if _e.vec ~= nil then
    Shell.log('vector: ')
    Shell.log('direction:  '  .. _e.vec.direction)
    Shell.log('radian:     '  .. _e.vec.dirRad)
    Shell.log('distance:   '  .. _e.vec.distance)
    Shell.log('xComponent: '  .. _e.vec.a)
    Shell.log('yComponent: '  .. _e.vec.b)
  end
  if Shell.logBuffer <= 0 then
    Shell.logBuffer = 5
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