# vim: fdm=marker
#############################################
#     _____  ____    _   _
#    |__  / / ___|  | | | |
#      / /  \___ \  | |_| |
#     / /_   ___) | |  _  |
#    /____| |____/  |_| |_|
#
#############################################

 # Fix for wsl
 [ -f "${HOME}/.config/zsh/.zshenv" ] && source "${HOME}/.config/zsh/.zshenv"
# {{{ Plugins
    # use zap
    [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
    
    plug "zsh-users/zsh-autosuggestions"
    plug "zsh-users/zsh-completions"
    plug "zap-zsh/completions"
    plug "MichaelAquilina/zsh-you-should-use"
    plug "Mellbourn/zabb"
    plug "GianniBYoung/omz-take"
    plug "hlissner/zsh-autopair"
    plug "zap-zsh/supercharge"
    plug "zap-zsh/vim"
    plug "zap-zsh/fzf"
    plug "Aloxaf/fzf-tab"
    plug "joshskidmore/zsh-fzf-history-search"
    plug "zsh-users/zsh-syntax-highlighting"
    plug "zsh-users/zsh-history-substring-search"
    plug "sunlei/zsh-ssh"
    
    # disable CTRL+X reload config
    bindkey -r "^X"

    source $XDG_DATA_HOME/zap/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
    source $XDG_DATA_HOME/zap/plugins/zsh-completions/zsh-completions.plugin.zsh
#}}}

# {{{ ZSH Modules

    autoload -U promptinit zcalc
    autoload -U colors && colors
    fpath=(${XDG_CONFIG_HOME}/zsh/functions ${XDG_CONFIG_HOME}/zsh/completions $fpath)
    autoload -U $fpath[1]/*(.:t)

    autoload -Uz bracketed-paste-url-magic
    zle -N bracketed-paste bracketed-paste-url-magic

    # http://onethingwell.org/post/24608988305/zmv
    autoload -Uz zmv

# }}}

# {{{ General Options

    setopt AUTO_CD
    setopt AUTO_PUSHD
    setopt PUSHD_IGNORE_DUPS
    setopt PUSHD_SILENT
    setopt PUSHD_TO_HOME
    setopt NO_HUP
    setopt NO_CHECK_JOBS
    setopt IGNORE_EOF
    setopt NO_BEEP
    setopt NUMERIC_GLOB_SORT
    setopt EXTENDED_GLOB
    setopt GLOB_COMPLETE
    setopt RC_EXPAND_PARAM
    setopt HASH_DIRS
    setopt HASH_CMDS
    unsetopt FLOW_CONTROL
    unsetopt CLOBBER

# }}}

# {{{ history options

    setopt BANG_HIST                 # Treat the '!' character specially during expansion.
    setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
    setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
    setopt SHARE_HISTORY             # Share history between all sessions.
    setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
    setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
    setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
    setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
    setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
    setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
    setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
    setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

#}}}

# # {{{ Completion
#     setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
#     setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
#     setopt PATH_DIRS           # Perform path search even on command names with slashes.
#     setopt AUTO_MENU           # Show completion menu on a successive tab press.
#     setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
#     setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
#     setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
#     setopt NO_COMPLETE_ALIASES # autocompletion CLI switches for aliases
#     unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
#
#     # Set xdg zcompdump location
#     zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
#
#     # Activate Bash auto-completion
#     autoload -U bashcompinit
#     bashcompinit
#
#     # Activate auto-completion
#     zmodload -i zsh/complist
#
#     # Use caching to make completion for commands such as dpkg and apt usable.
#     zstyle ':completion::complete:*' use-cache on
#     zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
#
#     # autocomplete case-insensitive (all),partial-word and then substring
#     zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#     unsetopt CASE_GLOB
#
#     # Group matches and describe.
#     zstyle ':completion:*:*:*:*:*' menu select
#     zstyle ':completion:*:matches' group 'yes'
#     zstyle ':completion:*:options' description 'yes'
#     zstyle ':completion:*:options' auto-description '%d'
#     zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
#     zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
#     zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
#     zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
#     zstyle ':completion:*:default' list-prompt '%S%M matches%s'
#     zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
#     zstyle ':completion:*' group-name ''
#     zstyle ':completion:*' verbose yes
#     zstyle ":completion:*:commands" rehash 1
#
#     # Fuzzy match mistyped completions.
#     zstyle ':completion:*' completer _complete _match _approximate
#     zstyle ':completion:*:match:*' original only
#     zstyle ':completion:*:approximate:*' max-errors 1 numeric
#
#     # Increase the number of errors based on the length of the typed word. But make
#     # sure to cap (at 7) the max-errors to avoid hanging.
#     zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
#
#     # Don't complete unavailable commands.
#     zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
#
#     # Array completion element sorting.
#     zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
#
#     # Directories
#     zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#     zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd never selects the parent directory (e.g.: cd ../<TAB>)
#     zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
#     zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
#     zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
#     zstyle ':completion:*' squeeze-slashes true
#
#     # Ignore VCS directories
#     zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)(.svn|.git|.hg)'
#     zstyle ':completion:*:cd:*' ignored-patterns '(*/)(.svn|.git|.hg)'
#
#     # History
#     zstyle ':completion:*:history-words' stop yes
#     zstyle ':completion:*:history-words' remove-all-dups yes
#     zstyle ':completion:*:history-words' list false
#     zstyle ':completion:*:history-words' menu yes
#
#     # Environment Variables
#     zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
#
#     # Don't complete uninteresting users...
#     zstyle ':completion:*:*:*:users' ignored-patterns \
#       adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
#       dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
#       hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
#       mailman mailnull mldonkey mysql nagios \
#       named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
#       operator pcap postfix postgres privoxy pulse pvm quagga radvd \
#       rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'
#
#     # ... unless we really want to.
#     zstyle '*' single-ignored show
#
#     #{{{ Ignore
#         zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
#         zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~|*.o|*.class)"
#         zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
#         zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns
#     #}}}
#
#     compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
    # _comp_files=(${XDG_CACHE_HOME}/zsh/zcompdump(Nm-20))
    # if (( $#_comp_files )); then
    # compinit -i -C -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
    # else
    # compinit -i -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
    # fi
    # unset _comp_files

