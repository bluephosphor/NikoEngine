function pointIntersectingCube(pos, checkpos, width, height, depth)
  local px, py, pz = pos[1], pos[2], pos[3]
  local x, y, z    = checkpos[1], checkpos[2], checkpos[3]
  local x2, y2, z2 = checkpos[1]+width, checkpos[2]+height, checkpos[3]-depth


  return px > x and px < x2 and
         py > y and py < y2 and
         pz < z and pz > z2
end