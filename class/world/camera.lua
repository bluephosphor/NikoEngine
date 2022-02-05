G3D.camera.fov = 1

view = enum{
  'player',
  'free'
}

Camera = {
  x = 0,
  y = 0,
  z = 0,
  speed = .6,
  mode = view.player,
}

Camera.update = function()
  if Camera.mode == view.player then
    Camera.x = Player.x
    Camera.y = lerp(Camera.y, -Player.y - 3, Camera.speed)

    G3D.camera.target = {Player.x, -Player.y, 0}
    G3D.camera.position = {Camera.x, Camera.y, 1}
    G3D.camera.updateViewMatrix()
  elseif Camera.mode == view.free then
    G3D.camera.firstPersonMovement(love.timer.getDelta())
    if love.keyboard.isDown "escape" then
      love.event.push "quit"
    end
  end
end

function love.mousemoved(x,y,dx,dy) 
  if Camera.mode ~= view.free then return end
  G3D.camera.firstPersonLook(dx,dy)
end