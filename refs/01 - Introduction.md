Introduction
============

**AnLang** is a functional and dynamic object-oriented language. It actually
began as a PHP rip-off (that means it could have been implemented as an
extension), but quickly evolved into its current state you can see today
(being a total Python/Ruby rip-off, languages I have no idea how to write
extensions).

It provides a convenience environment (not convenient, though it applies). It
removes many redundant/unneeded elements from overblown/overfucked languages
like the plentiful braces from C/C++/Java/PHP, the main method from C/C++/Java
and copy/paste getters/setters, as well as eliminates the thought of having to
exterminate bad coding styles as AnLang enforces a basic common coding style
everybody should share an agreeing thought with.

Basic Syntax
============

Try out the basics!

```
print "Hello World!"
```

It's easy as that. Ok, it looks like Python, I know. Try this!

```
println "Hello World!"
echoln "Hello World!"
```

I'm overdoing it, I know. Let's try something more intriguing!

```
define function printtwice($text):
    println $text . $text
    println "Printed it twice as requested"

printtwice("Hello World!")

// Short loop syntax
repeat twice: print "Exaggerating everything"
```

And we got more!

```
$someStr = "A totally random string"

/*
 * RandomSource reads from either /dev/urandom (UNIX), CAPICOM (Windows) or
 * OpenSSL (both) in this order.
 *
 * This is a static method invocation, btw
 */
$someReallyRandomString = RandomSource::readChars(64)

if $someStr eq $someReallyRandomString then
    print "You are damn lucky today..."
    for infinite times
        print "."
else
    print "Not so lucky, try again!"
```

I hear you want some OO?

```
Token:
    // Properties/Attributes/Object variables/however you call them are private
    // by default
    // The `@get` instructs the interpreter to generate a getter `getName`
    // You can do `@set` and some more, too
    prop $name: @get
    prop $string: @get

    // The :-prefix instructs the generated constructor to automatically assign
    // `$name` to `this.name`. Useful, hm?
    behaviour __create__ (:$name, :$string)

Tokenizer:
    prop list $tokenList: @get

    behaviour __create__ (list :$tokenList)

    matchNextToken($text):
        iterate this.getTokenList as $tokenName => $tokenString
            if $tokenString->ncmp($text) sameas 0 then
                $matchedString = $tokenString[0..$]
                return Token($tokenName, $matchedString)

        // No matched token
        return false

    tokenize($text):
        list $tokens
        for $text.length times
            $token = this.matchNextToken($text)
            if not $token then
                // Some wild data, we don't care about it for now
                break
            $tokens[] = $token
            $text = $text[0..$token.getString.length]
        return $tokens
```

Now, let's use this `Tokenizer` object we just created.

```
// Initialize a dictionary
list $tokenList = [
    "t_TEXT_HI" => "hi",
    "t_COMMA" => ",",
    "t_SPACE" => " ",
    "t_TEXT_THERE" => "there",
    "t_EXCL" => "!",
]

$tokenizer = Tokenlist($tokenList)

// One way to assign a value to a variable
$stringToBeTokenized = "hi, there!"

// Another way to assign a value to a variable
$tokens = $tokenizer.tokenize($stringToBeTokenized)

iterate $tokens as Token $token
    println "Token {$token->getName}: {$token->getString}"
```

Regarding the last print statement: PHP guys may remember (and probably love)
that variable embed syntax well, while non-PHP guys may hate it. Yes, it works
in **AnLang**, though the curly braces are mandatory.
