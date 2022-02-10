Direction = enum{
  "LEFT",
  "RIGHT",
  "UP",
  "DOWN"
}

Shader = {
  trans = love.graphics.newShader('g3d/g3d.vert', 'lib/shader/transluscent.frag'),
}