ROOT := `cd ../.. && pwd`

_:

[script('bash')]
app_lib_unlink lib app:
    rm app/{{ app }}/lib/{{ lib }}
