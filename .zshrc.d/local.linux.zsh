if [[ `uname` != "Linux" ]];
then
	return
fi

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

export PATH="$HOME/.local/bin:$PATH"
