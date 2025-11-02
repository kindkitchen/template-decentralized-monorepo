[doc('Pull all submodules, though you may not need all, so do it manually explicitly instead')]
[script('bash')]
pull_all_submodules:
    git submodule update --init --recursive
