
type View
{
    has operator [size_t, size_t]
    has property w -> size_t
    has property h -> size_t
}

alias ViewColor(T) = typeof(T.init[0, 0])

fn procedural(formula : fn(size_t, size_t))(w, h)
{
    struct Procedural
    {
        w : size_t
        h : size_t

        operator index(x, y)
        {
            return formula(x, y)
        }
    }
    return Procedural(w, h)
}

fn solid(c, w, h)
{
    return procedural!((x, y) => c)(w, h)
}
