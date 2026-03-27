[script('bash')]
make_libs_real_in_app app:
    set -e
    cd {{ ROOT }}
    pwd
    ls
    find "{{ app }}" -type l | while read link; do
        src=$(readlink "$link")
        rm "$link"
        mkdir "$link"
        cd "$link"
        cd ..
        path=$(pwd)/$(basename $link)
        just printInfo "pwd: $(pwd)"
        just printInfo "command: cp -r $src/* $path"
        cp -r "$src"/* "$path"
        
        ### debugging ###
        just printInfo "Replace symlink with copy of its content"
        echo "The link's path:"
        just print "$link"
        echo "Copies are from path:"
        just print "$src"
        ### debugging ###

        cd {{ ROOT }}
    done
