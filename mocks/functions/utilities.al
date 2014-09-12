
module mocks.functions.utilities

/// The identity function. In AnLang, it just returns the same things you passes in.
fn id(thing)
{
    return thing
}

/// Curries in the first arg
fn curry_fa(callable fun)(first_arg)
{
    // Making use of variadic parameters and static array unpacking
    return (args ...) -> fun(first_arg, ... args)
}

/// A variant of the map function to pull deep things from a range into arrays
fn pull(callable value_pred : fn (ElementType!ListType), ListType : InputRange)(list : ListType)
{
    result : returnof(value_pred)[] = []

    foreach value in list
    {
        result ++= value_pred(value)
    }
    return result
}

unittest
{
    struct FooPull
    {
        num : number
    }

    input = [
        FooPull(3),
        FooPull(5),
        FooPull(7),
    ]

    assert input.pull!(x -> x.num) == [3, 5, 7]
}

/// Group things by a predicate
fn group(callable value_pred : fn (ElementType!ListType), ListType : InputRange)(list : ListType)
{
    map = pull!value_pred(list)

    // Arrays of elements, contained in a dictionary keyed by map elements
    groups : ElementType!list[][ElementType!map] = []
    // Pre-allocating groups
    foreach group in map
    {
        groups[group] = []
    }

    foreach key => group in map
    {
        groups[group] ++= list[key]
    }

    return groups
}

unittest
{
    struct FooGroup
    {
        num : number
        str : string
    }

    input = [
        FooGroup(3, "foo"),
        FooGroup(3, "bar"),
        FooGroup(7, "baz"),
    ]

    assert input.group!(x -> x.num) == [
        3: [FooGroup(3, "foo"), FooGroup(3, "bar")]
        7: [FooGroup(7, "baz")]
    ]
}

fn all(callable bool_pred : fn (ElementType!ListType) -> bool = id, ListType : InputRange)(list : ListType) -> bool
{
    foreach value in list
    {
        if !bool_pred(value)
        {
            return false
        }
    }

    return true
}

fn any(callable bool_pred : fn (ElementType!ListType) -> bool = id, ListType : InputRange)(list : ListType) -> bool
{
    foreach value in list
    {
        if bool_pred(value)
        {
            return true
        }
    }

    return false
}

unittest
{
    input = [
        "a a",
        "b b",
    ]

    // Assume the isWhite function exists
    assert !all!isWhite(input)
    assert  any!isWhite(input)
}
