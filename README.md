AnLang-Specification
====================

Grammars, and *some* docs.

This repository contains the specifications for the proposed syntax and the behind-the-scenes mechanics of the runtime and its environment.

The vision behind AnLang
========================

AnLang aims to be a clutter-free language with an extensible and potentially evolvable syntax. It enables writing software based on simple contracts not bound to explicit definitions, but on exhibited traits, so software can work across different libraries and vendors with an uniform API.

Features
========

Not sure whether you like them, but I certainly do:

## Quite minimal syntax

Away with semicolons, since I always forget them. Also, editors and IDEs don't autocomplete semicolons, which is annoying. So we got rid of them.

## Whitespace-unaware (for the most part)

Never again spaces vs. tabs. Or at least the compiler does not care. Indentation is for people with IDEs. We don't break statements at newlines, nor do we provide any railguards for misplaced quotes and commas. Just, erm, follow the rail.

## Clever generic types

Instead of specific specialised classes, we rely on conventions for types. Also, it's possible to apply constraints to types, that are checked at both compile-time (as far as possible) and runtime.

See [this example](https://github.com/AnhNhan/AnLang-Specification/blob/master/mocks/types/type-capsule.al).

### Yes, this list is incomplete
