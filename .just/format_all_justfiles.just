ROOT := `cd .. && pwd`

_:

[script('bash')]
format_all_justfiles:
    cd {{ ROOT }}
    ls |
      while read dir;
      do
        if [[ -d $dir ]]; then
          eval "just _format_all_justfiles $dir";
        fi
      done
    just _format_all_justfiles .

[script('bash')]
_format_all_justfiles dir:
    cd {{ ROOT }}
    cd {{ dir }}
    ls |
      grep -Ei '\.just$|justfile$' |
      awk '{
        print "just -f",
          $1,
          "--unstable",
          "--fmt"
        }' |
      while read cmd;
      do eval "$cmd";
      done
