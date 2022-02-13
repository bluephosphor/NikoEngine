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

function range(min, max)
-- returns an array of successive integers within a range
-- useful for setting sprite animations
  local _table = {}
  for num = min, max, 1 do
    table.insert(_table, num)
  end
  return _table
end

function enum(tbl)
-- assumes the tbl is an array, i.e., all the keys are
-- successive integers - otherwise #tbl will fail
  local length = #tbl
  for i = 1, length do
      local v = tbl[i]
      tbl[v] = i
  end

  return tbl
end

function strsplit (inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function serializeTable(val, name, skipnewlines, depth)
  skipnewlines = skipnewlines or false
  depth = depth or 0

  local tmp = string.rep(" ", depth)

  if name then tmp = tmp .. name .. " = " end

  if type(val) == "table" then
      tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

      for k, v in pairs(val) do
          tmp =  tmp .. serializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
      end

      tmp = tmp .. string.rep(" ", depth) .. "}"
  elseif type(val) == "number" then
      tmp = tmp .. tostring(val)
  elseif type(val) == "string" then
      tmp = tmp .. string.format("%q", val)
  elseif type(val) == "boolean" then
      tmp = tmp .. (val and "true" or "false")
  else
      tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
  end
  return tmp
end