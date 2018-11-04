#!/bin/bash
# File              : install.sh
# Author            : Samyak Puri <samyakpuri@hotmail.com>
# Date              : 18.10.2018
# Last Modified Date: 18.10.2018
# Last Modified By  : Samyak Puri <samyakpuri@hotmail.com>

check(){
    [[ -d ~/.dotfiles ]] && echo "Dotfiles already installed ...... exiting......." && exit

    cd $HOME
    git clone git@github.com:samyakpuri/dotfiles ~/.dotfiles
    cd "$HOME/.dotfiles"
}

backup() {
    target=$1
    if [ -e "$target"  ]; then              # Does the config file already exist?
        if [ ! -L "$target"  ]; then        # as a pure file?
            mv "$target" "$target.backup"   # Then backup it
            echo "-----> Moved your old $target config file to $target.backup"
        fi
    fi
}

makelinks(){
    for name in $(ls $1); do
        target="$2/.$name"
        if [[ ! "$name" = "config" ]] && [[ ! "$name" = "README.MD" ]] && [[ ! "$name" = "gitconfig" ]]; then
           backup $target
           echo "-----> Symlinking your new $target"
           ln -s "$sour/$name" "$target"
        fi
    done
}

setupgit(){

    cp gitconfig "$HOME/gitconfig"
    echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
    read full_name

    echo "Type in your email address (the one used for your GitHub account): "
    read email

    git config --global user.email $email
    git config --global user.name $full_name
}

uninstall(){
    cd $1
    for name in $(ls *.backup); do
        old=${name%.backup}
        [[ -d $name ]] && rm -r $old && mv $name $old
        rm $old && mv $name $old
    done
}

if [[ "$1" = "un" ]]; then
    uninstall $HOME
    uninstall "$HOME/.config"
    exit
fi

# Check if dotfiles are installed
check

# Install the dotfiles
makelinks "$PWD" "$HOME"

makelinks "$PWD/config" "$HOME/.config"

# Setup gitconfig
setupgit

