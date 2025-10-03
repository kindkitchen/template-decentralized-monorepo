##########################################################################################
# Simply remove link of the lib from some member.
##########################################################################################


_:

[script('bash')]
app_lib_unlink app lib alias="":
    cd {{ ROOT }}
    alias={{ if alias == "" { lib } else { alias } }}
    rm {{ app }}/src/$alias
