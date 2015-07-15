
NOTE: AST definitions coming soon-ish.

Structs
=======

A struct is a simple but effective way to store multiple values together is by aggregating these into a struct.

A struct is distinguished by its fully qualified name. Two structs with the same name and the same members defined in two different modules are considered different. A way to allow two different structs to be allowed would be to 1) use `type` definitions or 2) specify the type hint as `act-like` (in design, you may not find any infos on that).

Member functions
----------------

A struct actually has no member functions. Defining a function inside a struct simply defines a global function with the same name but operating on the specific type.

The signature of a function `#foo(val1, val2)` operating on a type `Bar` may actually look like this: `fn foo(ref this : Bar, val1, val2)`. An expression looking like `bar.foo(val1, val2)` may be rewritten as `foo(bar, val1, val2)` internally. ~~Implementations may apply different rewrite rules to comply with existing standards, e.g. the C++ object calling convention.~~
