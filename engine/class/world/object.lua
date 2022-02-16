-- blueprint of a quad, for reference
-------------------------------------
-- _quad = {
--   { 1, 1,0,1,0,0,0,1,},
--   {-1,-1,0,0,1,0,0,1,},
--   { 1,-1,0,0,0,0,0,1,},
--   { 1, 1,0,1,0,0,0,1,},
--   {-1, 1,0,1,1,0,0,1,},
--   {-1,-1,0,0,1,0,0,1,},
-- }

function createPlane(width, height, cols, rows, depth, resolution)
  local terrain = {}
  local x_off = 0
  for x = 0, cols+1, 1 do
    terrain[x] = {}
    local y_off = 0
    for y = 0, rows+1, 1 do
      terrain[x][y] = love.math.noise(x_off, y_off)*depth
      y_off = y_off + resolution
    end
    x_off = x_off + resolution
  end
  local _plane = {}
  for x = 1, cols, 1 do
    for y = 1, rows, 1 do
      table.insert(_plane,{  x*width,     y*height,    terrain[x][y]     ,1,0,0,0,1})
      table.insert(_plane,{ (x-1)*width, (y-1)*height, terrain[x-1][y-1] ,0,1,0,0,1})
      table.insert(_plane,{  x*width,    (y-1)*height, terrain[x][y-1]   ,0,0,0,0,1})
      table.insert(_plane,{  x*width,     y*height,    terrain[x][y]     ,1,0,0,0,1})
      table.insert(_plane,{ (x-1)*width,  y*height,    terrain[x-1][y]   ,1,1,0,0,1})
      table.insert(_plane,{ (x-1)*width, (y-1)*height, terrain[x-1][y-1] ,0,1,0,0,1})
    end
  end
  return _plane
end