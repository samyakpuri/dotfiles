#!/usr/bin/env sh

################################################################################
#
#
#           Create symlinks for dotfile
#           Needs to run from dotfiles dir where ever downloaded to
#
#
################################################################################

###############
# Variables
###############
# use git root as dotfile directory
dotfiles_dir=$(git rev-parse --show-toplevel)

##################################
# Delete existing dotfiles
##################################
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.config/alacritty > /dev/null 2>&1
sudo rm -rf ~/.config/dunst > /dev/null 2>&1
sudo rm -rf ~/.config/git > /dev/null 2>&1
sudo rm -rf ~/.config/i3 > /dev/null 2>&1
sudo rm -rf ~/.config/i3blocks > /dev/null 2>&1
sudo rm -rf ~/.config/mpd > /dev/null 2>&1
sudo rm -rf ~/.config/nvim > /dev/null 2>&1
sudo rm -rf ~/.config/python > /dev/null 2>&1
sudo rm -rf ~/.config/shell > /dev/null 2>&1
sudo rm -rf ~/.config/sxhkd > /dev/null 2>&1
sudo rm -rf ~/.config/wget > /dev/null 2>&1
sudo rm -rf ~/.config/X11 > /dev/null 2>&1
sudo rm -rf ~/.config/starship.toml > /dev/null 2>&1
sudo rm -rf ~/.config/user-dirs.dirs > /dev/null 2>&1
sudo rm -rf ~/.config/user-dirs.locale > /dev/null 2>&1
sudo rm -rf ~/.bashrc > /dev/null 2>&1
sudo rm -rf ~/.bash_logout > /dev/null 2>&1
sudo rm -rf ~/.bash_history > /dev/null 2>&1
sudo rm -rf ~/.bash_profile > /dev/null 2>&1
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
sudo rm -rf ~/.lesshst > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.zshenv > /dev/null 2>&1
sudo rm -rf ~/.zprofile > /dev/null 2>&1
sudo rm -rf ~/.zlogin > /dev/null 2>&1
sudo rm -rf ~/.zlogout > /dev/null 2>&1


##################################
# Delete existing dotfiles
##################################
ln -sf $dotfiles_dir/config/X11 ~/.config/X11
ln -sf $dotfiles_dir/config/alacritty ~/.config/alacritty
ln -sf $dotfiles_dir/config/dunst ~/.config/dunst
ln -sf $dotfiles_dir/config/git ~/.config/git
ln -sf $dotfiles_dir/config/i3 ~/.config/i3
ln -sf $dotfiles_dir/config/i3blocks ~/.config/i3blocks
ln -sf $dotfiles_dir/config/mpd ~/.config/mpd
ln -sf $dotfiles_dir/config/nvim ~/.config/nvim
ln -sf $dotfiles_dir/config/python ~/.config/python
ln -sf $dotfiles_dir/config/shell ~/.config/shell
ln -sf $dotfiles_dir/config/starship.toml ~/.config/starship.toml
ln -sf $dotfiles_dir/config/sxhkd ~/.config/sxhkd
ln -sf $dotfiles_dir/config/user-dirs.dirs ~/.config/user-dirs.dirs
ln -sf $dotfiles_dir/config/user-dirs.locale ~/.config/user-dirs.locale
ln -sf $dotfiles_dir/config/vim ~/.config/vim
ln -sf $dotfiles_dir/config/wget ~/.config/wget
ln -sf $dotfiles_dir/config/zsh ~/.config/zsh
ln -sf $dotfiles_dir/share ~/.local/share/$USER

##################################
# Make XDG compliant dirs
##################################
mkdir -p ~/.local/share/vim
mkdir -p ~/.local/state/vim
mkdir -p ~/.local/state/zsh
mkdir -p ~/.cache/zsh
mkdir -p ~/.cache/X11
