local Rukt = require("rukt")

local state = {
	time = 0
}

local function Text(text)
	return function(concrete)
		concrete = concrete or {}

		concrete.text = text

		return concrete
	end
end

local function Box(x, y, w, h)
	return function(concrete)
		concrete = concrete or {}

		concrete.x = x
		concrete.y = y
		concrete.w = w
		concrete.h = h

		return concrete
	end
end

local function Circle(x, y, r)
	return function(concrete)
		concrete = concrete or {}

		concrete.x = x
		concrete.y = y
		concrete.r = r

		return concrete
	end
end

local function DrawMode(mode)
	return function(concrete)
		concrete.mode = mode
		return concrete
	end
end

local function HorizonalLayout(concrete)
	local x = concrete.x
	for _, child in ipairs(concrete.children) do
		child.x = x
		child.y = child.y + concrete.y
		x = x + child.w
	end

	return concrete
end

local function WavyChildren(state)
	return function(concrete)
		for key, child in ipairs(concrete.children) do
			child.y = child.y + 100 * math.sin(3 * state().time + 0.5 * key)
		end

		return concrete
	end
end

local function BunchOfBoxes()
	local results = {}

	for i = 0, 7 do
		local object = Rukt.Compose({
			Box(0, 100, 50, 50),
			Text("Hello " .. i),
			DrawMode("fill")
		})()
		table.insert(results, object)
	end

	return unpack(results)
end

local layout = Rukt.Compose({
	Box(50, 50, 400, 250),
	Rukt.Children({
		BunchOfBoxes
	}),
	HorizonalLayout,
	WavyChildren(function()
		return state
	end)
})

local concrete = layout()

local function render(concrete)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle(concrete.mode or "line", concrete.x, concrete.y, concrete.w, concrete.h)

	if concrete.text then
		love.graphics.setColor(255, 0, 0)
		love.graphics.print(concrete.text, concrete.x, concrete.y)
	end

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
	state.time = state.time + dt
	concrete = layout()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end