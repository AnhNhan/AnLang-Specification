
type SafeHtml
    where this.isSafeHtml eq true
    supports stringof

type HtmlTagContents
    where this.type matches
        string
      | SafeHtml
      | null

struct HtmlTag
    internal
        string tag_name
        string[string] options
        HtmlTagContents[] contents

    // The most important requirement to satisfy SafeHtml
    property isSafeHtml return true

    this(@tag_name, contents = null)
        setContents(contents)

    property empty return contents.length eq 0

    property isSelfClosing return empty

    operator indexAccess(name)
        return options[name]
    operator indexAccessAssign(name, value)
        return options[name] = value

    removeContents()
        contents = []

    setContents(_contents)
        removeContents()
        append(_contents)

    append(_contents)
        if _contents eq null
            return

        if not _contents is SafeHtml
            _contents = _html_escape(_contents)

        contents ~= _contents

    behaviour stringof
        rendered_options = ''
        foreach name, value in options
            rendered_options ~= ' ' ~ _html_escape(name)
            if not value.empty
                rendered_options ~= '="' ~ _html_escape(value) ~ '"'

        if isSelfClosing
            result = '<%s%s />' format tag_name, rendered_options
        else
            contents = this.contents.join()
            result = '<%s%s>%s<%1$s />' format tag_name, rendered_options, contents
        return result

    // A few utility methods for HTML usage
    property id return this["id"]
    property id(val) this["id"] = val

    property classes return this["class"]
    add_class(class)
        if class eq null or class.empty
            return
        this["class"] = classes ~ ' ' ~ class

// Hoping that this is safe enough
_html_escape(input)
    return input replace ['<', '>', '"'], ['&lt;', '&gt;', '&quot;']

tag(name, contents = null, class = null)
    _tag = HtmlTag name, contents
    _tag add_class class
    return _tag

div(class = '', contents = null, id = null)
    _tag = tag('div', contents, class)
    _tag.id = id
    return _tag

h1(contents, class = '') return tag('h1', contents, class)
h2(contents, class = '') return tag('h2', contents, class)
h3(contents, class = '') return tag('h3', contents, class)

p(contents, class = '') return tag('p', contents, class)

btn(text, href = null, color = 'default')
    _btn = Tag 'a', text
    // Remember, setting a non-nullable value in an hashmap to null makes sure it does not exist
    _btn["href"] = href
    _btn add_class 'btn'
    _btn add_class 'btn-color-' ~ color
    return _btn

struct ContentPanel
    internal contents = div('panel-body')
    string header
    string color

    property isSafeHtml return true

    property contents(_contents)
        contents setContents _contents
    append(_contents)
        contents setContents _contents

    renderToTag()
        panel = div('panel')

        if color
            panel add_class 'panel-color-' ~ color

        if header
            panel append div('panel-header', header)

        panel append contents
        return panel

    behaviour stringof
        return renderToTag().stringof

errorPanel = ContentPanel
errorPanel.color = 'danger'
errorPanel.header = 'Something\'s wrong!'
errorPanel.contents = 'Oh snap! You got an error. Something probably went terribly wrong. You better do this:'
errorPanel append 'Take this action'.btn(color='danger')
errorPanel append 'Or do this'.btn

print errorPanel
// Output:
// <div class="panel panel-color-danger"><div class="panel-header">Something's wrong!</div><div class="panel-body">Oh snap! You got an error. Something probably went terribly wrong. You better do this: <a class="btn btn-color-danger">Take this action!</a><a class="btn btn-color-default">Or do this</a></div></div>
