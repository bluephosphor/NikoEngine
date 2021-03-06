Room = {
  current = nil,
  zDeadZone = -32
}
Room.load = function(room)
  local folder = room.name
  local _r = Instance.create({
    model = G3D.newModel('asset/room/'.. folder .. '/mesh.obj'),
    name = 'Room -> ' .. folder,
    obj = {},
    defaultSpawn = room.defaultSpawn
  }, StepOrder.world, DrawOrder.world)

  _r.surface = Room.applyTexture(_r, folder)

  --apply lighting
  if room.lights then
    for index, value in ipairs(room.lights) do
      G3D.shader:send('lightPos', value[1]);
      G3D.shader:send('lightColor', value[2]);
    end
  end

  --load objects
  if room.objects then
    for _i, _obj in ipairs(room.objects) do
      local _load
      if type(_obj.model) == 'table' then
        _load = _obj.model
      else
        --load an obj file
        _load = 'asset/room/' .. folder .. '/' .. _obj.model .. '.obj'
      end
      local _mod = G3D.newModel(
        _load,
        _obj.texture and _obj.texture or _r.surface,
        _obj.pos and _obj.pos or {0,0,0},
        {0,0,0},
        _obj.scale and _obj.scale or {1,1,1}
      )
      _mod.props = _obj
      _r.obj[_i] = _mod
    end
  end


  _r.draw = function()
    _r.model:draw()
    for i, obj in ipairs(_r.obj) do
      if obj.props.shader then
        obj.props.shader:send('transparency', obj.props.alpha)
        obj:draw(obj.props.shader)
      else
        obj:draw()
      end
    end
  end

  Room.current = _r
  return _r
end

Room.spawn = function(entity, x, y, z)
  entity.x      = x and x or Room.current.defaultSpawn[1]
  entity.y      = y and y or Room.current.defaultSpawn[2]
  entity.z      = z and z or Room.current.defaultSpawn[3]
  entity.xStart = x and x or Room.current.defaultSpawn[1]
  entity.yStart = y and y or Room.current.defaultSpawn[2]
  entity.zStart = z and z or Room.current.defaultSpawn[3]
  entity.loadPosition = x and {x,y,z} or Room.current.defaultSpawn

  table.insert(Room.current.children, entity)
  table.insert(entity.collisionModels, Room.current.model)
  for i, obj in ipairs(Room.current.obj) do
    if obj.props.colType == CollisionType.SOLID then
      table.insert(entity.collisionModels, obj)
    elseif obj.props.colType == CollisionType.WATER and entity.waterCoords then
      table.insert(entity.waterCoords, obj)
    end
  end
end

Room.applyTexture = function(obj, path, surface)
  --get image
  obj.texture = love.graphics.newImage('asset/room/'.. path .. '/texture_0.png')
  local width, height = obj.texture:getDimensions()

  --creating canvas (based on dims)
  local _surface = love.graphics.newCanvas(width, height)

  --flip it -_-
  local _surf = love.graphics.getCanvas()
  love.graphics.setCanvas(_surface)
  love.graphics.draw(obj.texture, 0, height, 0, 1, -1)

  --apply it to model
  obj.model.mesh:setTexture(_surface)
  love.graphics.setCanvas(_surf)

  return _surface
end