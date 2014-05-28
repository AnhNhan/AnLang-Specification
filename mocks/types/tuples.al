
// Simple tuple declaration
tuple Point(number, number)

// Named tuple declaration
tuple Vector
    number x
    number y
    number z

fn add(Vector self, Vector rhs)
    return Vector self.x + rhs.x, self.y + rhs.y, self.z + rhs.z

fn add(Vector self, number x, number y, number z)
    return Vector self.x + x, self.y + y, self.z + z

fn main()
    vec1 = Vector 1, 2, 3
    vec2 = (3, 2, 1)

    vec3 = vec1 add vec2
    assert vec3 eq Vector 4, 4, 4

    vec4 = vec2 add 4, 5, 6
    assert vec4 eq (5, 7, 9)
