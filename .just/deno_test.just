##########################################################################################
# Simple shortcut to run <deno test> in pwd context.
##########################################################################################

_:

[doc("just test test /// will execute all tests")]
[no-cd]
[script("bash")]
test pattern="":
    export PATTERN="{{ pattern }}"
    export TEST_TIME_LABEL=$(date +"%b%-d.%H.%M.%S")
    if [ -n "$PATTERN" ]; then
        find . -type f -not -path "./node_modules/*" \( -path "*$PATTERN*" -path "*.test.ts" \) |
        xargs deno test -A --env-file=default.env --env-file=.env
    else
        find . -type f -not -path "./node_modules/*" \( -name "*test.ts" \)
    fi
