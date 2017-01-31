autoload -Uz select-word-style; select-word-style default
autoload -U compinit; compinit
autoload -Uz colors; colors

autoload history-search-end

bindkey -v # vi bind

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey "^[[Z" reverse-menu-complete # enable shift tab

setopt always_last_prompt
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt auto_param_slash
setopt auto_param_keys
setopt extended_glob
setopt extended_history
setopt glob
setopt glob_dots
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history # add history immediately
setopt interactive_comments
setopt list_packed
setopt long_list_jobs
setopt magic_equal_subst
setopt no_flow_control
setopt no_beep
setopt numeric_glob_sort
setopt pushd_ignore_dups
setopt print_eight_bit
setopt rec_exact
setopt share_history
setopt transient_rprompt

zstyle :compinstall filename '~/.zshrc'

zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} r:|[._-]=*' # ignore case and enable partial-completion
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _approximate _prefix
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:process' command 'ps x -o pid,s,args'

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

