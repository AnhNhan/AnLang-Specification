
type hour_t encapsule number
    range 0..23

type minute_t encapsule number
    range 0..59

type second_t encapsule number
    range 0..59

struct time_t
    hour_t   h

    minute_t m
        behaviour overflow_each
            this.reset()
            h += 1

    second_t s
        behaviour overflow_each
            this.reset()
            m += 1

    operator '+' (time_t rhs)
        // Making good use of copy-on-write
        ret = this
        ret += rhs
        return ret

    operator '+=' (time_t rhs)
        s += rhs.s
        m += rhs.m
        h += rhs.h

fn main()
    time1 = time_t 17, 59, 59
    time2 = time_t  0, 30, 25
    time2 += time_t 0,  5,  0

    time3 = time1 + time2
    assert time3 eq time_t 18, 35, 24
