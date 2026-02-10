##########################################################################################
# Git commit shortcut that will utilize pwd for message.
##########################################################################################


_:

[no-cd]
[script('bash')]
commit *message="...":
    set -e # exit on first error

    # 1. ensure first word ends with colon
    first_word=$(echo "{{ message }}" | awk '{print $1}')

    if [[ $first_word != *: ]]; then
        message="feat: {{ message }}"
    else
        message="{{ message }}"
    fi
    # 2. get relative path from constant ROOT
    ROOT="{{ ROOT }}"
    REL_PATH="${PWD#$ROOT}"  # segment not matched with ROOT

    # !!! if this is root - submodules should be committed and pushed first
    if [[ "$PWD" == "$ROOT" ]]; then
        # commit dirty submodules first
        git submodule foreach --quiet '
            if ! git diff --quiet || ! git diff --cached --quiet; then
                echo "Committing submodule $name"
                git add -A
                git commit -m "'"${message}"' [submodule:$name]"
                git push
            fi
        '
    fi

    git add -A
    git commit -m "${message} [${REL_PATH}/]"
