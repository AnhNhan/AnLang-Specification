
// This mock demonstrates a router as found common in web applications
// It supports variables, e.g. /page/:name

split_in_parts(url)
    url.trim(' /').split('/')

matches(url, pattern)
    url_parts     = url.split_in_parts
    pattern_parts = pattern.split_in_parts

    if not url_parts.count eq pattern_parts
        return false

    foreach index, pattern_part in pattern_parts
        // We don't need to worry about variables, so skip them
        if not pattern_part[0] eq ':'
            if not pattern_part eq url_parts[index]
                // Non-variable does not match
                return false

    return true

extract(url, pattern)
    // No variables? We can save ourselves the work!
    if not ':' in pattern
        return []

    url_parts     = url.split_in_parts
    pattern_parts = pattern.split_in_parts

    extracted_parameters = []

    foreach index, pattern_part in pattern_parts
        // We only need to worry about variables here
        if pattern_part[0] eq ':'
            param_key = pattern_part[1..$]
            extracted_parameters[param_key] = url_parts[index]

    return extracted_parameters

struct Route
    string   pattern
    callable controller

    this(@pattern, @controller)

    process(url)
        // callable.call_v takes an array of values and uses these as
        // arguments for the invoked function
        return controller.call_v (url extract pattern)

struct Router
    Route[] routes

    route(Route route)
        routes[] = route

    process(url)
        foreach route in routes
            if url matches route.pattern
                return route process url

        return '404 - Url Not Found :('

to(pattern, controller)
    return Route pattern, controller

main()
    router = Router

    router route ''            to ()     -> 'Hello, World!'
    router route 'hello/:name' to (name) -> 'Hello, %s!' format name

    println router process ''
    println router process 'hello/Rowan Atkinson'
    println router process 'hello/'

    // Output:
    //
    // Hello, World!
    // Hello, Rowan Atkinson!
    // 404 - Url Not Found :(
