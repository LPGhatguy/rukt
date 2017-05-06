local lastId = 0

return function()
	lastId = lastId + 1
	return lastId
end