local Layout = {}

function Layout:implement()
	local new = {}

	for key, value in pairs(self) do
		new[key] = value
	end

	return new
end

function Layout:getBoxPosition(items, index)
	error("Not implemented: Layout:layOut", 2)
end

return Layout