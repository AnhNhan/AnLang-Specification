
type hour_t encapsule number
    range 0..23

type minute_t encapsule number
    range 0..59

type second_t encapsule number
    range 0..59

struct time_t
    h : hour_t

    m : minute_t
        behaviour overflow_each
            this.reset()
            h += 1

    s : second_t
        behaviour overflow_each
            this.reset()
            m += 1

    operator '+' (rhs : time_t)
        // Making good use of copy-on-write
        ret = this
        ret += rhs
        return ret

    operator '+=' (rhs : time_t)
        s += rhs.s
        m += rhs.m
        h += rhs.h

type ISBN encapsule string
    // A simple regex
    where this matches /^((-?)\d(-?)){10,13}$/

struct Book
    title  : string
    author : string
    isbn   : ISBN

fn main()
    time1 = time_t 17, 59, 59
    time2 = time_t  0, 30, 25
    time2 += time_t 0,  5,  0

    time3 = time1 + time2
    assert time3 eq time_t 18, 35, 24

    // Error: Values do not fit in range
    time4 = time_t 56, 99, 61

    // Valid
    book1 = Book "1Q84", "Haruki Murakami", "978-0-345-80340-5"
    // Error: "1234567" does not match type ISBN
    book2 = Book "Foo" , "Bar Baz"        , "1234567"
