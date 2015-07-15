
// translated from a == x ? a : b
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
    // That's easy, we don't even have bitwise operators!
    lines = 'foo.txt'
        | std.file.read
        | split('\n')
        | map!trim
    // Using #=> instead would make for some good jokes!

    // Old-school

    import std.algorithm : map
    import std.file : read
    import std.range : split
    import std.string : trim

    lines = 'foo.txt'.read.split('\n').map!trim

    // Conclusion: I don't think this has a point here except for namespaced symbols. And jokes.
}

unittest
{
    // Holy Grail type-safe sprintf?

    print format!'Hello, %s!'('Rowan Atkinson')

    alias greet = format!'Hello, %s!'
    print greet('Rowan Atkinson')

    alias happybirthday = format!'Happy Birthday to your %2$dth birthday, %1$s!'
    print happybirthday('Rowan Atkinson', 59) // It's 2014 fyi

    alias writtenby = format!'"%s" (by %s)'
    print 'Dracula'.writtenby('Bram Stoker')
}

template format(format-template: String)
{
    args = format-template
        .matchall(/(<!=%)%(.*?([a-z]))/)
        .map(match -> match => match[2].translate([
                's' => Stringable,
                'd' => Integer|Float,
            ]))
        .zipEntries // {Key=>Obj*} -> Map<Key, Obj>
}
