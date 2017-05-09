local root = (...) .. "."

local modules = {
	"Node"
}

local Rukt = {}

for _, moduleName in ipairs(modules) do
	Rukt[moduleName] = require(root .. moduleName)
end

return Rukt