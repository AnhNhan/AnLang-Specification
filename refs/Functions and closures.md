
NOTE: AST definitions coming soon-ish.

Functions
=========

Functions contain expressions and statements, and they are evaluated according to them once invoked.

Functions are pure by default, and can be declared impure when needed.

Functions themselves and their storage containers and symbols are immutable without exception.

Functions are first-class citizens or whatever it is called. They can be stored in variables, and can be passed around.

Functions may address values outside of the defined values within their scope. Currently, for pure functions, these values must be provably immutable.

An implementation may provide syntactic sugar for templates, though is not required to do so.

When no type or only type modifiers (e.g. `ref`, `mut`, etc.) have been specified as a type for an argument, it will be automatically duck-typed / templated. The actual type will be inferred from the invocation, an implementation may apply constraints for the duck-typed usage within the function.

Values defined in the scope of the functions and provided no types will infer their type from the value of the first assigned expression.

Remember that imports can be assigned to variables. They act as entry-point into foreign modules, kinda foreign symbol container. Fancy import auto-aliasing. The variable does not contain an actual value, nor can it be used as a value. It is simply for syntactically sugared nature.

## Definition scope

Defining a named function creates an eponymous symbol containing the defined function in the current scope. If the function was defined on module scope, the symbol is available module-wide and may be imported in other modules and aliased freely. Defining a named function in the scope of another function makes it available only within that scope, the existence of its symbol is only valid beginning with its point of definition, and may not be accessed outside of that scope by its name, qualified or not. It may still be passed around and used, though.

## Function overloading

Functions may be overloaded. This is done by defining another function with the same name, but with a different parameter set.

Currently, pure and impure functions are covariant, meaning both can exist at the same time. The pure version is preferred for pure callers, while impure callers will get the impure one.

Closures
========

Fancy name, actually anonymous functions / lamba.

It's syntactic sugar to write functions. Strict pure, must evaluate to a value.

It may contain multiple expressions, if the implementation's syntax makes this possible.

It may only address parameter values and immutable external values to guarantee purity. It may currently not declare new values.

It's up to the implementation to require explicit returns or provide syntactic sugar.

Implementation-wise, closures act like any function definition. Its parameters' types are inferred where needed, as is its return type.
