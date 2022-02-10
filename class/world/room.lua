Room = {
  current = nil
}
DefineRoom = function(folder)
  local _r = Instance.create({
    model = G3D.newModel('asset/room/'.. folder .. '/mesh.obj'),
    name = 'Room -> ' .. folder,
    obj = {}
  }, StepOrder.world, DrawOrder.world)

  --get image
  _r.texture = love.graphics.newImage('asset/room/'.. folder .. '/texture_0.png')
  local width, height = _r.texture:getDimensions()

  --creating canvas (based on dims)
  _r.surface = love.graphics.newCanvas(width, height)

  --flip it -_-
  local _surf = love.graphics.getCanvas()
  love.graphics.setCanvas(_r.surface)
  love.graphics.draw(_r.texture, 0, height, 0, 1, -1)

  --apply it to model
  _r.model.mesh:setTexture(_r.surface)
  love.graphics.setCanvas(_surf)

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

  return _r
end