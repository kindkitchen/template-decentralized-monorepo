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
import '.just/home.just'

alias v := version

ROOT := justfile_directory()

_______________:
    just --list

[script('bash')]
check *args:
    COMMAND="deno check {{ args }}"

[script('bash')]
main_api *args="":
    just app main_api {{ args }}

alias api := main_api

[script('bash')]
main_ui *args="":
    just app main_ui {{ args }}

alias ui := main_ui

[script('bash')]
fmt:
    just format_all_justfiles
    just ui just fmt
    just api just fmt
