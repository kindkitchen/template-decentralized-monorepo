ROOT := `cd ../.. && pwd`

_:

[script('bash')]
app_lib_unlink app lib:
    rm app/{{ app }}/lib/{{ lib }}
