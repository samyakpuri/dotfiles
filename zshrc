#############################################
#     _____  ____    _   _
#    |__  / / ___|  | | | |
#      / /  \___ \  | |_| |
#     / /_   ___) | |  _  |
#    /____| |____/  |_| |_|
#
#############################################


# {{{ ZSH Modules

	autoload -Uz compinit
	autoload -U promptinit zcalc
	autoload -U colors && colors
	fpath=(${XDG_CONFIG_HOME}/zsh/functions ${XDG_CONFIG_HOME}/zsh/completions $fpath)
	autoload -U $fpath[1]/*(.:t) 

	_comp_files=(${XDG_CACHE_HOME}/zsh/zcompdump(Nm-20))
	if (( $#_comp_files )); then
	compinit -i -C -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
	else
	compinit -i -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
	fi
	unset _comp_files
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
  setopt COMPLETE_IN_WORD
  setopt COMPLETE_ALIASES
  setopt PROMPT_SUBST
  unsetopt HASH_DIRS
  unsetopt HASH_CMDS
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

#{{{ Completion
    zstyle ':completion::complete:*' use-cache 1
    zstyle ':completion:*' accept-exact '*(N)'
    zstyle ':completion:*' rehash true
    zstyle ':completion:*' use-cache on
    zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME}/zcompcache"
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:messages' format '%d'
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' auto-description 'specify: %d'
    zstyle ':completion:*:default' list-prompt '%S%M matches%s'
    zstyle ':completion:*:default' menu 'select=0'
    zstyle ':completion:*' file-sort modification reverse
    zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
    zstyle ':completion:*:manuals' separate-sections true
    zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'
    zstyle ':completion::*:(rm|vi):*' ignore-line true
    zstyle ':completion:*' ignore-parents parent pwd
    zstyle ':completion::approximate*:*' prefix-needed false

    #{{{ Ignore
        zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~|*.o|*.class)"
        zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
        zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns
    #}}}
#}}}

# {{{ Alias

    alias clip="xclip -selection clipboard -i"
    alias p="ping 9.9.9.9" # Check if internet working
    alias ping="ping -c 5"
    alias md="mkdir -p"
	alias rd="rmdir"
	alias rm="rm -I"
    alias vim="fuzzy_edit"
    alias e=vim
    alias edit=vim
    alias grep="grep --line-number --ignore-case --color=auto --exlude-dir={.git}"
    alias pb="nc termbin.com 9999"
	alias sys="sudo systemctl"
	# Highlight with less
	alias highlight="highlight --force -O xterm256 --style molokai"

	alias ls="ls --color=always"
	alias l="ls -lh"
	alias ll='ls -lah'
	alias less="less -R"

	# Easy dir navigation
	alias d="dirs -v"
	alias 1='cd -'
	alias 2='cd -2'
	alias 3='cd -3'
	alias 4='cd -4'
	alias 5='cd -5'
	alias 6='cd -6'
	alias 7='cd -7'
	alias 8='cd -8'
	alias 9='cd -9'

	#{{{ Git Aliases

		alias ga="git add"
		alias gb="git branch"
		alias gc="git commit -m"
		alias gco="git checkout"
		alias gcb="git checkout -b"
		alias gcom="git checkout master"
		alias gs="git status -sb"
		alias gca="git commit --amend"
		alias gcl="git clone"
		alias git="hub"
		alias gl="git log --format=format:'%C(auto)%h %C(green)%aN%Creset %Cblue%cr%Creset %s'"

	# }}}

	#{{{ Functions

        function c()
        {
            if [[ $# -eq 1 ]];
            then
                cd "$@" &> /dev/null && l
                if [[ $? -ne 0 ]];
                then
                    cd_fzf "$@";
                fi

            elif [[ $# -eq 0 ]];
            then
                cd ~ && clear
            fi
        }

        function back_dir()
        {
            if [[ "$#" == 0 ]]; then
                c ../
            else
                for i in {1..$1}
                do
                    c ../
                done
            fi
        }

	#}}}

	#{{{ Global Alias

		alias -g G='|& grep'
		alias -g C='| wc -l'
		alias -g H='| head'
		alias -g L='| less'
		alias -g N='&> /dev/null'i

		globalias() {
		   if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
			 zle _expand_alias
			 zle expand-word
		   fi
		   zle self-insert
		}

		zle -N globalias

		bindkey " " globalias
		bindkey "^ " magic-space           # control-space to bypass completion
		bindkey -M isearch " " magic-space # normal space during searches

	#}}}

# }}}

#{{{ Key bindings
	#{{{ Special keys

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
	[[ -n “$key[Left]”  ]] && bindkey “$key[Left]” backward-char
	[[ -n “$key[Right]”  ]] && bindkey “$key[Right]” forward-char

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
    bindkey -s '^Y' 'back_dir\n'

    bindkey '^r' history-incremental-search-backward
    autoload -z edit-command-line
    zle -N edit-command-line
    bindkey '^E' edit-command-line
    # bindkey -M viins '^E' insert-last-word

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
    bindkey -s '\e9' "!:0 !:2* \t"   # all but the 1st argument (aka 2nd word)
#}}}

#{{{ Prompt

	autoload -Uz vcs_info add-zsh-hook
	add-zsh-hook precmd vcs_info

	zstyle ':vcs_info:*' unstagedstr '%F{yellow}✗'
	zstyle ':vcs_info:*' check-for-changes true
	zstyle ':vcs_info:*' actionformats '%a'
	zstyle ':vcs_info:*' formats '%F{blue}%s:%F{7}(%b)%u%m'
	zstyle ':vcs_info:git*+set-message:*' hooks git-ahead
	zstyle ':vcs_info:*' enable git

	+vi-git-ahead()
	{
		set -- git rev-list --left-right HEAD...@{u} --count 2> /dev/null
		ahead=$1
		behind=$2
		if [[ -n $ahead ]]; then
		hook_com[misc]+='⇡'
		else
		hook_com[misc]+='⇣'
		fi
	}


	# Define prompts.
	local ret_status="%(?:%{$fg[green]%}➜ :%{$fg[red]%}➜ )"
	PROMPT='%{$fg[cyan]%}%c ${vcs_info_msg_0_}${ret_status}%{$reset_color%}'
#}}}

#{{{ Misc
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

#{{{ Global Functions

    function fuzzy_edit()
    {
		[[ "$#" -gt 1  ||  "$#" -eq 0 ]] && $EDITOR $* && return 0;

		[[ -w "$1" || ((! -f "$1") && (-w "$1:h" && -x "$1:h")) ]] && $EDITOR "$1"  && return 0;

		echo
		echo "\tTo root or not to root that is the question...  "
		echo
		read option

		if [[ "$option" == "y" ]];
		then
			sudo -e "$1"
		else
			$EDITOR "$1"
		fi
		clear
    }
#}}}

# vim:fdm=marker
