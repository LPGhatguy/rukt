local Rukt = require("rukt")
local Box = Rukt.Box

local function Children(...)
	local children = {...}
	return function(abstract, concrete)
		for _, child in ipairs(children) do
			table.insert(abstract.children, child)
		end
	end
end

local function Color(r, g, b)
	return function(abstract, concrete)
		concrete.color = {r, g, b}
	end
end

local function VerticalLayout(abstract, concrete)
	local y = concrete.y

	for _, childNode in ipairs(abstract.children) do
		local concreteChild = childNode:createConcreteNode()
		concreteChild.y = y

		childNode:congeal(concreteChild)

		y = y + concreteChild.height

		table.insert(concrete.children, concreteChild)
	end
end

local function sizeConstraint(w, h)
	return function(abstract, concrete)
		concrete.width = w
		concrete.height = h
	end
end

local function fitContents(abstract, concrete)
	local totalW, totalH = 0, 0

	for _, child in ipairs(concrete.children) do
		totalW = math.max(totalW, child.x + child.width - concrete.x)
		totalH = math.max(totalH, child.y + child.height - concrete.y)
	end

	concrete.width = totalW
	concrete.height = totalH
end

local function sizedBox(w, h, ...)
	return Box:new()
		:addConstraints(...)
		:addConstraints(
			sizeConstraint(w, h),
			VerticalLayout
		)
end

local layout = sizedBox(300, 300,
		Children(
			sizedBox(200, 200,
				Children(
					sizedBox(100, 50),
					sizedBox(50, 50, Color(255, 0, 0)),
					sizedBox(100, 50)
				)
			)
			:addConstraints(
				fitContents
			)
		)
	)

local concrete = layout:congeal()

local function render(concrete)
	if concrete.color then
		love.graphics.setColor(concrete.color)
	else
		love.graphics.setColor(255, 255, 255)
	end
	love.graphics.rectangle("line", concrete.x, concrete.y, concrete.width, concrete.height)

	for _, child in ipairs(concrete.children) do
		render(child)
	end
end

function love.draw()
	love.graphics.translate(50, 50)
	render(concrete)
end

function love.update(dt)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end