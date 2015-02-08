
fn isAnAChar(x)
    return x eq 'a'

fn main()
{
    char = 'a'

    n1 = match char as
            > 'a' -> 'A'
            > 'b' -> 'B'
            > 'c' | 'd' -> 'C|D'
    assert n1 eq 'A'

    n2 = match char as
            > c when isAnAChar(c) -> ...
            // or?
            > isAnAChar -> ...

    n3 = match char.integer as
            > 0 -> 'null-byte'
            > num in 1..127 -> '7-bit ascii ($num)'
            > c -> '2high4me'
}


