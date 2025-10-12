set unstable := true
set allow-duplicate-recipes := true
set allow-duplicate-variables := true

import '.just/version.just'
import '.just/bump.just'
import '.just/print.just'
import '.just/app_lib_link.just'
import '.just/app_lib_unlink.just'
import '.just/app.just'
import '.just/home.just'
import '.just/deno_test.just'
import '.just/git_add_A_git_commit.just'
import '.just/llm.just'

alias v := version

JSON_FILES_WITH_VERSION := ""
ROOT := justfile_directory()
OPEN_FOLDER_IN_EDITOR := "code -r"

_______________:
    just --list

[script('bash')]
fmt:
    just --format
