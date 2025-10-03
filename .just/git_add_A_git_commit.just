##########################################################################################
# Git commit shortcut that will utilize pwd for message.
##########################################################################################


_:

[no-cd]
[script('bash')]
commit *message="...":
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
    git add -A
    git commit -m "${message} [${REL_PATH}/]"
