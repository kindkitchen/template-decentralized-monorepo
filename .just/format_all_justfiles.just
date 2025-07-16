ROOT := `cd ../.. && pwd`

_:

[script('bash')]
format_all_justfiles:
    cd {{ ROOT }}
    just _format_all_justfiles .just
    ls app |
      while read dir;
      do
        if [[ -d $dir ]]; then
          eval "just _format_all_justfiles app/$dir";
        fi
      done
    ls package |
      while read dir;
      do
        if [[ -d $dir ]]; then
          eval "just _format_all_justfiles package/$dir";
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
          $0,
          "--unstable",
          "--fmt"
        }' |
      while read cmd;
      do eval "$cmd";
      done
