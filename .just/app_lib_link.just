ROOT := `cd ../.. && pwd`

_:

[script('bash')]
app_lib_link app lib:
    [ -e app/{{ app }}/lib ] || mkdir app/{{ app }}/lib
    ln -sr package/{{ lib }}/ app/{{ app }}/lib/{{ lib }}
