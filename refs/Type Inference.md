
Type Inference
==============

Obviously, type inference should go way beyond just looking up the return type of the called function.

Examples:

```
// Expressing generic constraints (two members should have the same type)
struct Foo(T)
{
    bar : T
    baz : T

    this(_bar, _baz)
    {
        bar = _bar
        baz = _baz
    }
}

unittest
{
    Foo(1, 2)
    Foo(1.0, 2.0)

    f = Foo(1, 2.0)
    assert typeof(f.bar) is typeof(f.baz)

    Foo('1', 2) // error
}
```
