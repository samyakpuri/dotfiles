#!/usr/bin/env zsh

# Disable compinit creation in Ubuntu by /etc/zsh/zshrc
skip_global_compinit=1

# Load environmental variables.
[ -f "$HOME/.config/shell/env" ] && source "$HOME/.config/shell/env"
