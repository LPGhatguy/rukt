local Box = {}

Box.__index = Box

function Box:new()
	local new = {
		children = {},
		constraints = {}
	}

	setmetatable(new, self)

	return new
end

function Box:addConstraints(...)
	for i = 1, select("#", ...) do
		local item = select(i, ...)
		table.insert(self.constraints, item)
	end

	return self
end

function Box:createConcreteNode()
	local concreteNode = {}

	concreteNode.abstractNode = self
	concreteNode.children = {}
	concreteNode.width = 0
	concreteNode.height = 0
	concreteNode.x = 0
	concreteNode.y = 0

	return concreteNode
end

function Box:congeal(concreteNode, context)
	context = context or {
		stack = {}
	}
	concreteNode = concreteNode or self:createConcreteNode()

	table.insert(context.stack, concreteNode)

	for _, constraint in ipairs(self.constraints) do
		constraint(self, concreteNode, context)
	end

	table.remove(context.stack, #context.stack)

	return concreteNode
end

return Box