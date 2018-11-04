#!/bin/sh

# Add importnant paths
export PATH=$PATH:$HOME/.scripts
export TERM=xterm-256color

# History Variables
export HISTCONTROL=erasedups  # Ignore duplicate entries in history
export HISTFILE=~/.histfile
export HISTSIZE=10000         # Increases size of history
export SAVEHIST=10000
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear:clr:[bf]g"

# Variables For i3
export TERMINAL="st"
export BROWSER="firefox"
