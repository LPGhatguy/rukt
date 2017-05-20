--[[
	Takes a list of abstract nodes and returns a predicate that attaches these
	nodes to a single concrete node.
]]

local function ChildrenPredicate(children)
	return function(concrete, ...)
		concrete.children = {}

		for _, child in ipairs(children) do
			local items = {child(...)}
			for _, item in ipairs(items) do
				table.insert(concrete.children, item)
			end
		end

		return concrete, ...
	end
end

return ChildrenPredicate