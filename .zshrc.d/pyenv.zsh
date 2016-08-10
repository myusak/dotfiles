if type pyenv > /dev/null;
then
	export PATH="$HOME/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
fi

