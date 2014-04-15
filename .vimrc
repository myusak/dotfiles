set nocompatible

syntax on

colorscheme desert

set number
set nowrap

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

NeoBundle 'Shougo/neocomplete.git'
NeoBundle 'osyo-manga/vim-marching'
NeoBundle 'osyo-manga/vim-reunions'

NeoBundle 'Shougo/vimshell.git'

NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
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

NeoBundle 'thinca/vim-quickrun'

filetype plugin on
filetype indent on

" snowdrop
let g:snowdrop#libclang_directory = "/usr/lib/llvm-3.3/lib"
let g:snowdrop#command_optons = {
\	"cpp" : "-std=c++11"
\}

" neocomplcache
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete_max_list = 20

inoremap <expr><Tab> pumvisible() ? "\<Down>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"	let g:neocomplete#sources#omni#input_patterns = {}
"endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^.  \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

let g:marching_clang_command = "clang"
let g:marching_clang_command_option = "-std=c++11"

let g:marching_include_paths = [
			\	"/usr/local/include/",
			\	"/usr/include/",
			\]

let g:marching_enable_neocomplete = 1
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" 処理のタイミングを制御する
" 短いほうがより早く補完ウィンドウが表示される
set updatetime=100

" オムニ補完時に補完ワードを挿入したくない場合
imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)

" キャッシュを削除してからオムに補完を行う
imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)

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

function! s:cpp()
	setlocal path+=/usr/include/,/usr/local/include
	setlocal matchpairs += <:>
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
