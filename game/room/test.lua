local _plane = createPlane(4,4,8,8,3, 0.4)
local _plane2 = createPlane(4,4,8,8,3, 0.4)

Room.Test = {
  name="test",
  objects = {
    {model=_plane2,  pos={0,18,-5}, colType = CollisionType.SOLID},
    {model=_plane, pos={0,50,-5}, colType = CollisionType.SOLID},
  }
}