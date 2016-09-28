alias less='less -N -r'

alias grep='grep -n --color=auto'

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'

# --color=always does not work in BSD-ls
alias ls='ls --color=always --group-directories-first'
alias ll='ls -l --size --human-readable --classify'
alias la='ls -l --size --human-readable --classify --almost-all'
alias l='ls -C --classify'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

