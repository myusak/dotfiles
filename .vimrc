execute "set runtimepath+=" . expand('~/.vimrc.d')

source $VIMRUNTIME/macros/matchit.vim

runtime core/basic.vim
runtime core/autocommand.vim
runtime core/keymap.vim
runtime core/dein.vim
runtime core/colorscheme.vim

