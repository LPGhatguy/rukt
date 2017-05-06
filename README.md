# Rukt
***A box layout library for Lua.***

Rukt is a work-in-progress library designed to lay out boxes. It can be incorporated into a larger UI toolkit to handle automatic layout.

See `main.lua` for the current demo.

## Design
The design I would like to implement involves creating an abstract tree that gets *congealed* into a concrete tree.

The abstract tree contains all constraints wthin and between items, while the concrete tree contains absolute rendering information.

## License
Rukt is available under the MIT license. See `LICENSE.md` for more details.