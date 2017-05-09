local root = (...) .. "."

local modules = {
	"ChildrenPredicate",
	"Compose"
}

local Rukt = {}

for _, moduleName in ipairs(modules) do
	Rukt[moduleName] = require(root .. moduleName)
end

return Rukt