FPATH="$HOME/.zshrc.d/bin:$FPATH"

autoload -U leafdir
autoload -U abbrls

function chpwd() {
	abbrls
}
