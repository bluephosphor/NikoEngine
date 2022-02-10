
view = enum{
  'Camera.follow',
  'free'
}

Camera = {
  x = 0,
  y = 0,
  z = 0,
  speed = .6,
  mode = view.player,
  follow = nil
}

Camera.update = function()
  if Camera.mode == view.player then
    Camera.x = Camera.follow.x
    Camera.y = lerp(Camera.y, Camera.follow.y - 5, Camera.speed)
    Camera.z = lerp(Camera.z, Camera.follow.z + 2, Camera.speed)

    G3D.camera.target = {Camera.follow.x, Camera.follow.y, Camera.follow.z + 0.5}
    G3D.camera.position = {Camera.x, Camera.y, Camera.z}
    G3D.camera.updateViewMatrix()
  elseif Camera.mode == view.free then
    G3D.camera.firstPersonMovement(love.timer.getDelta())
  end
end

function love.mousemoved(x,y,dx,dy) 
  if Camera.mode ~= view.free then return end
  G3D.camera.firstPersonLook(dx,dy)
end