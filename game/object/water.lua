function Water(x,y,z,width,height,depth)
  local _tileSize = 4
  local _plane = createPlane(_tileSize,_tileSize,width,height,0,0)
  local _w = {
    model   = _plane,
    shader  = Shader.trans,
    pos     = {x,y,z},
    width   = width*_tileSize,
    height  = height*_tileSize,
    depth   = depth and depth or 32,
    alpha   = 0.4,
    texture = "asset/sprite/water.png",
    colType = CollisionType.WATER,
  }
  return _w
end