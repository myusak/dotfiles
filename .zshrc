HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -v
# End of lines configured by zsh-newuser-install
#
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

# 小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../ の後は今いるディレクトリを補完させない
zstyle ':completion:*' ignore-parents parent pwd ..
# sudo の後ろでコマンド名を補完させる
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:process' command 'ps x -o pid,s,args'
# End of lines added by compinstall

# 単語区切りの指定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

setopt print_eight_bit
setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt magic_equal_subst
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt auto_menu
setopt extended_glob

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

alias ll='ls -lshF'
alias la='ls -lshFA'
alias up='cd ..'

PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
%# "

