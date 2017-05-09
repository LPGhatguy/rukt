local Rukt = require("rukt")
local Node = Rukt.Node

-- Higher-order constraint to copy specific properties 1:1
local function copyPropertiesConstraint(props)
	return function(abstract, concrete)
		for _, propName in ipairs(props) do
			concrete[propName] = abstract[propName]
		end
	end
end

-- Higher-order constraint to add children to a node
local function childrenConstraint(children)
	return function(abstract, concrete, context)
		concrete.children = concrete.children or {}

		for _, child in ipairs(children) do
			local concreteChild = child:congeal(nil, context)
			table.insert(concrete.children, concreteChild)
		end
	end
end

local function horizontalCenterConstraint(abstract, concrete)
	for _, child in ipairs(concrete.children) do
		child.x = concrete.x + concrete.w / 2 - child.w / 2
	end
end

-- Constraint that vertically lays out box children
-- Depends on children with a 'y' property and an 'h' property
local function verticalLayoutConstraint(abstract, concrete)
	local y = concrete.y
	for _, child in ipairs(concrete.children) do
		child.y = y
		y = y + child.h
	end
end

local positionSizeConstraint = copyPropertiesConstraint({"x", "y", "w", "h"})

local function Box(x, y, w, h)
	local node = Node:new()
	node.x = x
	node.y = y
	node.w = w
	node.h = h
	node:constrain(positionSizeConstraint)

	return node
end

local layout = Box(50, 50, 100, 100)
	:constrain(
		childrenConstraint({
			Box(0, 0, 50, 50),
			Box(0, 0, 50, 50)
		}),
		offsetChildrenConstraint,
		horizontalCenterConstraint,
		verticalLayoutConstraint
	)

local concrete = layout:congeal()

local function render(concrete)
	love.graphics.rectangle("line", concrete.x, concrete.y, concrete.w, concrete.h)

	if concrete.children then
		for _, child in ipairs(concrete.children) do
			render(child)
		end
	end
end

function love.draw()
	render(concrete)
end

function love.update(dt)
end

function love.mousepressed(x, y, button)
	if button == 1 then
		layout.w = x - 50
		layout.h = y - 50
		concrete = layout:congeal()
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end