#}}}

# {{{ Alias

    # Source common alias
    [ -f "$HOME/.config/shell/aliasrc" ] && source "$HOME/.config/shell/aliasrc"

    # source custom alias functions
    [ -f "$HOME/.config/shell/functions" ] && source "$HOME/.config/shell/functions"
    
    #{{{ Global Alias

        alias -g G='|& grep'
        alias -g W='| wc -l'
        alias -g H='| head'
        alias -g L='| less'
        alias -g N='&> /dev/null'
        alias -g C='|& xclip'
        alias -g TC="|& tee >(xclip)"

        #{{{ Alias expansion
            # globalias() {
            #    if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
            #    zle _expand_alias
            #    zle expand-word
            #    fi
            #    zle self-insert
            # }

            # zle -N globalias

            # bindkey " " globalias
            # bindkey "^ " magic-space           # control-space to bypass completion
            # bindkey -M isearch " " magic-space # normal space during searches

        #}}}

#}}}

# }}}

# {{{ Key bindings
    # {{{ Special keys

    # create a zkbd compatible hash;
    # to add other keys to this hash, see: man 5 terminfo
    typeset -g -A key

    key[Home]=”$terminfo[khome]”
    key[End]=”$terminfo[kend]”
    key[Insert]=”$terminfo[kich1]”
    key[Backspace]=”$terminfo[kbs]”
    key[Delete]=”$terminfo[kdch1]”
    key[Up]=”$terminfo[kcuu1]”
    key[Down]=”$terminfo[kcud1]”
    key[Left]=”$terminfo[kcub1]”
    key[Right]=”$terminfo[kcuf1]”
    key[PageUp]=”$terminfo[kpp]”
    key[PageDown]=”$terminfo[knp]”

    # setup key accordingly
    [[ -n “$key[Home]”  ]] && bindkey “$key[Home]” beginning-of-line
    [[ -n “$key[End]”  ]] && bindkey “$key[End]” end-of-line
    [[ -n “$key[Insert]”  ]] && bindkey “$key[Insert]” overwrite-mode
    [[ -n “$key[Backspace]”  ]] && bindkey “$key[Backspace]” backward-delete-char
    [[ -n “$key[Delete]”  ]] && bindkey “$key[Delete]” delete-char
    [[ -n “$key[Up]”  ]] && bindkey “$key[Up]” up-line-or-history
    [[ -n “$key[Down]”  ]] && bindkey “$key[Down]” down-line-or-history
    # [[ -n “$key[Left]”  ]] && bindkey “$key[Left]” backward-char
    # [[ -n “$key[Right]”  ]] && bindkey “$key[Right]” forward-word

    bindkey '^A' beginning-of-line
    bindkey '^E' end-of-line

    # Finally, make sure the terminal is in application mode, when zle is
    # active. Only then are the values from $terminfo valid.
    if (( ${+terminfo[smkx]}  )) && (( ${+terminfo[rmkx]}  )); then
        function zle-line-init () {
            echoti smkx
        }
        function zle-line-finish () {
            echoti rmkx
        }
        zle -N zle-line-init
        zle -N zle-line-finish
    fi

    #}}}

    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey '\e[A' up-line-or-beginning-search
    bindkey '\eOA' up-line-or-beginning-search

    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey '\e[B' down-line-or-beginning-search
    bindkey '\eOB' down-line-or-beginning-search

    bindkey '^O' clear-screen

    # bindkey '^r' history-incremental-search-backward
    autoload -z edit-command-line
    zle -N edit-command-line
    bindkey '^X^E' edit-command-line
    # bindkey -M viins '^E' insert-last-word

    # Fixing delete key
    bindkey '^[[3~' vi-delete-char

    # Bang! Previous Command Hotkeys
    # print previous command but only the first nth arguments
    # Alt+1, Alt+2 ...etc
    # http://www.softpanorama.org/Scripting/Shellorama/bash_command_history_reuse.shtml#Bang_commands
    bindkey -s '\e1' "!:0 \t"        # last command
    bindkey -s '\e2' "!:0-1 \t"      # last command + 1st argument
    bindkey -s '\e3' "!:0-2 \t"      # last command + 1st-2nd argument
    bindkey -s '\e4' "!:0-3 \t"      # last command + 1st-3rd argument
    bindkey -s '\e5' "!:0-4 \t"      # last command + 1st-4th argument
    bindkey -s '\e`' "!:0- \t"       # all but the last argument
    bindkey -s '\e9' "!:* \t"   # all but the 1st argument (aka 2nd word)

    # CTRL+D to exit shell
    exit_zsh() { exit }
    zle -N exit_zsh
    bindkey '^D' exit_zsh
