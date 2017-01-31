alias less='less --LINE-NUMBERS --raw-control-chars'

alias grep='grep --line-number --color=auto'

# --color=always does not work in BSD-ls
alias ls='ls --color=always --group-directories-first'
alias ll='ls -l --size --human-readable --classify'
alias la='ls -l --size --human-readable --classify --almost-all'
alias l='ls -C --classify'

alias rm='rm --interactive'
alias cp='cp --interactive'
alias mv='mv --interactive'

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'

