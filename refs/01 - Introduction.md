Introduction
============

The only thin I have to say about this reference:

This language is not specified by its syntax. The syntax is specified by the implementation.

Instead, we simply describe language features and implementation behaviors here. These implementations will then provide a valid abstract syntax tree to the AnLang middleware, which interfaces with one or more compiler / execution back-ends.

If you want to stick to the syntax of the reference implementation, that's fine by me.

Reading this doc
================

The only convention you have to know so far: Functions that operate on a certain type get written like this: `#foo(arg1, arg2)`. People might know this as `Bar#foo(arg1, arg2)` or even `Bar::foo(arg1, arg2)` from Java, Perl, PHP etc.. We leave the type away, since it's kind of obvious any way. And we actually do some special kind of stuff to it (our functions aren't attached to types).

Workings of AnLang
==================

```
     Lexer    Parser                     Semantic Analysis                 Optimization       Linking
        [Front-end]            Reflection  [AnLang Middle-end]                [Compiler Back-end]
  Macro Processing               Code assembly      Type processing         Executable Creation
        Syntactic sugaring
```

## Front-end

### Lexer & Parser

Provides custom syntax, transforms into an intermediate AST.

### Macro processing

Stuff like pattern matching code, property and behavior functions get expanded.

### Syntactic sugaring

Rewrites syntactic sugar to regular code. Infix function calls get rewritten as regular function calls, operator overloads and runtime data types (e.g. associative arrays) get resolved.

## AnLang Middle-end

The middle-end is passed the processed AST. The actual mechanics behind AnLang grind their gears here.

### Code assembly

Generates & instantiates templates, resolves conditional compilation branches, assembles unit tests and debug code.

Later also generates the code for the back-end.

### Semantic Analysis

Checks types and annotations for soundness. Pure functions only do pure stuff, all values pass type constraints, no impossible operations (e.g. structs without `opCall` getting invoked).

### Reflection

### Type processing

Quasi-monad resolving. Reflections gets done, attributes processed etc.

## Compiler Back-end

Communicates with GCC, LLVM or whatever we use on the backend. Figures out optimizations, links in external libraries, creates the executable, etc.
