set unstable := true

export JSON_FILES_WITH_VERSION := 'deno.json domain/deno.json app/api/deno.json lib/config/deno.json'

alias format := fmt
alias v := version
alias i := install

@_default:
    just --fmt
    just --list

@fmt:
    just --fmt
    deno fmt

[script('bash')]
version:
    head -n 1 ./VERSION.md | awk '{               
        sub(/#*\s*v?/, "");
        sub(/\s+.*/, "");
        print
      }'

bump: _pre_bump _bump fmt

@_pre_bump:
    echo
    echo  This version will be used: {{ BOLD + BLUE }}$(just v){{ NORMAL }}
    echo "{{ ITALIC }}(to change - modify first line in ./VERSION.md){{ NORMAL }}"
    echo

[confirm('Ok? (y/N)')]
[script('bash')]
_bump:
    VERSION=$(just v)
    if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$ ]]; then
      echo "The first line of ./VERSION.md should be valid semver version format (markdown heading allowed): $VERSION"
      exit 1
    fi
    for FILE in {{ JSON_FILES_WITH_VERSION }}; do
      jq ".version" "$FILE" && \
      jq ".version=\"$VERSION\"" "$FILE" > tmp.$$.json && mv tmp.$$.json "$FILE"
    done
    echo {{ BOLD + BLUE }}v$VERSION

install:
    deno install --allow-scripts

build: parallel
    just install

_a:
    echo A

_b:
    echo B

[script('bash')]
parallel:
    trap 'kill 0' SIGINT;
    just _a &
    just _b & 
    wait

[script('bash')]
_log message='' prefix='' suffix='':
    echo -e "{{ prefix }}\n\n{{ message }}\n{{ suffix }}"

_err message="ERROR":
    just _log {{ message }} {{ BG_RED + INVERT }} {{ NORMAL }}

_info message="INFO":
    just _log {{ message }} {{ BG_GREEN + BOLD + INVERT }} {{ NORMAL }}

_debug message="DEBUG":
    just _log {{ message }} {{ ITALIC + INVERT }} {{ NORMAL }}
