set nocompatible

syntax on

colorscheme desert

set number
set nowrap

set cursorline

set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

" vim reloads files when the files are changed
set autoread

set hidden

set tabstop=4 softtabstop=0 shiftwidth=4
set autoindent
set smartindent

set showcmd
set laststatus=2

" [filename][editor flag][RO][help][encoding][file format][current line/total]
set statusline=[%F]%m%r%h%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}[%l/%L]
set mouse=a
set textwidth=0
set formatoptions=q

set hlsearch

set swapfile
set directory=~/.vimswap

set clipboard=unnamed

set nobackup
set writebackup
set backupcopy=no
set backupdir=~/.vimbackup

" enable erase, concat lines, indent delete with backspace key
set backspace=start,eol,indent

" command completion
set wildmenu wildmode=list:full

" Note: skip initialization for vim-tiny or vim-small
if !1 | finish | endif

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundle 'Shougo/neocomplete.git'
NeoBundle 'osyo-manga/vim-marching'
NeoBundle 'osyo-manga/vim-reunions'

NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-build'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'sgur/unite-qf'
NeoBundle 'tsukkee/unite-tag.git'

NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }

NeoBundle 'supermomonga/projectlocal.vim'
NeoBundle 'thinca/vim-quickrun'

call neobundle#end()

filetype plugin on
filetype indent on

NeoBundleCheck

" neocomplcache
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#max_list = 30

inoremap <expr><Tab> pumvisible() ? "\<Down>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

let g:marching_clang_command = "clang"
let g:marching_clang_command_option = "-std=c++1y"

let g:marching_include_paths = [
			\	"/usr/local/include",
			\	"/usr/include",
			\]

let g:marching_enable_neocomplete = 1
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" オムニ補完時に補完ワードを挿入したくない場合
imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)

" キャッシュを削除してからオムニ補完を行う
imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)

" vimshell
let g:vimshell_prompt = "% "
let g:vimshell_secondary_prompt = "> "
let g:vimshell_user_prompt = 'getcwd()'

" unite-build
let g:unite_builder_make_command = "omake"

command! -nargs=? -complete=dir -bang CD call s:ChangeCurrentDir('<args>', '<bang>')
function s:ChangeCurrentDir(directory, bang)
	if a:directory == ''
		lcd %:p:h
	else
		execute 'lcd'. a:directory
	endif

	if a:bang == ''
		pwd
	endif
endfunction

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

nnoremap <Space>cd :<C-u>CD<CR>
nnoremap <C-l> :nohlsearch<CR>:UniteBuildClearHighlight<CR><C-l>

noremap Q <Nop>
noremap ZZ <Nop>
noremap ZQ <Nop>

" move by displayed line
noremap j gj
noremap k gk

nnoremap [unite] <Nop>
nmap <Space>u [unite]
noremap <silent> [unite]q :<C-u>Unite -no-quit qf<CR>
noremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
noremap <silent> [unite]c :<C-u>UniteWithBufferDir -buffer-name=files buffer bookmark file<CR>
noremap <silent> [unite]C :<C-u>Unite -buffer-name=files file_mru<CR>
noremap <silent> [unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
noremap <silent> [unite]o :<C-u>Unite outline -no-quit<CR>
noremap <silent> [unite]t :<C-u>Unite -buffer-name=tabs tab<CR>
noremap <silent> [unite]r :<C-u>Unite -buffer-name=registers register<CR>

noremap <silent> [unite]m :<C-u>Unite -no-quit build<CR>

noremap [quickrun] <Nop>
nmap <Space>q [quickrun]
noremap <silent> [quickrun] :<C-u>QuickRun<CR>

let g:neomru#time_format = "(%Y/%m/%d %H:%M:%S) "

