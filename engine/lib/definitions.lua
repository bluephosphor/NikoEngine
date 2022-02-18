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
  trans = love.graphics.newShader('engine/g3d/g3d.vert', 'engine/lib/shader/transluscent.frag'),
  whiteout = love.graphics.newShader('engine/g3d/g3d.vert', 'engine/lib/shader/whiteout.frag'),
}