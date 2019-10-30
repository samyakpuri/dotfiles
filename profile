#!/bin/sh

# Add XDG variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Add importnant paths
export PATH=$PATH:$HOME/.scripts
export TERM=xterm-256color

# History Variables
export HISTCONTROL=erasedups  # Ignore duplicate entries in history
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=1000000         # Increases size of history
export SAVEHIST=1000000
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear:clr:[bf]g"

# Variables For i3
export TERMINAL="st"
export BROWSER="firefox"
export BROWSER2="google-chrome-stable"
export GPG_TTY=$(tty)

# export SSH_ASKPASS="~/.scripts/dmenupass"
export EDITOR="vim"
export GPG_TTY=$(tty)

# FZF use silver surfer
export FZF_DEFAULT_COMMAND='rg --files'
