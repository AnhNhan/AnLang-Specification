
// Cluster-F
struct DBConnection
{
    host = 'localhost'
    username
    password : Maybe!string // There may be no password, or the password may be an empty string. Hence the Maybe
    prv is_connected = false

    constraint // lots to write ^-^
    {
        initialized username
        initialized password
    }
    // or
    @requires_initialized(username)
    @requires_initialized(password)
    fn connect()
    {
        // call ODBC or establish another connection of your choice
        // ...

        is_connected = true
    }

    constraint
    {
        requires is_connected eq true
    }
    // or
    @requires(() -> is_connected eq true) // should this be a closure expr, or can we just parse this with custom rules?
    fn query(string query)
    {
        // send query to db
        // ...
    }
}

// wrapper around the struct (without any constraints) - a lot tidier
type SafeDBConnection
{
    encapsule DBConnection

    constraint fn connect
    {
        initialized username
        initialized password
    }

    constraint fn query
    {
        requires is_connected eq true
    }
}
