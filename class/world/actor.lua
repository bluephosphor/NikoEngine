function NewActor(_x,_y)
  local _a = NewEntity(_x,_y)
  _a.name = _a.name .. '-> Actor'
  _a.radius = 0.2
  _a.z = 1
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
            _a.z + mz - 0.15,
            _a.x + mx,
            _a.y + my,
            _a.z + mz + 0.5,
            0.2
        )

        if len and (not bestLength or len < bestLength) then
            bestLength, bx,by,bz, bnx,bny,bnz = len, x,y,z, nx,ny,nz
        end
    end

    return bestLength, bx,by,bz, bnx,bny,bnz
  end

  _a.moveAndSlide = function(mx,my,mz)
    local len,x,y,z,nx,ny,nz = _a.collisionTest(mx,my,mz)

    local ignoreSlopes = nz and nz < -0.7

    if len then
        local speedLength = math.sqrt(mx^2 + my^2 + mz^2)

        if speedLength > 0 then
            local xNorm, yNorm, zNorm = mx / speedLength, my / speedLength, mz / speedLength
            local dot = xNorm*nx + yNorm*ny + zNorm*nz
            local xPush, yPush, zPush = nx * dot, ny * dot, nz * dot

            -- modify output vector based on normal
            mz = (zNorm - zPush) * speedLength
            if ignoreSlopes then mz = 0 end

            if not ignoreSlopes then
                mx = (xNorm - xPush) * speedLength
                my = (yNorm - yPush) * speedLength
            end
        end

        -- rejections
        _a.z = _a.z - nz * (len - _a.radius)

        if not ignoreSlopes then
            _a.x = _a.x - nx * (len - _a.radius)
            _a.y = _a.y - ny * (len - _a.radius)
        end
    end

    return mx, my, mz, nx, ny, nz
end

  local _step_inherited = _a.step
  _a.step = function()
    local _dt = love.timer.getDelta()
   _step_inherited()

   local _, nx, ny, nz

    -- vertical movement and collision check

    _a.zsp = _a.zsp + 0.1
    if Controller.key['space'] then _a.zsp = 10 end

    _, _, _a.zsp, nx, ny, nz = _a.moveAndSlide(0, 0, _a.zsp*_dt)

    -- ground check
    local wasOnGround = _a.onGround
    _a.onGround = nz and nz < 0.7

    -- smoothly walk down slopes
    if not _a.onGround and wasOnGround and _a.zsp > 0 then
        local len,x,y,z,nx,ny,nz = _a.collisionTest(0,0,_a.stepDownSize)
        local mx, my, mz = 0,0,_a.stepDownSize
        if len then
            -- do the position change only if a collision was actually detected
            _a.z = _a.z + mz

            local speedLength = math.sqrt(mx^2 + my^2 + mz^2)

            if speedLength > 0 then
                local xNorm, yNorm, zNorm = mx / speedLength, my / speedLength, mz / speedLength
                local dot = xNorm*nx + yNorm*ny + zNorm*nz
                local xPush, yPush, zPush = nx * dot, ny * dot, nz * dot

                -- modify output vector based on normal
                mz = (zNorm - zPush) * speedLength
            end

            -- rejections
            _a.z = _a.z - nz * (len - _a.radius)
            _a.zsp = 0
            _a.onGround = true
        end
    end
  end


  return _a
end