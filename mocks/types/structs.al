
struct Foo
    number f

    property foo
        return f + f

    add_foo()
        f = f + f

    add(x)
        f = f + x

struct Bar
    Foo foo

    baz()
        foo.add_foo()
        return foo.foo

// This is a lazy number generator struct, implemented as a range
// A range is any type that provides a front and empty property, and a popFront
// function
struct Iota
    number front
    number end
    number step = 1

    property empty
        return front >= end

    popFront()
        front += step

main()
    // Construct a Foo struct
    f = Foo

    f.add(5)
    // You can also write it like this
    f add 10
    // Member functions without arguments have to be called with dot and braces, though
    f.add_foo()
    println f.foo   // 30

    // Construct a Bar struct with its member foo set to f
    b = Bar f
    println b.baz() // 60

    // Prints all numbers from 0 to 9 (10 not included)
    foreach n in Iota 0, 10
        println n
