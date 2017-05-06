local root = (...) .. "."

local modules = {
	"Box",
	"Layout",
	"NullLayout",
	"VerticalLayout",
	"HorizontalLayout",
	"FlexLayout"
}

local Rukt = {}

for _, moduleName in ipairs(modules) do
	Rukt[moduleName] = require(root .. moduleName)
end

return Rukt