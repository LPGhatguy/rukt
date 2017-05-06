local root = (...):match("^(.-)%..-$")
local Layout = require(root .. ".Layout")

local FlexLayout = Layout:implement()

function FlexLayout:getBoxPosition(container, target)
	local w, h = container.width, container.height
	local x, y = 0, 0
	local itemsInRow = 0
	local rowHeight = 0

	for _, item in ipairs(container.children) do
		local fits = (itemsInRow == 0) or (x + item.width <= w)

		if not fits then
			y = y + rowHeight
			x = 0
			itemsInRow = 0
			rowHeight = 0
		end

		rowHeight = math.max(rowHeight, item.height)

		if item == target then
			break
		end

		x = x + item.width
		itemsInRow = itemsInRow + 1
	end

	return x, y
end

return FlexLayout