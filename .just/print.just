##########################################################################################
# Log utils for your custom just tasks.
##########################################################################################


_:

@print message="":
    echo "{{ ITALIC + INVERT }} {{ message }} "

@printInfo message="INFO":
    echo "{{ NORMAL }}{{ BG_GREEN }}____________{{ NORMAL }}"
    echo "{{ BOLD + INVERT }} {{ message }} "
    echo "{{ NORMAL }}{{ BG_GREEN }}____________{{ NORMAL }}"

@printWarning message="WARNING":
    echo "{{ NORMAL }}{{ BG_YELLOW }}____________{{ NORMAL }}"
    echo "{{ INVERT }} {{ message }} "
    echo "{{ NORMAL }}{{ BG_YELLOW }}____________{{ NORMAL }}"

@printError message="ERROR":
    echo "{{ NORMAL }}{{ BG_RED }}____________{{ NORMAL }}"
    echo "{{ INVERT }} {{ message }} "
    echo "{{ NORMAL }}{{ BG_RED }}____________{{ NORMAL }}"
