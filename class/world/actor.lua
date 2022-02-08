function NewActor(_x,_y)
  local _a = NewEntity(_x,_y)
  _a.name = _a.name .. '-> Actor'

  _a.collisionModels = {
    Room.current.model
  }

  _a.collisionTest = function(mx,my,mz)
    local bestLength, bx,by,bz, bnx,bny,bnz

    for _,model in ipairs(_a.collisionModels) do
        local len, x,y,z, nx,ny,nz = model:capsuleIntersection(
            _a.x + mx,
            _a.y + my - 0.15,
            _a.z + mz,
            _a.x + mx,
            _a.y + my + 0.5,
            _a.z + mz,
            0.2
        )

        if len and (not bestLength or len < bestLength) then
            bestLength, bx,by,bz, bnx,bny,bnz = len, x,y,z, nx,ny,nz
        end
    end

    return bestLength, bx,by,bz, bnx,bny,bnz
  end

  local _step_inherited = _a.step
  _a.step = function()
    _a.c = _a.collisionTest(_a.x, -_a.y, _a.z)
   _step_inherited()
  end

  local _draw_inherited = _a.draw
  _a.draw = function()
    _draw_inherited()
    love.graphics.print(_a.c and _a.c or 0)
  end

  return _a
end