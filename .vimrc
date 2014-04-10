set nocompatible

syntax on

set number
set nowrap

set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

" vim reloads files when the files are changed
set autoread

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

set writebackup
set backupdir=~/.vimbackup

" enable erase, concat lines, indent delete with backspace key
set backspace=start,eol,indent

" command completion
set wildmenu wildmode=list:full

filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'sgur/unite-qf'
NeoBundle 'Shougo/unite-build'
NeoBundle 'tpope/vim-fugitive'

filetype plugin on
filetype indent on

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_max_list = 40

inoremap <expr><Tab> pumvisible() ? "\<Down>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"


" vimshell
let g:vimshell_prompt = "% "
let g:vimshell_secondary_prompt = "> "
let g:vimshell_user_prompt = 'getcwd()'

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

nnoremap <Space>cd :<C-u>CD<CR>
nnoremap <C-l> :nohlsearch<CR><C-l>

noremap Q <Nop>
noremap ZZ <Nop>
noremap ZQ <Nop>

" move by displayed line
noremap j gj
noremap k gk

nnoremap [unite] <Nop>
nmap <Space>u [unite]
noremap <silent> [unite]f :<C-u>UniteWithCurrentDir -buffer-name=files file<CR>
noremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
noremap <silent> [unite]C :<C-u>UniteWithCurrentDir -buffer-name=files file_mru file -vertical -winwidth=30<CR>
noremap <silent> [unite]b :<C-u>Unite buffer<CR>
noremap <silent> [unite]o :<C-u>Unite outline -no-quit -vertical -winwidth=30<CR>
noremap <silent> [unite]t :<C-u>Unite -buffer-name=tabs tab<CR>
noremap <silent> [unite]r :<C-u>Unite -buffer-name=registers register<CR>

function! HandleURI()
	let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
	echo s:uri
	if s:uri != ""
		exec "!open \"" . s:uri . "\""
	else
		echo "No URI found in line."
	endif
endfunction

map <Leader>w :call HandleURI()<CR>
