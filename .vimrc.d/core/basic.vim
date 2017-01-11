scriptencoding utf8
filetype on
syntax on

set nocompatible
set number
set nowrap
set cursorline
set splitbelow
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
set spelllang=en,cjk
set autoread " enable vim to reload a file when the file is modified
set hidden
set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent
set smartindent
set colorcolumn=121
set showtabline=2
set showcmd
set laststatus=2
set noshowmode
set list
set listchars=tab:=-
set mouse=a
set textwidth=0
set formatoptions=q
set hlsearch
set swapfile
set directory=~/.vim/.vimswap
set clipboard=unnamed
set nobackup
set writebackup
set backupcopy=no
set backupdir=~/.vim/.vimbackup
set undodir=~/.vim/.vimundo
set backspace=start,eol,indent " enable to erase/concat lines/delete with backspace key
set wildmenu wildmode=list:full " command completion
set matchpairs+=<:>
set updatetime=200

highlight MatchParen ctermfg=white ctermbg=red
highlight SpellBad cterm=bold,italic
