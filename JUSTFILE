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
import '.just/project_update_submodules.just'
import '.just/make_libs_real_in_app.just'

alias v := version

JSON_FILES_WITH_VERSION := '''\
 util_plopper/deno.json\
 util_xstate/deno.json\
 project_support/deno.json\
\
\
\
\
'''
ROOT := justfile_directory()
OPEN_FOLDER_IN_EDITOR := "code -r"
GIT_LINK := "https://github.com/kindkitchen/hft/actions"

[script('bash')]
_______________:
    just --list

[script('bash')]
fmt:
    just --format

# ## Helpers
[script('bash')]
pr *args:
    set -e
    just commit {{ args }}
    git submodule foreach 'git push origin $(git branch --show-current)'
    git push origin dev && gh pr create --fill-verbose && gh pr merge --auto --merge
    git checkout main
    git branch -D dev
    git pull origin main
    git checkout -b dev
    echo "{{ GIT_LINK }}"
