ROOT := `cd ../.. && pwd`

_:

[script('bash')]
app_lib_unlink app lib:
    cd {{ ROOT }}
    rm app/{{ app }}/lib/{{ lib }}
