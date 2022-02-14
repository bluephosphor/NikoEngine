Color = {}

Color.define = function(r,g,b,a)
  return { r, g, b, a }
end

Color.set = function(color, alpha)
  local c = Color[color]
  love.graphics.setColor(c[1],c[2],c[3], alpha and alpha or 1)
end

Color.get = function(color, alpha)
  local c = Color[color]
  return {c[1],c[2],c[3], alpha and alpha or 1}
end

Color.reset = function()
  love.graphics.setColor(1,1,1)
end


Color.red     = { 1, 0, 0 }
Color.white   = { 1, 1, 1 }
Color.black   = { 0, 0, 0 }
Color.green   = { 0, 1, 0 }
Color.blue    = { 0, 0, 1 }
Color.yellow  = { 1, 1, 0 }
Color.purple  = { 1, 0, 1 }
Color.orange  = { 1, 1, 0 }
Color.ice     = { 0, 5, 1 }

Color.dkgray   = merge_color(Color.white, Color.black, 0.9)
Color.dkpurple = merge_color(Color.purple, Color.black, 0.5)