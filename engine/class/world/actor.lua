function NewActor(_x,_y)
  local _a = NewEntity(_x,_y)
  _a.name = _a.name .. '-> Actor'
  _a.waterCoords = {}
  _a.inWater = false

  _a.waterCollision = function()
    for index, water in ipairs(_a.waterCoords) do
      _a.inWater = pointIntersectingCube(
        {_a.x,_a.y,_a.z},
        water.props.pos,
        water.props.width*4,
        water.props.height*4,
        water.props.depth
      )
    end
  end

  local _step_inherited = _a.step
  _a.step = function(dt)
    _step_inherited(dt)
    _a.waterCollision()
  end

  return _a
end