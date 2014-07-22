
module mocks.types.algebraic_ish_types

// Templated type
type Either(A, B)
{
    where type matches
        A
      | B
}

type Nothing
{
    // <empty>
}

type Just(T)
{
    encapsule T
}

type Maybe(T)
{
    encapsule Either!(T, Nothing)
    where type matches
        Just!T
      | Nothing
}

fn do_something(val : number) -> Maybe!number
{
    if val eq 0
    {
        return Nothing
    }
    else
    {
        return val * 2
    }
}

unittest
{
    num1 = 5
    num2 = 0

    conv1 = convert_to_maybe(num1)
    conv2 = convert_to_maybe(num2)

    assert conv1 eq 10
    assert conv2 is Nothing
}

// No promises this one will work

type Celsius encapsule number

type Fahrenheit encapsule number

unittest
{
    temp1 = Celsius(38.5) // Somebody got a fever!

    in_kelvin = match_type temp1
                {
                    (x : Celsius)    => x + 273.15
                    (x : Fahrenheit) => ((x - 32) / 1.8) + 273.15
                }

    assert in_kelvin eq 311.65
}
