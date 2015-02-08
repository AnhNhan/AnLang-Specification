
// Array type notation
unittest
{
    // Basic array of ints
    int[]
    int{}
    int<>
    [int]
    {int}
    <int>
    Array!int // Template containers?
    // Regex-like notations of quantity
    {int*} {int+}
    [int]* [int]+
    <int>* <int+>

    // Dictionary of string -> int
    int[string]
    int{string}
    int<string> // confusing for people used to generics
    [string : int]
    [string => int]
    Dictionary!(string, int)
    // Dictionary of string -> int-array
    int[][string]
    [string : [int]]
    {string : {int}}
    [string => [int]]
    {string => {int}}
    // Dictionary of string -> int-array with quantity
    [string : [int]+]
    {string : {int}+}
    [string => [int]+]
    {string => {int}+}

    // Nested arrays and dictionaries
    int[][][string][int[]]
    [[int]: [string: [[int]]]]
    {{int}: {string: {{int}}}}
    [[int] => [string => [[int]]]]
    {{int} => {string => {{int}}}}
    Dictionary!(Array!int, Dictionary!(string, Array!(Array!int))) // Cluster-F Bomb

    // Awkward / ambiguous styles
    int+
    int*
    string : int
    string : int+
    string => int
    string => int+
}

// Array use
unittest
{
    arr = [1, 2, 3, 4, 5]
    arr = {1, 2, 3, 4, 5}
    arr = array(1, 2, 3, 4, 5) // hua hua hua
    assert arr is [int]+
    assert arr is [int+]

    dict = ['foo' : 1]
    dict = {'foo' : 1}
    dict = ['foo' => 1]
    dict = {'foo' => 1}

    /////////////////////
    // Range-interface //
    /////////////////////
    arr.front
    arr.empty
    arr.popFront()

    //////////////////
    // Array Access //
    //////////////////

    arr[0]
    arr{0}
    arr<0>

    // people may be not used to using the same syntax as function calls,
    // even though the compiler should be able to disambiguate this
    arr(0)

    // ditto with property syntax
    arr.0
    arr.i
    arr.i() // ambiguous for arrays of functions
}

test "tuple notation"
    val = [a, b, c]
    val = (a, b, c) // ambiguous with (expression)
    val = {a, b, c}
    val = (%a, b, c%) // ...
    val = <a, b, c> // considering that we removed, like, all sigil operators
                    // from the language, this looks sexy
