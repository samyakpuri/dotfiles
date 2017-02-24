# Lines configured by zsh-newuser-install
setopt appendhistory autocd extendedglob nomatch notify
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/spuri/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


. ~/.shell/alias
. ~/.shell/functions
. ~/.shell/variables

# Run on new shell
have_fortune=`which fortune`
if [ -e have_fortune ]; then
    echo ""
    fortune
    echo ""
fi
