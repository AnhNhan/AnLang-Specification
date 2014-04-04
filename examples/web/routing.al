
# This demonstrates a micro-small web application with routing and stuff

sanitize     ($url) -> $url.ltrim(' /')
splitInParts ($url) -> $url.sanitize().explode('/')

matches ($url, $pattern)
{
    $urlParts     = $url.splitInParts()
    $patternParts = $pattern.splitInParts()

    # Not the same amount of elements, thus could never match
    if $urlParts.count neq $patternParts.count
    {
        return false
    }

    for $index => $patternStringPart in $patternParts
    {
        # We don't need to worry about variables, so skip them
        if $patternStringPart.substr(0, 1) neq ':'
        {
            if $patternStringPart neq $urlParts[$index]
            {
                return false
            }
        }
    }

    return true
}

extract ($url, $pattern)
{
    # No variables? We can save ourselves the work!
    if not $pattern contains ':'
    {
        return []
    }

    $urlParts     = $url.splitInParts()
    $patternParts = $pattern.splitInParts()

    $extractedParameters = []

    for $index => $patternStringPart in $patternParts
    {
        # We only need to worry about variables
        if $patternStringPart.substr(0, 1) eq ':'
        {
            $parameterKey = $patternStringPart.substr(1)
            $extractedParameters[$parameterKey] = $urlParts[$index]
        }
    }

    return $extractedParameters
}

Route
{
    $pattern
    callable $controller

    behaviour __create__ ($pattern, $controller)
    {
        assign $pattern
        assign $controller
    }

    process ($url)
    {
        return this.controller.call ...$url extract this.pattern
    }
}

Router
{
    internal Route[] $routes

    route (Route $route)
    {
        this.routes[$route.pattern] = $route
    }

    process ($url)
    {
        for $pattern => $route in this.$routes
        {
            if $url matches $pattern
            {
                return $route process $url
            }
        }

        return '404 - Not Found :('
    }
}

to ($pattern, $controller)
{
    return Route $pattern, $controller
}

$router = Router

$router route ''            to () -> 'Hello, World!'
$router route 'hello/:name' to ($name) -> format 'Hello, %s!', $name

println $router process ''
println $router process 'hello/Rowan Atkinson'
println $router process 'hello/'

# Output:
#
# Hello, World!
# Hello, Rowan Atkinson!
# 404 - Not Found :(
