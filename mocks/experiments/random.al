
struct Triple
    x
    y
    z

struct Triple:
    x
    y
    z

struct Triple
{
    x
    y
    z
}

struct Triple
    value x
    value y
    value z

struct Triple
    value x, y, z

struct Triple(T)
    x : T
    y : T
    z : T

struct Triple<T>
    x: T
    y: T
    z: T

struct Triple<T>
{
    x: T;
    y: T;
    z: T;
}

someRandomName
some_random_name
some-random-name

aDayInParadise
a_day_in_paradise
a-day-in-paradise

deriveThis
deriveThis'
derive_this
derive_this'
derive-this
derive-this'

_name
-name
name_
name-

// Putting quotes in the middle of the word is awkward
name'name'dude

val foo = obj"member"fun(a, b)
val fun = obj"member"fun
val fun = obj'member'fun
val fun = obj:member:fun
val fun = obj~member~fun
val fun = obj/member/fun
val fun = obj\member\fun

#dynamic
fn dynamo() {}

@dynamic
fn dynamo() {}

dynamic
fn dynamo() {}

// We need semicolons for this, else it is ambiguous with struct value declarations
random deprecated text('foo')
fn stuff()
{
    a;
    b;
    c;
}

// Horrible choice of tokens
@random @deprecated @text('foo')
fn stuff()
{
    a
    b
    c
}

#random #deprecated #text('foo')
fn stuff()
{
    a
    b
    c
}

// Inspired by .Net (C#, F#)
[Random Deprecated Text('foo')]
fn stuff()
    ...
