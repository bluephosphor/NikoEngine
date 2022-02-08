function NewActor(_x,_y)
  local _a = NewEntity(_x,_y)
  _a.name = _a.name .. '-> Actor'
  _a.radius = 0.2
  _a.z = 0.85
  _a.onGround = false
  _a.stepDownSize = 0.075

  _a.collisionModels = {
    Room.current.model
  }

  _a.collisionTest = function(mx,my,mz)
    local bestLength, bx,by,bz, bnx,bny,bnz

    for _,model in ipairs(_a.collisionModels) do
        local len, x,y,z, nx,ny,nz = model:capsuleIntersection(
            _a.x + mx,
            _a.y + my,
            _a.z + mz - 0.1,
            _a.x + mx,
            _a.y + my,
            _a.z + mz + 0.1,
            0.2
        )

        if len and (not bestLength or len < bestLength) then
            bestLength, bx,by,bz, bnx,bny,bnz = len, x,y,z, nx,ny,nz
            Shell.clear()
            Shell.log('---LAST COLLISSION---')
            Shell.log('bestLength: ' .. bestLength)
            Shell.log('x: '  .. bx  .. ' y: '  .. by  .. ' z: '  .. bz)
            Shell.log('nx: ' .. bnx .. ' ny: ' .. bny .. ' nz: ' .. bnz)
        end
    end

    return bestLength, bx,by,bz, bnx,bny,bnz
  end

  _a.moveAndSlide = function(mx,my,mz)
    local len,x,y,z,nx,ny,nz = _a.collisionTest(mx,my,mz)
    local _dt = love.timer.getDelta()

    local ignoreSlopes = nz and nz < -0.7

    if len then
        local speedLength = math.sqrt(mx^2 + my^2 + mz^2)

        if speedLength > 0 then
            local xNorm, yNorm, zNorm = mx / speedLength, my / speedLength, mz / speedLength
            local dot = xNorm*nx + yNorm*ny + zNorm*nz
            local xPush, yPush, zPush = nx * dot, ny * dot, nz * dot

            -- modify output vector based on normal
            mz = (zNorm + zPush) * speedLength
            if ignoreSlopes then mz = 0 end

            if not ignoreSlopes then
                mx = (xNorm - xPush) * speedLength
                my = (yNorm - yPush) * speedLength
            end
        end

        -- rejections
        _a.z = _a.z + nz * (len + _a.radius)

        if not ignoreSlopes then
            _a.x = _a.x - nx * (len - _a.radius)
            _a.y = _a.y - ny * (len - _a.radius)
        end
    end

    if nz then
      Shell.log('-------')
      Shell.log('mx: ' .. mx .. ' my: ' .. my .. ' mz: ' .. mz)
      Shell.log('nx: ' .. nx .. ' ny: ' .. ny .. ' nz: ' .. nz)
      if Shell.logBuffer <= 0 then
        Shell.logBuffer = 5
      end
    end

    return mx, my, mz, nx, ny, nz
  end

  local _step_inherited = _a.step
    _a.zsp = math.max(_a.zsp - 0.5, -_a.maxSpeed)
    _a.step = function()
    _step_inherited()
    _,_,_,_,_,_ = _a.moveAndSlide(0, 0, 0)
  end

  return _a
end