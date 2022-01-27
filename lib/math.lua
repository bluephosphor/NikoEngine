function lerp(a, b, t)
	local _v = a + (b - a) * t
  return math.abs(_v) > 0.1 and _v or b
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


function Vector(x1,y1,x2,y2)
  local _v = {
    a = x1-x2,
    b = y1-y2,
  }
  _v.dirRad = math.atan2(_v.b, _v.a)
  _v.direction = math.deg(-_v.dirRad) + 180 % 360
  _v.distance  = math.sqrt(_v.a*_v.a + _v.b*_v.b)

  return _v
end