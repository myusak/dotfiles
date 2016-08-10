#!/usr/bin/env zsh

cd $(dirname $0)
for dotfile in .?*
do
	if  [ $dotfile != '..' ] && \
		[ $dotfile != '.git' ] && \
		[ $dotfile != '.gitignore' ] && \
		[ $dotfile != '.gitmodules' ] && \
		[ $dotfile != '.DS_Store' ]
	then
		echo "symlink from $dotfile to $HOME"
		ln -Fs "$PWD/$dotfile" $HOME
	fi
done

vimtmpdirs=(".vimswap" ".vimundo" ".vimbackup")
for vimtmpdir in $vimtmpdirs
do
	if [ ! -e "$HOME/.vim/$vimtmpdir" ]
	then
		echo "mkdir $HOME/.vim/$vimtmpdir"
		mkdir -p "$HOME/.vim/$vimtmpdir"
	fi
done

if [ -e tmux-powerline ] && [ -d tmux-powerline ];
then
	ln -Fs $PWD/tmux-powerline $HOME/.tmux-powerline
fi
