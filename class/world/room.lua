Room = {
  current = nil
}
DefineRoom = function(folder)
  local _r = Instance.create({
    model = G3D.newModel('asset/room/'.. folder .. '/mesh.obj')
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

  return _r
end