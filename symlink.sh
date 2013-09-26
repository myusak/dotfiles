#!/bin/sh
cd $(dirname $0)
for dotfile in .?*
do
	if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.DS_Store' ]
	then
		ln -s "$PWD/$dotfile" $HOME
	fi
done
