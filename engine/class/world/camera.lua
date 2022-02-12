
view = enum{
  'Camera.follow',
  'free'
}

Camera = {
  x = 0,
  y = 0,
  z = 0,
  speed = 20,
  mode = view.player,
  follow = nil
}

Camera.update = function(dt)
  if Camera.mode == view.player then
    Camera.x = lerp(Camera.x, Camera.follow.x,     Camera.speed * dt, true)
    Camera.y = lerp(Camera.y, Camera.follow.y - 5, Camera.speed * dt, true)
    Camera.z = lerp(Camera.z, Camera.follow.z + 2, Camera.speed * dt, true)

    G3D.camera.target = {
      lerp(G3D.camera.target[1], Camera.follow.x, Camera.speed * dt, true),
      lerp(G3D.camera.target[2], Camera.follow.y, Camera.speed * dt, true),
      lerp(G3D.camera.target[3], Camera.follow.z + 0.5, Camera.speed * dt, true)
    }
    G3D.camera.position = {Camera.x, Camera.y, Camera.z}
    G3D.camera.updateViewMatrix()
  elseif Camera.mode == view.free then
    G3D.camera.firstPersonMovement(dt)
  end
end

function love.mousemoved(x,y,dx,dy) 
  if Camera.mode ~= view.free then return end
  G3D.camera.firstPersonLook(dx,dy)
end