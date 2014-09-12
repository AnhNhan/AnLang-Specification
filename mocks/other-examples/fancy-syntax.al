
// translated from a == x ? a : b

fn when(t, fun_ret: Either!(t, any))(value: t, maybe: fn(t) -> fun_ret) -> fun_ret
{
    return maybe(value)
}

fn else(t, u)(pred: fn(t) -> bool, alternative: u) -> fn(t) -> Either!(t, u)
{
    return value -> if pred { return value } else { return alternative }
}

unittest
{
    f= a `when` ´eq x´ `else` b
    // a `when` x `else` b
    // a `when` (asdf -> asdf eq x) `else` b
    // a `when` a eq x `else` b
}

unittest
{
    // Function piping
    // Think it clashes with boolean / bitwise OR?
    // That's easy, we don't even have that!
    lines = 'foo.txt'
        | std.file.read
        | split('\n')
        | map!trim

    import std.algorithm : map
    import std.file : read
    import std.range : split
    import std.string : trim

    lines = 'foo.txt'.read.split('\n').map!trim

    // Conclusion: I don't think this has a point here except for namespaced symbols
}

unittest
{
    // Holy Grail type-safe sprintf?

    alias greet = format!'Hello, %s!'
    print greet('Rowan Atkinson')

    alias happybirthday = format!'Happy Birthday to your %2$dth birthday, %1$s!'
    print happybirthday('Rowan Atkinson', 59) // It's 2014 fyi
}