#}}}


# {{{ Misc
    # Deactivate Software flow control
    stty -ixon

    # Set proper terminal for SCREEN and TMUX
    if [[ -z $TMUX ]]; then
        if [ -e /usr/share/terminfo/x/xterm+256color ]; then
            export TERM='xterm-256color'
        else
            export TERM='xterm'
        fi
    else
        if [ -e /usr/share/terminfo/s/screen-256color ]; then
            export TERM='screen-256color'
        else
            export TERM='screen'
        fi
    fi

    # Take me home to the place I belong, take me home, country roads...
    if [[ `pwd` == "/" ]]
    then
        cd ~
    fi
#}}}

# {{{ Global Functions

    # add sudo in front of current command
    # https://www.reddit.com/r/zsh/comments/4b2lyj/send_a_simulated_keypress_from_zle_script_to/
    sudo_ (){
        if [[ $BUFFER =~ "sudo" ]]
        then
            BUFFER=${BUFFER//sudo }
            CURSOR=$
        else
            BUFFER="sudo $BUFFER"
            CURSOR=$#BUFFER
        fi
    }
    zle -N sudo_
    bindkey "" sudo_

    # Automatically expand all aliases:
    # - don't forget the actual commands
    # - don't confuse your pairing partner

    # preexec_functions=()

    # function expand_aliases {
    #   input_command=$1
    #   expanded_command=$2
    #   if [ $input_command != $expanded_command ]; then
    #   print -nP $PROMPT
    #   echo $expanded_command
    #   fi
    # }

    # preexec_functions+=expand_aliases

#}}}


# {{{ ZSH Autocompletion
    # Remove forward-char widgets from ACCEPT
    ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}")
    ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#vi-forward-char}")

    # Add forward-char widgets to PARTIAL_ACCEPT
    ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char)
    ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(vi-forward-char)

    # Add custom widget to complete partial if cursor is at end of buffer
    autosuggest_partial_wordwise () {
        if [[ $CURSOR -lt ${#BUFFER} && $KEYMAP != vicmd ||
              $CURSOR -lt $((${#BUFFER} - 1)) ]]; then
        # if [[ $CURSOR == $#BUFFER ]]; then
          # if cursor is at end of buffer invoke forward-word widget
          zle forward-char
        else
          # if cursor is not at end of buffer invoke forward-char widget
          zle forward-word
        fi
    }

    zle -N autosuggest_partial_wordwise
    bindkey "${terminfo[kcuf1]}" autosuggest_partial_wordwise

    # Add autosuggest_partial_wordwise to IGNORE
    ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(autosuggest_partial_wordwise)

    # ussh wssh ssh slogin hosts Autocompletion
    h=()
    if [[ -r ~/.ssh/config ]]; then
        h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
    fi
    if [[ $#h -gt 0 ]]; then
        zstyle -e ':completion:*:ssh:*' hosts    'reply=($h)'
        zstyle -e ':completion:*:slogin:*' hosts 'reply=($h)'
        zstyle -e ':completion:*:ussh:*' hosts   'reply=($h)'
        zstyle -e ':completion:*:wssh:*' hosts   'reply=($h)'
        zstyle -e ':completion:*:wvnc:*' hosts   'reply=($h)'
    fi

#}}}

#{{{ Bash like commmand not found
command_not_found_handle () 
{ 
    if [ -x /usr/lib/command-not-found ]; then
        /usr/lib/command-not-found -- "$1";
        return $?;
    else
        if [ -x /usr/share/command-not-found/command-not-found ]; then
            /usr/share/command-not-found/command-not-found -- "$1";
            return $?;
        else
            printf "%s: command not found\n" "$1" 1>&2;
            return 127;
        fi;
    fi
}
#}}}

if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

command -v starship &> /dev/null && eval "$(starship init zsh)"
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

export HISTFILE="${XDG_STATE_HOME}/zsh/history"

[ -f $XDG_DATA_HOME/cargo/env ] && source $XDG_DATA_HOME/cargo/env 
[ -f $XDG_CONFIG_HOME/broot/launcher/bash/br ] && source $XDG_CONFIG_HOME/broot/launcher/bash/br

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
