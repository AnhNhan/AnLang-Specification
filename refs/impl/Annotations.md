
Documentation comments
======================

An implementation should make documentation comments (`/++ ... +/` and `/// ...`) available for reflection.

I don't know what doc comments could be used for, though.

Annotations
===========

Built-in annotations
--------------------

Built-in annotations change the semantics of an object, and can change how they are treated for semantical analysis.

 - @impure

Typed annotations
-----------------

You can use both built-in and user-defined types to define annotations.

Benefits:

 - Correct usage is statically checked
 - Better differentiation during reflection

Untyped annotations
-------------------

Benefits:

 - Too lazy
