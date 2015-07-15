
type Switch = On | Off
type On = of singleton on
type Off = of singleton off

lights = on // of type Switch

---------------------------------

type View<Pixel, dimensions: Integer.StrictlyPositive>
    sizes: Integer.ZeroOrPositive[dimensions]
    operator indexGet(*Integer.ZeroOrPositive[dimensions]): Pixel

// Using : because I don't want to argue whether to use extends, implements,
// satisfies or bother to choose a suitable sigil
"Specialization for images so you won't go insane typing so many index accesses."
type View2D<Pixel> : View<Pixel, 2>
    width -> sizes[0]
    height -> sizes[1]
    operator indexGet(x: Integer.ZeroOrPositive, y: Integer.ZeroOrPositive): Pixel

// ...--<...> is a handle you can pack the generic parameter at and throw across
// the room, just like all those code athletes!
// Just kidding, just trying to annoy the Rust guys here
fn procedural--<formula: fn(*Integer.ZeroOrPositive[dimensions]) : Pixel, Pixel, dimensions: Integer.StrictlyPositive>(inputSizes*: Integer.ZeroOrPositive[dimensions])
    struct Procedural -> View<Pixel, dimensions>
        if dimensions eq 2
            width = inputSizes[0]
            height = inputSizes[1]

        sizes = inputSizes
        operator indexGet(coords*: Integer.ZeroOrPositive[dimensions])
                -> formula(*coords)
    return Procedural()

// Question: Is that currying, or D's templating parameter syntax?
fn solid(c)(sizes*)
                // That looks like an emoticon, haha
    -> procedural--<(_*)->c>(*sizes)

test "something something solid something"
    // Don't test *every* single dimension, leave some untested so we can still
    // have 3D games if we blow them up
    for _ in 4..Integer.maximum
        // Let's just assume it was D's templating parameter syntax
        // Lol, this looks like an even funnier emoticon
        assert solid!(_->0)(3,3)[0,0] eq 0

---------------------------------

"* Coolest comments ever *"
(: This is cooler than yours! :)

---------------------------------

// Silly

/*
    Multiple function parameter sets: Spreads the parameter set of the function over deeply nested functions

    fn foo(x)(y)(z)
        return x + y + z

    // Alternatively
    fn foo(x)
        return (y) -> (z) -> x + y + z

    Useful for usually curried functions, or function factories
 */
fn literal<InputElement>(literal: InputElement)(input: List<InputElement>)
    if input.first eq literal
        return ok(literal, input.rest) // .rest for arrays / strings is simply defined as (array) -> array[1..$]
    else
        return error(input, "Expected #[literal], got #[input.first]")

test "Introspectable function invocations"
    val a = literal('a')
    // AppliedFunction<fun: Function, TypeArguments: N-Tuple<Type<?>>, invokedValues: TypeArguments, invokationArguments: N-Tuple<Type<?>>>
    assert type(literal('a')) is AppliedFunction<literal, [Character], ['a'], [List<InputElement>]>
    print refl(a).appliedParameters

---------------------------------

// What?

type NumberBox<Number: covariant Integer>
    value num: Number

// Contravariant. Inferred or explicitly stated?
fn positiveUnwrap<PosNumber: Integer.ZeroOrPositive>(box: NumberBox<PosNumber>)
    return box.num

test "stuff"
    // 'Instantiate' types/interfaces?
    box1 = NumberBox { num = 1 }
    // Like any other type?
    box2 = NumberBox(-1)

    positiveUnwrap(box1) // 1
    positiveUnwrap(box2) // Type error, value range error, -1 not in Integer.ZeroOrPositive

---------------------------------

test "s-expr-madness"
    num1 = (1) // Harmless
    num2 = (2) // Also harmless
    result = (add num1 num2) // Madness is starting
    result2 = (add (add num1 num1) (add num2 num2)) // OMG, why am I doing this

---------------------------------

test "commas"
    list = [
        "foo",
        "bar",
        "baz", // Not missing an element
    ]

    list2 = [
        "foo"
        "bar"
        "baz" // Absolutely not missing anything
    ]

    foo(bar, baz)
    foo(bar  baz) // Allow this? Could interfere with s-expr syntax

---------------------------------

//                   Wow
//          Such enterprise
//                          So adapter pattern
//               Very elegant

PointTuple = Tuple<Integer, Integer>

struct PointXY
    x: Integer
    y: Integer

surface PointTuple as PointXY
    PointTuple[0] <-> PointXY.x
    PointTuple[1] <-> PointXY.y

struct PointYX
    y: Integer
    x: Integer

surface PointTuple as PointYX
    PointTuple[0] <-> PointXY.y
    PointTuple[1] <-> PointXY.x

test "Points, points, points"
    tup = Tuple(3, 1)
    assert (tup as PointXY).x eq 3
    assert tup.as!PointXY.x eq 3 // Provide this kind of

    point : PointXY = tup
    assert point.x eq tup[0]

---------------------------------

// New template / generic syntax - at least for definitions
// Why am I doing this!?
<T : Summable>
fn sum(x: T, y: T)
    -> x + y

---------------------------------

test "Specify memory allocation model"
    "Would be deallocated once leaving scope. Very similar to stack."
    x #scoped = 0

    "Scanned by GC, business as usual."
    obj #heap = StdClass()

    for ii in 1..999999999
        "Never deallocated. Ever. Don't put it in loops."
        num #persistent = ii

    fn keep(input #heap)
        print input
        for ii in 1..99999999
            "* Decide whether this copies / clones or just references the heap value *"
            scoped ephemeral_val = input
            print ephemeral_val
