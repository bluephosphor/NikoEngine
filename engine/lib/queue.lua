local function reverse(tb)
	local ret = {}
	for i = #tb, 1, -1 do
		table.insert(ret, tb[i])
	end
	return ret
end


--##############################################################################
local Node = {}
function Node.create(val, prev)
	return {val = val, prev = prev}
end


--##############################################################################
queue = {}

function queue.create()
	local mt =
	{
		__index = queue,
		__tostring = queue.show,
	}

	local q =
	{
		init = nil,
		last = nil,
	}

	return setmetatable(q, mt)
end

function queue.insert(q, val)
	local node = Node.create(val)
	if q.init == nil then -- => queue is empty
		q.last = node
	else
		q.init.prev = node
	end
	q.init = node

	return q
end

function queue.pop(q)
	local ret = q.last.val
	q.last = q.last.prev
	return ret
end

function queue.show(q)
	local nodes = {}
	local it = q.last
	while it ~= nil do
		table.insert(nodes, it.val)
		it = it.prev
	end
	nodes = reverse(nodes)
	for i, node in ipairs(nodes) do
		nodes[i] = '{'.. tostring(node) .. '}'
	end
	return table.concat(nodes, '<-')
end

function queue.getAsList(q)
	local nodes = {}
	local it = q.last
	while it ~= nil do
		table.insert(nodes, it.val)
		it = it.prev
	end
	return reverse(nodes)
end

--##############################################################################
function showtable(tb)
	local aux = {}
	for i, v in ipairs(tb) do
		table.insert(aux, tostring(v))
	end
	local parts = {'[', table.concat(aux, ', '), ']'}
	return table.concat(parts)
end