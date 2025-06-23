ROOT := `cd ../.. && pwd`

_:

[script('bash')]
app_lib_link lib app:
    [ -e app/{{ app }}/lib ] || mkdir app/{{ app }}/lib
    ln -sr package/{{ lib }}/ app/{{ app }}/lib/{{ lib }}
