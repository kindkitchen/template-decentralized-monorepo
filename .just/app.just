import './const.just'

ROOT := `cd .. && pwd`

_:

[script('bash')]
app target="" *args="":
    cd {{ ROOT }}
    target={{ target }}
    OPEN_FOLDER_IN_EDITOR="{{ OPEN_FOLDER_IN_EDITOR }}"
    args="{{ if args == 'cd' { '$OPEN_FOLDER_IN_EDITOR .' } else { args } }}"
    {{ if target == "" { "just printInfo 'You can run any command in context of one of these roots'; tree -dl -L 1 || ls -1" } else { 'cd $target' } }}
    $args
