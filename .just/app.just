ROOT := `cd ../.. && pwd`

_:

# just app deno init --npm create vue
[script('bash')]
app *args="":
    cd {{ ROOT }}
    cd app
    {{ if args == "" { "ls | xargs just printInfo" } else { args } }}
