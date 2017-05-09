# Rukt
Rukt is a work-in-progress library designed to lay out and constrain objects using lists of predicates. Because it has no dependencies and has a tiny footprint, it's perfect for embedding into a larger library.

The primary use case envisioned for Rukt is as the box layout engine for a UI engine.

See `main.lua` for the current demo.

## Design
The Rukt model is based on creation of two graphs, used to model the constraints and inputs of a problem separately from the output.

### Abstract Graph
The *abstract graph* consists of one or more nodes that each have a series of "predicates" attached to them.

A predicate is just a function that has the signature `(abstractNode, ...) -> ...`. The result from each predicate is passed into the next predicate attached to the node. The final predicate's return values represent the result of *congealing* the abstract graph into a concrete graph.

### Concrete Graph
The *concrete graph* is the end result of *congealing* the abstract graph. Because each abstract graph node can return 0 or more nodes, the concrete graph is not guaranteed to resemble its source.

The concrete graph is intended to be the most condensed representation of the constraints defined in the abstract graph.

### Other Design Notes
Generally, the abstract graph will be a tree and the concrete graph will be a tree or list. The data structures used for both the input and output are completely flexible.

## License
Rukt is available under the MIT license. See `LICENSE.md` for more details.