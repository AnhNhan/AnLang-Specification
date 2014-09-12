
// Very simplified

enum ColumnType
{
    string,
    integer,
    float,
    text,
}

struct Column
{
    name : string
    type : ColumnType
}

enum RelationType
{
    OneToOne,
    OneToMany,
    ManyToMany,
}

struct Relationship
{
    name : string
    type : RelationType
    target : Entity
}

type EntityFieldType
{
    where type matches
      Column
    | Relationship
}

struct Entity(_name, _fields)
{
    name : string = _name
    fields : EntityFieldType[name] = _fields

    // TODO: Generate members
    // TODO: Associations / Relationships
}
