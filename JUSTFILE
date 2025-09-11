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
fmt:
    just format_all_justfiles
    just example_v1 just fmt
    just example_codegen just fmt

[script('bash')]
example_codegen *args="":
    just app example_codegen {{ args }}

[script('bash')]
example_v1 *args="":
    just app example_v1 {{ args }}
