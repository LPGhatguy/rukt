local Rukt = require("rukt")
local Box = Rukt.Box
local FlexLayout = Rukt.FlexLayout

local boxes = {}

for i = 1, 15 do
	table.insert(boxes, Box:new(50, 50))
end

local t = 0

local layout = Box:new(300, 300):layout(FlexLayout):add(
	unpack(boxes)
)

local colors = {
	[layout] = {92, 192, 92}
}

local function renderBox(box)
	if colors[box] then
		love.graphics.setColor(colors[box])
	else
		love.graphics.setColor(192, 92, 92)
	end
	love.graphics.rectangle("fill", 0, 0, box.width, box.height)

	love.graphics.setColor(92, 92, 92)
	love.graphics.setLineWidth(2)
	love.graphics.rectangle("line", 0, 0, box.width, box.height)

	for _, child in ipairs(box.children) do
		local x, y = child:getRelativePosition()
		love.graphics.push()
		love.graphics.translate(x, y)

		renderBox(child)

		love.graphics.pop()
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.translate(50, 50)

	renderBox(layout)

	love.graphics.pop()
end

function love.update(dt)
	t = t + dt

	layout.width = 300 + 100 * math.cos(t * 2)
	layout.height = 300 + 100 * math.sin(t * 2)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end