# Lines configured by zsh-newuser-install
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
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
	/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:process' command 'ps x -o pid,s,args'
# End of lines added by compinstall

export LANG=ja_JP.UTF-8

# ファイル名が日本語のものを表示可能に
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

# 単語区切りの指定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified



alias -g G='| grep'
alias -g L='| less'
alias la='ls -l -a'
alias lf='ls -F -a -l | grep -v /'
alias ldir='ls -F | grep /'
alias ll='ls -l'
alias up='cd ..'
alias vi='vim'


PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
%# "

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
