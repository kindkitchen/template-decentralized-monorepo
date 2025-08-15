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

# This is monkey-patch. The goal is to replace links in lib with cp of original files, thought it is only may become handy
[script('bash')]
_lib_links_to_files app:
    cd {{ ROOT }}
    app="{{ app }}"
    mkdir __lib__
    ls "$app/lib" |
        while read lib;
        do mv "$lib" "__lib__/$lib"
        done;
    rm -fr "$app/lib"
    mv "__lib__" "app/$app/lib"

[script('bash')]
fmt:
    just format_all_justfiles
    just ui just fmt
    just api just fmt
