#!/bin/bash
# File              : install.sh
# Author            : Samyak Puri <samyakpuri@hotmail.com>
# Date              : 18.10.2018
# Last Modified Date: 04.11.2018
# Last Modified By  : Samyak Puri <samyakpuri@hotmail.com>

check(){
    [[ -e ~/.dotfiles/.installed ]] && echo "Dotfiles already installed ...... exiting......." && exit

    [[ ! -d ~/.dotfiles ]] && cd $HOME && git clone https://github.com/samyakpuri/dotfiles ~/.dotfiles
   
    echo "$HOME"
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
    prefix=""	
    [[ $3 = "d" ]] && prefix="."
    for name in $(ls $1); do
        target="$2/$prefix$name"
        if [[ ! "$name" = "config" ]] && [[ ! "$name" = "README.MD" ]] && [[ ! "$name" = "gitconfig" ]]; then
           backup $target
           echo "-----> Symlinking your new $target"
           ln -snf "$1/$name" "$target"
        fi
    done
}

setupgit(){

    cp gitconfig "$HOME"/.gitconfig
    echo "Type in your first and last name (no accent or special characters - e.g. 'cs'): "
    read full_name

    echo "Type in your email address (the one used for your GitHub account): "
    read email

    git config --global user.email $email
    git config --global user.name $full_name
}

finalize(){
    ln -s "$PWD"/vim/vimrc "$HOME"/.vimrc
    mkdir "$HOME"/.config/neovim
    ln -s "$PWD"/vim/vimrc "$HOME"/.config/neovim/init.vim
    mkdir -p "$HOME"/.backups/{backups,swaps,undofiles}
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
    uninstall "$HOME"/.config
    exit
fi

# Check if dotfiles are installed
check

# Install the dotfiles
makelinks "$PWD" "$HOME" "d"

makelinks "$PWD"/config "$HOME"/.config

# Setup gitconfig
setupgit

# Finalize config
finalize

# Set install file
touch "$HOME"/.dotfiles/.installed
