Queue = {}
function Queue.new()
  return {first = 1, last = 0}
end

--Now, we can insert or remove an element at both ends in constant time:

function Queue.pushleft(list, value)
  local first = list.first - 1
  list.first = first
  list[first] = value
end

function Queue.pushright(list, value)
  local last = list.last + 1
  list.last = last
  list[last] = value
end

function Queue.popleft(list)
  local first = list.first
  if first > list.last then error("list is empty") end
  local value = list[first]
  list[first] = nil        -- to allow garbage collection
  list.first = first + 1
  return value
end

function Queue.popright(list)
  local last = list.last
  if list.first > last then error("list is empty") end
  local value = list[last]
  list[last] = nil         -- to allow garbage collection
  list.last = last - 1
  return value
end

function Queue.size(list)
  --return list.last
  local s = 0
  for index, value in ipairs(list) do
    s = s + 1
  end
  return s
end

function Queue.display(list)
  local str = '{'
  for key, value in ipairs(list) do  
    str = str .. key .. ":" .. value .. ','
  end
  print(str .. '}')
end