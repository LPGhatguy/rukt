# Rukt
***A box layout library for Lua.***

Rukt is a work-in-progress library designed to lay out boxes. It can be incorporated into a larger UI toolkit to handle automatic layout.

See `main.lua` for the current demo.

## Design
The design I would like to implement involves creation of two trees: the *plan tree*, and the *concrete tree*.

Constraints and layout information is constructed as part of the plan tree. It's constructed by the consumer of the Rukt API and is a data structure optimized for writing. The plan tree offers no information for rendering the layout.

The consumer will then call a method on the plan tree to generate the concrete tree. The concrete tree contains nodes with bidirectional links to nodes in the plan tree. Each node in the concrete tree contains absolute position and size information, suitable for aiding in rendering.

## License
Rukt is available under the MIT license. See `LICENSE.md` for more details.