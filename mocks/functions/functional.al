
module mocks.functions.functional

import mocks.types.range

/++
  Converts a range eagerly to a dynamic-length array
 +/
// First parameter parentheses are template parameters.
// T : InputRange is a specialized template parameter. Any type T that fits the
// input range interface (.front, .empty, .popFront()). T is inferred from the
// passed types and usually does not need to be specified when called.
@property
fn array(T : InputRange)(range : T)
{
    if isArray!T
    {
        return range
    }

    arr : ElementType!T[] = []

    foreach x in range
    {
        arr ~= x
    }

    return arr
}

fn map(T : InputRange)(range : T, fun : fn(ElementType!T))
{
    struct MapRange
    {
        source

        property empty() return source.empty
        property front() return fun(source)

        fn popFront()
        {
            source.popFront()
        }
    }

    return MapRange(range, fun(range.front))
}

struct Iota(T)
{
    front
    end
    step

    property empty() return front >= end

    fn popFront()
    {
        front += step
    }
}

fn drop(range : InputRange, n)
{
    // Making use of copy-on-write
    ret = range
    foreach _ in 0..n
    {
        ret.popFront()
    }
    return ret
}

unittest
{
    arr = [1, 2, 3]

    doubled = arr `map` x -> x * 2
    assert doubled.array eq [2, 4, 6]

    squared = arr `map` x -> x * x
    assert squared.array eq [1, 4, 9]

    iota = Iota(0, 50, 5)
    r = (iota `map` x -> x / 5) `drop` 5
    assert r.front eq 5
    assert r.array eq [5, 6, 7, 8, 9, 10]
}
