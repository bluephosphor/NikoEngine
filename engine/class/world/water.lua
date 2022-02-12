--create a grid of triangles

function createPlane(width, height, cols, rows)
  local _plane = {}
  for y = 1, cols, 1 do
    for x = 1, rows, 1 do
      table.insert(_plane,{x,    y,    0})
      table.insert(_plane,{x,    y+1,  0})
      table.insert(_plane,{x+1,  y,    0})
      --table.insert(_plane,{x+1,  y+1,  0})
    end
  end
  return _plane
end