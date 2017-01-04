if [[ `uname` != "Darwin" ]];
then
	return
fi

# homebrew settings
if brew --prefix coreutils >& /dev/null;
then
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
	export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

if brew --prefix findutils >& /dev/null;
then
	alias find='gfind'
	alias xargs='gxargs'
fi

if brew --prefix go-gui >& /dev/null;
then
	export PATH="$(brew --prefix go-gui)/GoGui.app/Contents/bin:$PATH"
fi

