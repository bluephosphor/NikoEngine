local function move_commit(_e, dt)
  --reset movement vector
  _e.vec = nil

  --interpolate changes in maxSpeeds so they aren't so sudden
  local _amt = 0.5
  if _e.trueMaxSpeed ~= _e.maxSpeed then
    _e.trueMaxSpeed = lerp(_e.trueMaxSpeed, _e.maxSpeed, _amt)
  end
  if _e.trueMaxFallSpeed ~= _e.maxFallSpeed then
    _e.trueMaxFallSpeed = lerp(_e.trueMaxFallSpeed, _e.maxFallSpeed, _amt)
  end

  if _e.inf.x ~= 0 or _e.inf.y ~= 0 then
    --apply initial speed
    _e.hsp = _e.hsp + (_e.inf.x * (_e.accel))
    _e.vsp = _e.vsp + (-_e.inf.y * (_e.accel))

    --do math so we don't go faster diagonally
    _e.vec = MovementVector(0,0, _e.hsp,_e.vsp)

    if _e.vec.distance >= _e.trueMaxSpeed then
      _e.hsp = lengthdir_x(_e.trueMaxSpeed, _e.vec.dirRad)
      _e.vsp = lengthdir_y(_e.trueMaxSpeed, _e.vec.dirRad)
    end
  end

  --friction
  if _e.inf.x == 0 then
    _e.hsp = lerp(_e.hsp, 0, _e.fric)
  end

  if _e.inf.y == 0 then
    _e.vsp = lerp(_e.vsp, 0, _e.fric)
  end

  --gravity
  _e.zsp = math.max(_e.zsp - _e.grav, -_e.trueMaxFallSpeed)

  --rounding
  _e.hsp = floorToPrecision(_e.hsp, 2)
  _e.vsp = floorToPrecision(_e.vsp, 2)
  _e.zsp = floorToPrecision(_e.zsp, 2)

  return _e.hsp*dt, _e.vsp*dt, _e.zsp*dt
end

local function collision_test(_e, mx,my,mz)
  local bestLength, bx,by,bz, bnx,bny,bnz

  for _,model in ipairs(_e.collisionModels) do
    local len, x,y,z, nx,ny,nz = model:capsuleIntersection(
      _e.x + mx,
      _e.y + my,
      _e.z + mz - 0.1,
      _e.x + mx,
      _e.y + my,
      _e.z + mz - 0.85,
      0.2
    )

    if len and (not bestLength or len < bestLength) then
      bestLength, bx,by,bz, bnx,bny,bnz = len, x,y,z, nx,ny,nz
      if Debug.ShowCollisionData then
        Shell.clear()
        Shell.log('---LAST COLLISSION---')
        Shell.log('bestLength: ' .. bestLength)
        Shell.log('x: '  .. bx  .. ' y: '  .. by  .. ' z: '  .. bz)
        Shell.log('nx: ' .. bnx .. ' ny: ' .. bny .. ' nz: ' .. bnz)
      end
    end
  end

  return bestLength, bx,by,bz, bnx,bny,bnz
end

local function slide_collision(_e, mx,my,mz)
  local len,x,y,z,nx,ny,nz = collision_test(_e,mx,my,mz)

  _e.x = _e.x + mx
  _e.y = _e.y + my
  _e.z = _e.z + mz

  local ignoreSlopes = nz and nz > 0.7

  if len then
    local speedLength = math.sqrt(mx^2 + my^2 + mz^2)

    if speedLength > 0 then
      local xNorm, yNorm, zNorm = mx / speedLength, my / speedLength, mz / speedLength
      local dot = xNorm*nx + yNorm*ny + zNorm*nz
      local xPush, yPush, zPush = nx * dot, ny * dot, nz * dot

      -- modify output vector based on normal
      mz = -(zNorm - zPush) * speedLength
      if ignoreSlopes then mz = 0 end

      if not ignoreSlopes then
        mx = (xNorm - xPush) * speedLength
        my = (yNorm - yPush) * speedLength
      end
    end

    -- rejections
    _e.z = _e.z - nz * (len - _e.radius)

    if not ignoreSlopes then
      _e.x = _e.x - nx * (len - _e.radius)
      _e.y = _e.y - ny * (len - _e.radius)
    end
  end

  if Debug.ShowCollisionData and nz then
    Shell.log('-------')
    Shell.log('mx: ' .. mx .. ' my: ' .. my .. ' mz: ' .. mz)
    Shell.log('nx: ' .. nx .. ' ny: ' .. ny .. ' nz: ' .. nz)
    Shell.log(_e.onGround and 'true' or 'false')
    if Shell.logBuffer <= 0 then
      Shell.logBuffer = 5
    end
  end

  return mx, my, mz, nx, ny, nz
end

local function step(_e)
  local dt = love.timer.getDelta()
  local mx, my, mz = move_commit(_e, dt)

  --vertical movement and collision
  local fx, fy, fz, nx, ny, nz = slide_collision(_e, 0, 0, mz)
  _e.zsp = fz/dt

  -- ground check
  local wasOnGround = _e.onGround
  _e.onGround = nz and nz > -0.7

  -- smoothly walk down slopes
  local stepDownSize = -0.075

  if not _e.onGround and wasOnGround and _e.zsp < 0 then
    local len,x,y,z,nx,ny,nz = collision_test(_e,0,0,stepDownSize)
    local mx, my, mz = 0,0,stepDownSize
    if len then
      -- do the position change only if a collision was actually detected
      _e.z = _e.z + mz

      local speedLength = math.sqrt(mx^2 + my^2 + mz^2)

      if speedLength > 0 then
        local xNorm, yNorm, zNorm = mx / speedLength, my / speedLength, mz / speedLength
        local dot = xNorm*nx + yNorm*ny + zNorm*nz
        local xPush, yPush, zPush = nx * dot, ny * dot, nz * dot

        -- modify output vector based on normal
        mz = (zNorm - zPush) * speedLength
      end

      -- rejections
      _e.z = _e.z - nz * (len - _e.radius)
      _e.zsp = 0
      _e.onGround = true
    end
  end
  -- x/y collisions
  local mx, my = slide_collision(_e, mx, my, 0)
  _e.hsp, _e.vsp = mx/dt, my/dt

  if _e.sprite ~= nil then
    _e.sprite.animate()
  end

  if _e.model ~= nil then
    _e.model.translation = {_e.x, _e.y, _e.z}
    _e.model.rotation[1] = lerp(
      _e.model.rotation[1],
      math.pi + ((math.pi/2) * _e.facing),
      0.15
    )
    _e.model:updateMatrix()

  end
end

return step