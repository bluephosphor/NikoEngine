function NewActor(_x,_y)
  local _a = NewEntity(_x,_y)
  _a.name = _a.name .. '-> Actor'
  _a.waterCoords = {}
  _a.inWater = false

  _a.waterCollision = function()
    for index, water in ipairs(_a.waterCoords) do
      _a.inWater = pointIntersectingCube(
        {_a.x,_a.y,_a.z-0.5},
        water.props.pos,
        water.props.width,
        water.props.height,
        water.props.depth
      )
    end
  end

  local _step_inherited = _a.step
  _a.step = function(dt)
    _step_inherited(dt)

    -- paper mario style flip
    if _a.model ~= nil then
      
      _a.model.rotation[1] = lerp(
        _a.model.rotation[1],
        math.pi + ((math.pi/2) * _a.facing),
        dt * 15
      )
      _a.model:updateMatrix()
  
    end

    _a.waterCollision()
  end

  return _a
end