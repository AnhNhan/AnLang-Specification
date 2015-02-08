
type Switch = On | Off
type On = of singleton on
type Off = of singleton off

lights = on // of type Switch

---------------------------------

type View<Pixel, dimensions: Integer.StrictlyPositive>
    sizes: Integer.ZeroOrPositive[dimensions]
    operator indexGet(*Integer.ZeroOrPositive[dimensions]): Pixel

// Using : because I don't want to argue whether to use extends, implements or satisfies
// or choose a sigil
"Specialization for images so you won't go insane typing so many index accesses."
type View2D<Pixel> : View<Pixel, 2>
    width -> sizes[0]
    height -> sizes[1]
    #actual #formal
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
    // Don't test *all* dimensions, leave some so we can still have 3D games
    for _ in 4..Integer.maximum
        // Let's just assume it was D's templating parameter syntax
        // Lol, this looks like an even funnier emoticon
        assert solid!(_->0)(3,3)[0,0] eq 0

---------------------------------

"* Coolest comments ever *"
(: This is cooler than yours! :)

---------------------------------

fn literal<InputElement>(literal: InputElement)(input: List<InputElement>)
    if input.first eq literal
        return ok(literal, input.rest)
    else
        return error(input, "Expected #[literal], got #[input.first]")

test "Introspectable function invocations"
    val a = literal('a')
    // AppliedFunction<fun: Function, TypeArguments: N-Tuple<Type<?>>, invokedValues: TypeArguments, invokationArguments: N-Tuple<Type<?>>>
    assert type(literal('a')) is AppliedFunction<literal, [Character], ['a'], [List<InputElement>]>
    print refl(a).appliedParameters
