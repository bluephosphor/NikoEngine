Direction = enum{
  "LEFT",
  "RIGHT",
  "UP",
  "DOWN"
}

CollisionType = enum{
  "SOLID",
  "WATER",
  "NONE"
}

Shader = {
  trans = love.graphics.newShader('g3d/g3d.vert', 'lib/shader/transluscent.frag'),
}