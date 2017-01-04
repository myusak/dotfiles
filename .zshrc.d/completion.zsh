autoload -Uz compinit; compinit

zstyle :compinstall filename '~/.zshrc'

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


