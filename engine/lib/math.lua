---@diagnostic disable: lowercase-global

function lerp(a, b, t, nosnap)
  local _v = a + (b - a) * t
  if nosnap then
    return _v
  else
    return math.abs(_v) > 0.01 and _v or b
  end
end

function bin(var)
  return var and 1 or 0
end

function floorToPrecision(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult) / mult
end

function lengthdir_x(dist, angle)
  return dist * -math.cos(angle)
end

function lengthdir_y(dist, angle)
  return dist * -math.sin(angle)
end

function MovementVector(x1,y1,x2,y2)
  local _v = {
    x1 = x1,
    y1 = y1,
    x2 = x2,
    y2 = y2,
    a = x1-x2,
    b = y1-y2,
  }
  _v.dirRad     = floorToPrecision(math.atan2(_v.b, _v.a), 2)
  _v.direction  = floorToPrecision(math.deg(-_v.dirRad) + 180)
  _v.distance   = floorToPrecision(math.sqrt(_v.a*_v.a + _v.b*_v.b))

  return _v
end


function merge_number(num1, num2, amount)

  if num1 == nil then return 0 end
  if num2 == nil then return 0 end

	local diff = num1 - num2;
	local merged = num1 - (diff * amount);

	return merged;
end


function merge_color(col1,col2,amt)

  local r1,r2,g1,g2,b1,b2 =
  col1[1], col2[1],
  col1[2], col2[2],
  col1[3], col2[3]
  local a1 = col1[4] and col1[4] or 1
  local a2 = col2[4] and col2[4] or 1

  local rdiff = r1 - r2;
  local gdiff = g1 - g2;
  local bdiff = b1 - b2;
  local adiff = a1 - a2;
	local rmerged = r1 - (rdiff * amt);
	local gmerged = g1 - (gdiff * amt);
	local bmerged = b1 - (bdiff * amt);
	local amerged = a1 - (adiff * amt);

	return {rmerged,gmerged,bmerged,amerged};
end

function BlendNumbers(numbers, steps, i)
  local cc = i / steps * #numbers
  local c1 = numbers[math.max(math.floor(cc), 1)]
  local c2 = numbers[math.ceil(cc)]

  return merge_number(c1,c2, cc - math.max(math.floor(cc), 1))
end