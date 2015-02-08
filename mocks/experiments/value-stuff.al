
example-set = 1 | 2 | 3
assert 1 in example-set
assert example-set eq StdSet([1, 2, 3])

another-set = example-set ~ 2
assert not 2 in another-set

regex = r'(a)+b'is // regex string with i and s modifiers
regex =  /(a)+b/is

// Like Perl
matches = 'aaab' ~~ regex

      // something()             bool(something)
piping = produce-right-answer >> really-the-right-answer?
      // produce-right-answer.really-the-right-answer?

// Question: Should we allow type-casts at all? Wouldn't it better to implement it as typeof conditional check + type narrowing?
casting = value of Type
casting = value to Type
casting = value as Type

type Float
{
    // Keyword choice #1
    where type matches FloatNumber | NotANumber | Infinity
    // Keyword choice #2
    where type of      FloatNumber | NotANumber | Infinity
    // Keyword choice #3
    type of            FloatNumber | NotANumber | Infinity
    // Keyword choice #4
    of                 FloatNumber | NotANumber | Infinity
}

// Faster way to construct types? Especially if you just want to do
// type unions / algebraic data types
type Float = FloatNumber  | NotANumber   | Infinity
type Float = Float-Number | Not-A-Number | Infinity
// Do we even need the `type` keyword? It's pretty obvious if type names can
// only start with capital case
Float = FloatNumber | NaN | Infinity

// Little bit awkward
type Switch = On | Off
type On = of on
type Off = of off
object on implements On {}
object off implements Off {}
enum switch = of on | off
enum switch = on | off
switch = on | off // Confusing with sets? Special case of sets?

lights = on
lights = lights.other // We may not always know how to invert values, but we
                      // certainly know the other value for binary values

// Variable return type, exact type depends on parameter type
// This is more-or-less do-able in other languages by using overloading, where each overloading function yields a different type
fn conditional-types<str_t : AsciiString|UTF8String>(str : str_t)
    : if str_t eq AsciiString then byte[] else byte[][]
    ...

fn append<ElementType, size : Integer>(list : List<ElementType, size>, element : ElementType)
    : List<ElementType, size+1>
    ...

// I think these two should be inferrable without issue. We should only ask this
// ourselves after we have decided whether top-level/public declarations should
// allow type-inferencing, though, since it would make type-checking more intensive,
// requiring multiple passes
fn first<ElementType, value size : Integer>(list : List<ElementType, size>)
    : if size > 0 then ElementType else null
    ...

fn pick_random<ElementType, size : Integer>(list : List<ElementType, size>)
    : if size > 0 then ElementType else null
    -> list[rand(0, list.size)]

// Type<?>: Semantically distinguished to Type<Any>
// T where T in types: Statically asserts that only types within a given set exists are passed in
struct TaggedUnion<types : Set<Type<?>>>(value : T where T in types)
    ...
