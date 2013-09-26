set nocompatible

syntax on

set number
set nowrap

set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

set autoread

set tabstop=4 softtabstop=0 shiftwidth=4
set autoindent
set smartindent
set showcmd
set laststatus=2
set statusline=%F%r%h%=
set mouse=a
set textwidth=0
set formatoptions=q

set hlsearch
set backup
set backupdir=~/.vimbackup

set swapfile
set directory=~/.vimswap

set clipboard=unnamed

colorscheme evening


if has('win32') || has('win64')
	set viminfo+=n~/.vim/.viminfo
endif

" バックアップを取らない？
set nobackup
set writebackup
set backupcopy=no

" backspace での消去、行連結、インデント削除を有効化
set backspace=start,eol,indent

" コマンド補完
set wildmenu wildmode=list:full

filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache'
NeoBundle 'git://github.com/Shougo/vimproc'
NeoBundle 'git://github.com/Shougo/vimfiler'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'sgur/unite-qf'
NeoBundle 'Shougo/unite-build'


filetype plugin on
filetype indent on


" 起動時に neocomplcache を起動
let g:neocomplcache_enable_at_startup = 1
" スマートケース検索
let g:neocomplcache_enable_smart_case = 1
" ポップアップメニューの最大個数
let g:neocomplcache_max_list = 40

" タブキーでの移動
inoremap <expr><Tab> pumvisible() ? "\<Down>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"

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

" 誤操作が困るキーの無効化
noremap Q <Nop>
noremap ZZ <Nop>
noremap ZQ <Nop>

" 表示行単位で移動する
noremap j gj
noremap k gk

nnoremap [unite] <Nop>
nmap <Space>u [unite]
noremap <silent> [unite]f :<C-u>UniteWithCurrentDir -buffer-name=files file<CR>
noremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
noremap <silent> [unite]C :<C-u>UniteWithCurrentDir -buffer-name=files file_mru file -vertical -winwidth=30<CR>
noremap <silent> [unite]b :<C-u>Unite buffer<CR>
noremap <silent> [unite]o :<C-u>Unite outline -no-quit -vertical -winwidth=30<CR>

noremap [quickrun] <Nop>
nmap <Space>q [quickrun]

noremap [vimfiler] <Nop>
nmap <Space>v [vimfiler]
noremap <silent> [vimfiler]c :<C-u>VimFilerCurrentDir<CR>
noremap <silent> [vimfiler]e :<C-u>VimFilerExplorer<CR>


let g:unite_source_menu_menus = {
\	"shortcut" : {
\		"description" : "frequently used command",
\		"command_candidates" : [
\			["unite-file_mru", "Unite file_mru"],
\			["change color scheme with auto preview", "Unite -auto-preview colorscheme"],
\			["unite-output:message", "Unite output:message"],
\		],
\	},
\}

" 挿入モードを抜けた時に IME を off
map <silent> <ESC> <ESC>:set imdisable<CR>


