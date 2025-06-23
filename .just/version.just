ROOT := `cd ../.. && pwd`

_:

[script('bash')]
version:
    head -n 1 ./VERSION.md | awk '{               
        sub(/#*\s*v?/, "");
        sub(/\s+.*/, "");
        print
      }'
