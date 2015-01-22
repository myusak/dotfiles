#!/bin/zsh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ] && [ $dotfile != '.DS_Store' ]
    then
        ln -Fs "$PWD/$dotfile" $HOME
    fi
done

vimtmpdirs=(".vimswap" ".vimundo" ".vimbackup")
for vimtmpdir in $vimtmpdirs 
do
    if [ ! -e "$HOME/$vimtmpdir" ]
    then
        echo "$HOME/$vimtmpdir"
        mkdir -p "$HOME/$vimtmpdir"
    fi

done
