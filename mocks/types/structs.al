
struct Foo
    f : number

    property foo
        return f + f

    fn add_foo()
        f = f + f

    fn add(x)
        f = f + x

struct Bar
    foo : Foo

    fn baz()
        foo.add_foo()
        return foo.foo

// This is a lazy number generator struct, implemented as a range
// A range is any type that provides a front and empty property, and a popFront
// function
struct Iota
    front : number
    end   : number
    step  : number = 1

    property empty
        return front >= end

    fn popFront()
        front += step

fn main()
    // Construct a Foo struct
    f = Foo

    f.add(5)
    // You can also write it like this
    f `add` 10
    // Member functions without arguments have to be called with dot and braces, though
    f.add_foo()
    println f.foo   // 30

    // Construct a Bar struct with its member foo set to f
    b = Bar f
    println b.baz() // 60

    // Prints all numbers from 0 to 9 (10 not included)
    foreach n in Iota 0, 10
        println n
