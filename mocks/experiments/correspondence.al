
"DAO for users in a db."
struct User
    id: Integer
    name: String
    location: String
    hobbies: {String*}
    "This user's BFF. We only know his name, though."
    bff: String

Users           = {User*}
UsersById       = {User*} by id             // Map<Integer, User>
                                            // or do Map<`value User.id`, User> instead?
                                            // or do ValueCorrespondence<User.id, User> (or similar)
UsersByName     = {User*} key-by name       // Map<String, User>
UsersByLocation = {User*} group-by location // Map<String, {User+}>
UsersByBff      = {User*} group-by bff      // Map<String, {User+}>

// Whether this works depends on whether we do Map<String, {User+}> or Map<`value User.location`, {User+}>
assert not UsersByLocation eq UsersByBff

fn hobbies(users: Users)
    -> users*.hobbies.merge

fn bff-for(users: UsersByName, user: User)
    : User?
    -> users[user.bff]

users = {...}
users_by_names = users.keyBy(`value User.name`)
users_by_names = users `key-by` name
users_by_names = users `by` name
// Keywords, anybody? Or just simply
users_by_names = users key-by name
users_by_names = users by name

random-guy = pick_random(users)
random-guy's-bff = users_by_names.bff-for(random-guy)

// Should work, too
users-by-location = users_by_names by location
// Will not work
hopefully-another-bff = users-by-location.bff-for(random-guy)
