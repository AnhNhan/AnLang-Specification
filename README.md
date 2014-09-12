AnLang-Specification
====================

NOTE: I should tell you that this language does not depend on the actual
      aesthetics of the character stream, and as such does not have a
      recommended syntax. I will be simply using a Python/Haskell-based syntax
      with curly braces here. It will be similar to the syntax used in the
      reference implementation.

Grammars, and *some* docs.

This repository contains the specifications for the proposed features and the behind-the-scenes mechanics of the single components in AnLang's infrastructure, runtime and environment.

The [reference implementation] is written in the [D programming language].

The vision behind AnLang
========================

AnLang aims to be a uniform language with powerful expressivity of abstractions. It enables writing software based on simple contracts not bound to explicit definitions, but on exhibited traits, so software can work across different libraries and vendors with an uniform API.

Features
========

Not sure whether you like them, but I certainly do:

## Pretty minimal syntax*

Away with semicolons, since I always forget them. Also, editors and IDEs don't autocomplete semicolons, which is annoying. So we got rid of them.

## Whitespace-unaware (for the most part)*

Never again spaces vs. tabs. Or at least the compiler does not care. Indentation is for people with IDEs. We don't break statements at newlines, nor do we provide any rail guards for misplaced quotes and commas. Just, erm, follow the rail.

## Modern paradigms

Pure functions and immutable data structures are the latest craze. Everybody wants native generic code. Lots of types are inferred.

Supports generative programming. Parametric templates, compile-time reflection.

## Clever generic types

Instead of specific specialized classes, we rely on conventions for types. Also, it's possible to apply constraints to types, that are checked at both compile-time (as far as possible) and runtime.

See [this example](https://github.com/AnhNhan/AnLang-Specification/blob/master/mocks/types/type-capsule.al).

### * Applies to the reference implementation

#### Yes, this list is incomplete

Basic Syntax
============

Try out the basics!

```anlang
fn main()
{
    print "Hello World!"
}
```

It's easy as that. Ok, it looks like Python, I know. Try this!

```anlang
type InputRange
{
    has fn popFront()
    has property front
    has property empty -> bool
    test
    {
        // Can initialize
        range = typeof(this).init
    }
}

alias ElementType(T) = typeof(T.init.front.init)

// The range primitives for arrays

// First parameter set are template parameters. You know, like in C++.
// It is inferred from the passed types, usually you don't need to explicitly supply it.
@property
fn front(T)(array : T[])
{
    return array[0]
}

@property
fn empty(T)(array : T[])
{
    return array.lenth eq 0
}

fn popFront(T)(ref array : T[])
{
    array = array[1..array.length]
}

/++
  Converts a range eagerly to a dynamic-length array
 +/
// `T : InputRange` is a specialized template parameter. Any type T that fits
// the input range interface (`.front`, `.empty`, `.popFront()`). See the
// definition at the top of this example.
@property
fn array(T : InputRange)(range : T)
{
    arr : ElementType!T[] = []

    foreach x in range
    {
        arr ~= x
    }

    return arr
}

/++
  Lazily map a function over a range.
 +/
fn map(T : InputRange)(range : T, fun : fn(ElementType!T))
{
    struct MapRange
    {
        source : T

        property empty() return source.empty
        property front() return fun(source)

        fn popFront()
        {
            source.popFront()
        }
    }

    return MapRange(range, fun(range.front))
}

unittest
{
    arr = [1, 2, 3]

    doubled = arr `map` x -> x * 2
    assert doubled.array == [2, 4, 6]

    squared = arr `map` x -> x * x
    assert squared.array == [1, 4, 9]
}
```
