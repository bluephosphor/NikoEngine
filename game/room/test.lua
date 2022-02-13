local _plane = createPlane(2,2,16,16,4, 0.1)

Room.Test = {
  name="test",
  objects = {
    {model=_plane, pos={0,18,-5}, colType = CollisionType.SOLID}
  }
}