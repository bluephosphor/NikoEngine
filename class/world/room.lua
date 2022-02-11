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
  }, StepOrder.world, DrawOrder.world)

  _r.surface = Room.applyTexture(_r, folder)

  --load objects
  local _i = 0
  while love.filesystem.getInfo('asset/room/' .. folder .. '/obj_' .. _i .. '.obj') do
    local _mod = G3D.newModel('asset/room/' .. folder .. '/obj_' .. _i .. '.obj', _r.surface)
    _mod.spshader = Shader.trans
    table.insert(_r.obj, _mod)
    _i = _i + 1
  end

  _r.draw = function()
    _r.model:draw()
    for i, obj in ipairs(_r.obj) do
      obj:draw(obj.spshader and obj.spshader or nil)
    end
  end

  Room.current = _r
  return _r
end

Room.spawn = function(entity, x, y, z)
  entity.x      = x and x or 0
  entity.y      = y and y or 0
  entity.z      = z and z or 0.85
  entity.xStart = x and x or 0
  entity.yStart = y and y or 0
  entity.zStart = z and z or 0.85

  table.insert(Room.current.children, entity)
  table.insert(entity.collisionModels, Room.current.model)
  for i, obj in ipairs(Room.current.obj) do
    table.insert(entity.collisionModels, obj)
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