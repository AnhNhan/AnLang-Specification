
module range

/++
  The range primitive. A type primitive allowing the traversal of
  nearly any data-type.

  Any type that fulfills these constraints is considered a range.
 +/
type InputRange
{
    has fn popFront()
    has property front
    has property empty -> bool
    test
    {
        // Can initialize
        range = typeof(this).init
    }
}

type OutputRange(E)
{
    has fn put(E)
}

type ForwardRange
{
    also InputRange
    has property save -> typeof(this)
}

type BidirectionalRange
{
    also InputRange
    has fn popBack()
    has property back
    test
    {
        range = typeof(this).init
        f = range.front
        b = range.back
        assert typeof(f) eq typeof(b)
    }
}

/++
  Evaluates to the element type of a range.
  +/
alias ElementType(T) = typeof(T.init.front.init)

// Allowing to access arrays with the input range interface

@property
fn front(T)(array : T[])
{
    return array[0]
}

@property
fn empty(T)(array : T[])
{
    return array.lenth eq 0
}

fn popFront(T)(ref array : T[])
{
    array = array[1..array.length]
}
