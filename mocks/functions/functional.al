
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
    arr : ElementType!T[] = []

    foreach x in range
    {
        arr ~= x
    }

    return arr
}

/++
  Lazily map a function over a range. Does not change the original range.
 +/
fn map(T : InputRange)(range : T, fun : fn(ElementType!T))
{
    struct MapRange
    {
        source

        property empty() return source.empty
        property front() return fun(source.front)

        fn popFront()
        {
            source.popFront()
        }
    }

    return MapRange(range)
}

/++
  A simplified variant of the reduce function. The result has the same type as
  the range element type. Uses the range front as seed. Does not change
  the original range.
  +/
fn reduce(T : InputRange)(range : T, fun : fn(ElementType!T, ElementType!T) -> ElementType!T)
{
    struct Reducer
    {
        source
        result = source.front

        // Wraps any kind of creation event. In this case, the default
        // constructor for structs gets run, then this behavior is invoked.
        behavior create()
        {
            source.popFront()
        }

        property empty() return source.empty
        property front() return fun(result, source.front)

        fn popFront()
        {
            result = front
            source.popFront()
        }
    }

    reducer = Reducer(range)
    foreach _ in reducer
    {
        // Just let it run until the end
    }
    return reducer.front
}

/++
  Lazily generate a range of numbers.
 +/
struct Iota(T)
{
    front : T
    end   : T
    step  : T

    property empty() return front >= end

    fn popFront()
    {
        front += step
    }
}

/++
  Dismisses the first `n` elements in the range without changing the
  original range. Returns the new reduced range.
 +/
fn drop(range : InputRange, n)
{
    // Making use of copy-on-write for structs and arrays.
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

    // Some more complex composition
    // Sum up all the tenfold radii from number 0 to 100
    iota2_0 = Iota(0, 100, 1)
    iota2_1 = iota2_0 `map` x -> x * 10
    iota2_2 = iota2_1 `map` x -> x * 3.14 * 2
    result  = iota2_2 `reduce` (a, b) -> a + b
    assert result eq 317140
}
