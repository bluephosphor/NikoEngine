Camera = {
  x = 0,
  y = 0,
  z = 0,
  speed = .6
}

G3D.camera.fov = 1

Camera.update = function()
  Camera.x = trans3d(Player.x)
  Camera.y = lerp(Camera.y, trans3d(-Player.y) - 3, Camera.speed)

  G3D.camera.target = {trans3d(Player.x), trans3d(-Player.y), 0}
  G3D.camera.position = {Camera.x, Camera.y, 1}
  G3D.camera.updateViewMatrix()
end