ROOT := `cd ../.. && pwd`

_:

[script('bash')]
format_all_justfiles:
    cd {{ ROOT }}
    just _format_all_justfiles .just
    ls app |
      while read dir;
      do eval "just _format_all_justfiles app/$dir";
      done
    ls package |
      while read dir;
      do eval "just _format_all_justfiles package/$dir";
      done
    just _format_all_justfiles .

[script('bash')]
_format_all_justfiles dir:
    just printInfo "formatting all justfiles in {{ dir }} directory"
    cd {{ ROOT }}
    cd {{ dir }}
    pwd
    ls |
      grep -Ei '\.just$|justfile$' |
      awk '{
        print "just -f",
          $0,
          "--unstable",
          "--fmt"
        }' |
      while read cmd;
      do eval "$cmd";
      done
