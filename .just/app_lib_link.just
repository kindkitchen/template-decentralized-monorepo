ROOT := `cd .. && pwd`

_:

[script('bash')]
app_lib_link app lib alias="":
    cd {{ ROOT }}
    alias={{ if alias == "" { lib } else { alias } }}
    ln -sr {{ lib }}/core {{ app }}/$alias
