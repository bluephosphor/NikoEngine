local _lake = createPlane(4,4,7,8,0,0)

Room.Arena = {
  name = "arena",
  defaultSpawn = {0,-35,0.85},
  objects = {
    {
      model   = "crystal",
      colType = CollisionType.SOLID,
      shader  = Shader.trans,
      alpha   = 0.5,
      pos     = {0,0,0}
    },
    {
      model   = "crystal",
      colType = CollisionType.SOLID,
      shader  = Shader.trans,
      alpha   = 0.5,
      pos     = {71,-28,-2}
    },
    Water(0,-36,-1.8,16,5)
  }
}