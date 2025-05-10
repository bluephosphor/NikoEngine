function pointIntersectingCube(pos, checkpos, width, height, depth)
  local px, py, pz = pos[1], pos[2], pos[3]
  local x,  y,  z  = checkpos[1], checkpos[2], checkpos[3]
  local x2, y2, z2 = checkpos[1]+width, checkpos[2]+height, checkpos[3]-depth


  return px > x and px < x2 and
         py > y and py < y2 and
         pz < z and pz > z2
end

DTQueue = {}
DTQueue.data = queue.create()
DTQueue.currentSize = 0
DTQueue.maxSize = 5
DTQueue.insert = function(value)
  DTQueue.data:insert(value)
  DTQueue.currentSize = DTQueue.currentSize + 1

  if DTQueue.currentSize > DTQueue.maxSize then
    DTQueue.data:pop()
    DTQueue.currentSize = DTQueue.currentSize - 1
  end
end
DTQueue.getAverage = function()
  local queue = DTQueue.data:getAsList()
  local total = 0
  for i, v in ipairs(queue) do total = total + v end
  return total / DTQueue.maxSize
end