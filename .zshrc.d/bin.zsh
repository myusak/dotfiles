FPATH="$HOME/.zshrc.d/bin:$FPATH"

autoload -U leafdir
autoload -U abbrls
autoload -U ssh

function chpwd() {
	abbrls
}
