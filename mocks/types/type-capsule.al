
type hour_t encapsule number
    range 0..23

type minute_t encapsule number
    range 0..59

type second_t encapsule number
    range 0..59

type time_t
    hour_t   h

    minute_t m
    {
        behaviour __overflow__
            h += 1
    }

    second_t s
    {
        behaviour __overflow__
            m += 1
    }

    this (@h, @m, @s)

    operator '+' (time_t rhs)
        h += rhs.h
        m += rhs.m
        s += rhs.s

main()
    time1 = time_t 17, 59, 59
    time2 = time_t  0, 30, 25

    time3 = time1 + time2
    assert time3 eq time_t 18, 30, 24
