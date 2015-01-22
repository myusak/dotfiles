scriptencoding utf8

set nocompatible

syntax on

colorscheme koehler

set number
set nowrap

set cursorline

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

" vim reloads files when the files are changed
set autoread

set hidden

set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent
set smartindent

augroup vimrc
autocmd! FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" set filetype markdown when the file extension is .md
au BufRead, BufNewFile *.md set filetype=markdown

set list
set listchars=tab:=-,trail:-

set showcmd
set laststatus=2
set noshowmode

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

let g:Powerline_symbols = 'fancy'

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

set undodir=~/.vimundo

" enable erase, concat lines, indent delete with backspace key
set backspace=start,eol,indent

" command completion
set wildmenu wildmode=list:full

set matchpairs+=<:>

set updatetime=200

" Note: skip initialization for vim-tiny or vim-small
if !1 | finish | endif

let s:neobundle_plugins_dir = expand("~/.vim/bundle")

if !executable("git")
    echo "git not found. abort."
    finish
endif

""
" install neobundle
"
if !isdirectory(s:neobundle_plugins_dir . "/neobundle.vim")
    echo "neobundle not found."

    function! s:install_neobundle()
        if input("install neobundle.vim? [Y/N]: ") == "Y"
            if !isdirectory(s:neobundle_plugins_dir)
                call mkdir(s:neobundle_plugins_dir, "p")
            endif

            execute "!git clone git://github.com/Shougo/neobundle.vim "
                        \ . s:neobundle_plugins_dir . "/neobundle.vim"
            echo "neobundle installed. please restart."
        else
            echo "canceled."
        endif
    endfunction

    augroup install-neobundle
        autocmd!
        autocmd VimEnter * call s:install_neobundle()
    augroup END
    finish
endif

if has('vim_starting')
    execute "set runtimepath+=" . s:neobundle_plugins_dir . "/neobundle.vim"
endif

call neobundle#begin(s:neobundle_plugins_dir)

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }

" QuickRun
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'jceb/vim-hier'

" Unite and Unite Sources
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-build'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'sgur/unite-qf'
NeoBundle 'tsukkee/unite-tag.git'
NeoBundle 'osyo-manga/unite-quickrun_config.git'

" Completion
NeoBundle 'Shougo/neocomplete.git'
NeoBundle 'osyo-manga/vim-marching'

" vimshell
NeoBundle 'Shougo/vimshell.git'

" markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" lldb
"NeoBundle 'gilligan/vim-lldb'

" powerline
NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline.git'

call neobundle#end()

filetype plugin on
filetype indent on

NeoBundleCheck

" neomru
let s:hooks = neobundle#get_hooks("neomru.vim")
function! s:hooks.on_source(bundle)
    let g:neomru#time_format = "(%Y/%m/%d %H:%M:%S) "
endfunction
unlet s:hooks

" neocomplete
let s:hooks = neobundle#get_hooks("neocomplete")
function! s:hooks.on_source(bundle)
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#max_list = 30
    let g:neocomplete#skip_auto_completion_time = ""
endfunction
unlet s:hooks

" marching
let s:hooks = neobundle#get_hooks("vim-marching")
function! s:hooks.on_post_source(bundle)
    let g:marching_clang_command = "clang"

    let g:marching#clang_command#options = {
    \ "cpp" : "-std=c++1y"
    \}

    let g:marching_include_paths = [
    \   "/usr/local/include",
    \   "/usr/include",
    \]

    if !neobundle#is_sourced("neocomplete.vim")
        return
    endif

    let g:marching_enable_neocomplete = 1

    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif

    let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
endfunction
unlet s:hooks

"" vimshell
let s:hooks = neobundle#get_hooks("vimshell")
function! s:hooks.on_source(bundle)
    let g:vimshell_prompt = "% "
    let g:vimshell_secondary_prompt = "> "
    let g:vimshell_user_prompt = 'getcwd()'
endfunction
unlet s:hooks

" quickrun
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
    let g:quickrun_config = {
    \ "_" : {
    \   "outputter" : "error",
    \   "outputter/error/success"     : "buffer",
    \   "outputter/error/error"       : "quickfix",
    \   "outputter/buffer/split"      : ":botright 8sp",
    \   "outputter/quickfix/open_cmd" : "copen",
    \   "runner" : "vimproc",
    \   "runner/vimproc/updatetime" : 500,
    \   "runner/vimproc/sleep" : 10,
    \ },
    \ "cpp" : {
    \   "type" : "cpp/clang",
    \   "cmdopt" : "-std=c++1y",
    \ },
    \ "cpp/clang" : {
    \   "command" : "clang++",
    \   "exec" : "%c %o %s -o %s:p:r ",
    \   "cmdopt" : "-Wall -std=c++1y",
    \ },
    \ "cpp/watchdogs_checker" : {
    \   "type" : "watchdogs_checker/clang++",
    \   "cmdopt" : "-Wall",
    \ },
    \ "watchdogs_checker/_" : {
    \   "outputter/quickfix/open_cmd" : "",
    \ },
    \ "watchdogs_checker/clang++" : {
    \ },
    \}

    call watchdogs#setup(g:quickrun_config)

    let s:hook = {
    \ "name" : "clear_quickfix",
    \ "kind" : "hook",
    \}
    
    function! s:hook.on_normalized(session, context)
        call setqflist([])
    endfunction

    call quickrun#module#register(s:hook, 1)
    unlet s:hook
endfunction
unlet s:hooks

let s:hooks = neobundle#get_hooks("vim-watchdogs")
function! s:hooks.on_source(bundle)
    let g:watchdogs_check_BufWritePost_enable = 1
endfunction
unlet s:hooks

let s:hooks = neobundle#get_hooks("powerline")
function! s:hooks.on_source(bundle)
endfunction
unlet s:hooks

call neobundle#call_hook("on_source")

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

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


""
" key mappings
"
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
noremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file_mru bookmark file<CR>
noremap <silent> [unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
noremap <silent> [unite]o :<C-u>Unite outline -no-quit<CR>
noremap <silent> [unite]t :<C-u>Unite -buffer-name=tabs tab<CR>
noremap <silent> [unite]r :<C-u>Unite -buffer-name=registers register<CR>
noremap <silent> [unite]m :<C-u>Unite -no-quit build<CR>

noremap [quickrun] <Nop>
nmap <Space>q [quickrun]
noremap <silent> [quickrun] :<C-u>QuickRun<CR>

inoremap <expr><Tab> pumvisible() ? "\<Down>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)

function! s:cpp()
    if has("mac")
        setlocal path+=/Library/Developer/CommandLineTools/usr/bin/../include/c++/v1,/usr/local/include,/Library/Developer/CommandLineTools/usr/bin/../lib/clang/6.0/include,/Library/Developer/CommandLineTools/usr/include,/usr/include,/System/Library/Frameworks,/Library/Frameworks 
    endif
endfunction

augroup vimrc-cpp
    autocmd!
    autocmd FileType cpp call s:cpp()
augroup END

