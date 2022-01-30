---@diagnostic disable: lowercase-global
function Vec2(x,y)
  return { x = x, y = y }
end

function approach(a, b, increment)
  if (a < b) then
    a = a + increment
    if (a > b) then
      return b
    end
  else
    a = a - increment
    if (a < b) then
      return b
    end
  end
  return a
end


function wrap(val,min,max)
  if val > max then
    return min
  elseif val < min then
    return max
  end
  return val
end

function clamp(val,min,max)
  if val > max then
    return max
  elseif val < min then
    return min
  end
  return val
end