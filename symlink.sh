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
    if [ ! -e "$HOME/.vim/$vimtmpdir" ]
    then
        echo "mkdir $HOME/.vim/$vimtmpdir"
        mkdir -p "$HOME/.vim/$vimtmpdir"
    fi

done
