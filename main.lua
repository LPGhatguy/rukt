local Rukt = require("rukt")
local Node = Rukt.Node

local t = 0

local function BoxPredicate(x, y, w, h)
	return function(abstract, concrete)
		concrete = concrete or {}

		concrete.x = x
		concrete.y = y
		concrete.w = w
		concrete.h = h

		return concrete
	end
end

local function Children(children)
	return function(abstract, concrete)
		concrete.children = {}

		for _, child in ipairs(children) do
			local items = {child:congeal()}
			for _, item in ipairs(items) do
				table.insert(concrete.children, item)
			end
		end

		return concrete
	end
end

local function DrawMode(mode)
	return function(abstract, concrete)
		concrete.mode = mode
		return concrete
	end
end

local function OffsetChildren(abstract, concrete)
	for _, child in ipairs(concrete.children) do
		child.x = child.x + concrete.x
		child.y = child.y + concrete.y
	end

	return concrete
end

local function WavyChildren(abstract, concrete)
	for key, child in ipairs(concrete.children) do
		child.y = child.y + 100 * math.sin(3 * t + 0.5 * key)
	end

	return concrete
end

local function BunchOfBoxesPredicate(abstract)
	local results = {}

	for i = 0, 7 do
		local object = BoxPredicate(50 * i, 100, 50, 50)(abstract)
		object = DrawMode("fill")(abstract, object)
		table.insert(results, object)
	end

	return unpack(results)
end

local function Box(x, y, w, h)
	return Node:new():predicate(BoxPredicate(x, y, w, h))
end

local function BunchOfBoxes()
	return Node:new():predicate(BunchOfBoxesPredicate)
end

local layout = Box(100, 100, 400, 300)
	:predicate(
		Children({
			BunchOfBoxes()
		}),
		OffsetChildren,
		WavyChildren
	)

local concrete = layout:congeal()

local function render(concrete)
	love.graphics.rectangle(concrete.mode or "line", concrete.x, concrete.y, concrete.w, concrete.h)

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
	t = t + dt
	concrete = layout:congeal(concrete)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end