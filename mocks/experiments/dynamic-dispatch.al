
unittest
{
    // Example method containers
    method = 'some_cool_method'

    // Call a variable method
    // Probably this is only possible at compile-time, so all function
    // invocations can be dispatched and boiled down.

    obj.call(method)
    obj.call!method

    obj.method // Just invoke with string value? Could create problems during semantic analysis.
    obj.'method' // Confusing? I don't think using string literals makes sense
    obj.´method´
    obj.`method` // Ambiguous with syntax errors (missing property name). Will lead to trip traps.
    obj.(method) // Confusing
    obj.[method] // Confusing
    obj.<method> // Confusing
    obj.{method} // This looks good, doesn't it?
    obj#method
    obj?method
    obj::method
}

unittest
{
    struct Foo { }
    typename = 'Foo'

    obj = typename()
    obj = {typename}()
}
