local Node = {}

Node.__index = Node

function Node:new()
	local new = {
		constraints = {}
	}

	setmetatable(new, self)

	return new
end

function Node:constrain(...)
	for i = 1, select("#", ...) do
		local item = select(i, ...)
		table.insert(self.constraints, item)
	end

	return self
end

function Node:congeal(concreteNode, context)
	context = context or {
		stack = {}
	}
	concreteNode = concreteNode or {
		abstractNode = self
	}

	table.insert(context.stack, concreteNode)

	for _, constraint in ipairs(self.constraints) do
		constraint(self, concreteNode, context)
	end

	table.remove(context.stack, #context.stack)

	return concreteNode
end

return Node