local root = (...):match("^(.-)%..-$")
local NullLayout = require(root .. ".NullLayout")

local Box = {}

Box.__index = Box

function Box:new(width, height)
	local new = {
		width = width,
		height = height,
		children = {},
		currentLayout = NullLayout,
		parent = nil
	}

	setmetatable(new, self)

	return new
end

function Box:layout(layout)
	self.currentLayout = layout

	return self
end

function Box:add(...)
	for i = 1, select("#", ...) do
		local item = select(i, ...)
		table.insert(self.children, item)
		item.parent = self
	end

	return self
end

function Box:getRelativePosition()
	if not self.parent then
		return 0, 0
	end

	return self.parent.currentLayout:getBoxPosition(self.parent, self)
end

function Box:getAbsolutePosition()
	local x, y = self:getRelativePosition()

	-- Crawl up descendants and sum their positions
	local ancestor = self.parent
	while ancestor do
		local ox, oy = ancestor:getAbsolutePosition()
		x = x + ox
		y = y + oy

		ancestor = ancestor.parent
	end

	return x, y
end

function Box:getAbsoluteSize()
	return self.width, self.height
end

return Box