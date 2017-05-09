local Node = {}

Node.__index = Node

function Node:new()
	local new = {
		_predicates = {}
	}

	setmetatable(new, self)

	return new
end

function Node:predicate(...)
	for i = 1, select("#", ...) do
		local item = select(i, ...)
		table.insert(self._predicates, item)
	end

	return self
end

function Node:_congealInternal(i, ...)
	local constraint = self._predicates[i]

	if not constraint then
		return ...
	end

	return self:_congealInternal(i + 1, constraint(self, ...))
end

function Node:congeal(...)
	return self:_congealInternal(1, ...)
end

return Node