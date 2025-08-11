ROOT := `cd ../.. && pwd`

_:

# just app deno init --npm create vue
[script('bash')]
app target="" *args="":
    cd {{ ROOT }}
    cd app
    target={{ target }}
    args={{ args }}
    {{ if target == "" { "just printInfo 'You can run any command in context of one of these roots'; tree -dl -L 1 || ls -1" } else { 'cd $target && $args' } }}
