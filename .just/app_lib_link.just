##########################################################################################
# This is the core mechanism of project's members integration.
# The member itself is almost any top-level folder (starting from the root of this repo).
# The integration is sharing lib-like code by one member with another, at the same time
# allowing to have own, not-sharable code, aka app-level.
##########################################################################################
# Current configuration assume that your code is stored in <src> folder.
# The code, that can be shared - in <src/lib>.
# So when you execute this command - it is literally link this sharable <lib> folder
# of one of the member to another one, but with special alias.
# And so all relative imports still valid.
# And if one lib A depends on another - B, but you only need this A in some C project -
# the only thing that you should do - is link B to C also.
##########################################################################################


_:

[script('bash')]
app_lib_link app lib alias="":
    cd {{ ROOT }}
    alias={{ if alias == "" { lib } else { alias } }}
    ln -sr {{ lib }}/src/lib {{ app }}/src/$alias
