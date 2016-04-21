# vi bind
bindkey -v
# enable shift tab
bindkey "^[[Z" reverse-menu-complete

# directory setting
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# history file setting
HISTFILE=~/.zshhist
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_nodups
setopt hist_reduce_blanks
setopt inc_append_history # add history immediately
setopt no_flow_control
setopt share_history

# completion
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*' # ignore case and enable partial-completion
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _approximate _prefix
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ""
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:process' command 'ps x -o pid,s,args'

autoload -Uz select-word-style
select-word-style default

autoload -Uz colors
colors

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'

export EDITOR=vim

# misc
setopt no_beep
setopt print_eight_bit
setopt list_packed
setopt auto_menu
setopt extended_glob
setopt magic_equal_subst
setopt long_list_jobs

REPORTTIME=1

#
# prompt
setopt transient_rprompt

function zle-line-init zle-keymap-select {
	# color of words between ${fg[COLOR]} and ${reset_color} will be changed
	case $KEYMAP in
		vicmd)
PROMPT="[${fg[cyan]}NORMAL${reset_color} %n@%m %D{%c}] %~
%# "
		;;
		main|viins)
PROMPT="[${fg[green]}INSERT${reset_color} %n@%m %D{%c}] %~
%# "
		;;
	esac

	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="[${fg[red]}%BREMOTE%b${reset_color}] ${PROMPT}"

	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# show vcs information on the right prompt
[ -f ~/.zshrc.d/.zsh.vcs_info ] && source ~/.zshrc.d/.zsh.vcs_info

# local setting
unamestr=`uname`
if [[ "$unamestr" == "Darwin" ]]; then
    source ~/.zshrc.local.mac
elif [[ "$unamestr" == "Linux" ]]; then
    source ~/.zshrc.local.linux
fi

# alias
[ -f ~/.zshrc.d/.zsh.alias ] && source ~/.zshrc.d/.zsh.alias

[ -f ~/.zshrc.d/.zsh.functions ] && source ~/.zshrc.d/.zsh.functions

function chpwd() {
    abbr_ls
}

zle -N on_empty_enter
bindkey '^m' on_empty_enter
