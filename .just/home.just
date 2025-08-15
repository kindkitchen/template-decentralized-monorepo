ROOT := `ROOT`
OPEN_FOLDER_IN_EDITOR := `OPEN_FOLDER_IN_EDITOR`

[script('bash')]
home *args="":
    cd {{ ROOT }}
    OPEN_FOLDER_IN_EDITOR="{{ OPEN_FOLDER_IN_EDITOR }}"
    {{ if args == "cd" { "$OPEN_FOLDER_IN_EDITOR ." } else { args } }}
