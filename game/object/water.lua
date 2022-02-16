function Water(x,y,z,width,height,depth)
  local _plane = createPlane(4,4,width,height,0,0)
  local _w = {
    model   = _plane,
    shader  = Shader.trans,
    pos     = {x,y,z},
    width   = width,
    height  = height,
    depth   = depth and depth or 64,
    alpha   = 0.3,
    texture = "asset/sprite/water.png",
    colType = CollisionType.WATER,
  }
  return _w
end