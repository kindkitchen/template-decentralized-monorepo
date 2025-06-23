set unstable := true
set allow-duplicate-recipes := true
set allow-duplicate-variables := true

import '.just/const.just'
import '.just/version.just'
import '.just/bump.just'
import '.just/print.just'
import '.just/app_lib_link.just'
import '.just/app_lib_unlink.just'
import '.just/app.just'
import '.just/format_all_justfiles.just'

alias v := version

ROOT := justfile_directory()

_______________:
    just --list

[script('bash')]
fmt:
    just format_all_justfiles

[script('bash')]
api *args="":
    cd {{ ROOT }}
    cd app/api
    OPEN_FOLDER_IN_EDITOR="{{ OPEN_FOLDER_IN_EDITOR }}"
    {{ if args == "" { "$OPEN_FOLDER_IN_EDITOR ." } else { args } }}
