ROOT := `cd .. && pwd`

_:

[script('bash')]
app_lib_link app lib alias="":
    cd {{ ROOT }}
    [ -e {{ app }}/lib ] || mkdir {{ app }}/lib
    alias={{ if alias == "" { lib } else { alias } }}
    ln -sr {{ lib }}/core {{ app }}/lib/$alias
