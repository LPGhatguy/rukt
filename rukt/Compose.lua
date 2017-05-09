local function composeHelper(predicates, i, ...)
	local predicate = predicates[i]

	if not predicate then
		return ...
	end

	return composeHelper(predicates, i + 1, predicate(...))
end

local function Compose(predicates)
	return function(...)
		return composeHelper(predicates, 1, ...)
	end
end

return Compose