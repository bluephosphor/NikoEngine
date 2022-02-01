Color = {}

Color.define = function(r,g,b,a)
  return { r=r , g=g , b=b , a=a }
end

Color.set = function(c)
  love.graphics.setColor(c.r,c.g,c.b, c.a)
end

Color.reset = function()
  love.graphics.setColor(1,1,1)
end

Color.red     = Color.define(1,0,0,1)
Color.white   = Color.define(1,1,1,1)
Color.black   = Color.define(0,0,0,0)
Color.green   = Color.define(0,1,0,0)
Color.blue    = Color.define(0,0,1,1)
Color.yellow  = Color.define(1,1,0,1)
Color.purple  = Color.define(1,0,1,1)
Color.orange  = Color.define(1,1,0,1)
Color.ice     = Color.define(0.5,1,1,1)

Color.menuBack = Color.define(1,1,1,0.2)
Color.menuOutline = Color.white