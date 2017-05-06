local root = (...):match("^(.-)%..-$")
local Layout = require(root .. ".Layout")

local NullLayout = Layout:implement()

function NullLayout:getBoxPosition(container, target)
	return 0, 0
end

return NullLayout