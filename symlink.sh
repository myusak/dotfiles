#!/bin/zsh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ] && [ $dotfile != '.DS_Store' ] && [ $dotfile != '.config' ]
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

if [ ! -e "$HOME/.config" ]
then
    echo "mkdir $HOME/.config"
    mkdir -p $HOME/.config
fi

for conffile in $(cd $(dirname $0) && pwd)/.config/*
do
    echo "symlink from $conffile to $HOME/.config"
    ln -Fs $conffile $HOME/.config
done

