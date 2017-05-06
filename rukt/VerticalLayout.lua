local root = (...):match("^(.-)%..-$")
local Layout = require(root .. ".Layout")

local VerticalLayout = Layout:implement()

function VerticalLayout:getBoxPosition(container, target)
	local x, y = 0, 0

	for _, item in ipairs(container.children) do
		if item == target then
			break
		end

		y = y + item.height
	end

	return x, y
end

return VerticalLayout