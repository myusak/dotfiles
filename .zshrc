export EDITOR=vim

export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'

if [[ -d $HOME/.zshrc.d ]];
then
	FPATH=$HOME/.zshrc.d:$FPATH

	for rc in ~/.zshrc.d/*.zsh;
	do
		source $rc
	done
fi

# autoloads
autoload -Uz abbr_ls
autoload -Uz colors; colors

# vi bind
bindkey -v
# enable shift tab
bindkey "^[[Z" reverse-menu-complete

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# history file setting
HISTFILE=~/.zshhist
SAVEHIST=1000000

REPORTTIME=1
KEYTIMEOUT=1 # times out multi-char key combos as fast as possible. (1/100th of a second.)

# directory setting
setopt always_to_end
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_nodups
setopt hist_reduce_blanks
setopt inc_append_history # add history immediately
setopt no_flow_control
setopt share_history
setopt no_beep
setopt print_eight_bit
setopt list_packed
setopt auto_menu
setopt extended_glob
setopt magic_equal_subst
setopt long_list_jobs

# prompt
setopt transient_rprompt

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

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

function zle-line-init zle-keymap-select {
	# color of words between ${fg[COLOR]} and ${reset_color} will be changed
	case $KEYMAP in
		vicmd)
			mode="%F{cyan}NOR%f"
		;;
		main|viins)
			mode="%F{green}INS%f"
		;;
	esac

	# %n: user name
	# %m: hostname
	# %W: date (mm/dd/yy)
	# %*: time (hh:mm:ss)
	# %~: current directory
	# %#: user type (root: #, other: %)
	PROMPT="
<$mode> (%D %*) <%?> [%~]
%F{cyan}%m%f %# "

	#[ -n "$STY" ] && PROMPT="[%F{yellow}SCREEN%f]${PROMPT}"

	#[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="[%F{red}%BREMOTE%b%f]${PROMPT}"

	zle reset-prompt
}

function on_empty_enter() {
	if [ -n "$BUFFER" ]; then
		zle accept-line
		return 0
	fi

	echo
	abbr_ls

	if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
		echo
		echo -e "\e[0;33m--- git status ---\e[0m"
		git status -sb
	fi
	zle reset-prompt
	return 0
}

function chpwd() {
    abbr_ls
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N on_empty_enter
bindkey '^m' on_empty_enter

if [ -e ~/.antigen ];
then
	source ~/.antigen/antigen.zsh

	antigen bundle zsh-users/zsh-syntax-highlighting
	antigen bundle zsh-users/zsh-completions
	antigen bundle zsh-users/zsh-autosuggestions

	antigen apply
fi

# local rc will override configurations
if [[ -e $HOME/.zshrc.local ]];
then
	source $HOME/.zshrc.local
fi

