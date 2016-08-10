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


export ANDROID_HOME=~/Library/Android/sdk
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

export JAVA_HOME=$(/usr/libexec/java_home -v "1.7")
export PATH=$JAVA_HOME/bin:$PATH

# mono
export MONO_GAC_PREFIX="/usr/local"


