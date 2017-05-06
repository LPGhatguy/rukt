local root = (...):match("^(.-)%..-$")
local Layout = require(root .. ".Layout")

local HorizontalLayout = Layout:implement()

function HorizontalLayout:getBoxPosition(container, target)
	local x, y = 0, 0

	for _, item in ipairs(container.children) do
		if item == target then
			break
		end

		x = x + item.width
	end

	return x, y
end

return HorizontalLayout