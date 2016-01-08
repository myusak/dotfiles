scriptencoding utf8
set nocompatible

set term=screen-256color

set guioptions-=M

syntax on

set number
set nowrap

set cursorline

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

set spelllang=en,cjk

" vim reloads files when the files are changed
set autoread

set hidden

set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent
set smartindent

set colorcolumn=121

augroup vimrc
autocmd! FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

augroup vimrc
autocmd! FileType sh setlocal noexpandtab
augroup END

" set filetype markdown when the file extension is .md
au BufRead, BufNewFile *.md set filetype=markdown

set list
set listchars=tab:=-,trail:-

set showtabline=2
set showcmd
set laststatus=2
set noshowmode

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
NeoBundle 'dannyob/quickfixstatus'

" Unite and Unite Sources
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-build'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'sgur/unite-qf'
NeoBundle 'tsukkee/unite-tag.git'
NeoBundle 'osyo-manga/unite-quickrun_config.git'

" Completion
NeoBundle 'Shougo/neocomplete.git'
NeoBundle 'osyo-manga/vim-marching'
NeoBundle 'osyo-manga/vim-snowdrop'

" vimshell
NeoBundle 'Shougo/vimshell.git'

" markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" git
NeoBundle 'tpope/vim-fugitive'

" syntax
NeoBundle 'derekwyatt/vim-scala'

" doxygen plugin
NeoBundle 'vim-scripts/DoxygenToolkit.vim'

" colorscheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'tomasr/molokai'

" appearance
NeoBundle 'itchyny/lightline.vim'

call neobundle#end()

filetype plugin on
filetype indent on

NeoBundleCheck

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

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
    "let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    "let g:neocomplete#max_list = 30
    let g:neocomplete#skip_auto_completion_time = ""

    let g:neocomplete#sources#dictionary#dictionaries = {
    \   'default'  : '',
    \   'vimshell' : $HOME . '/.vim/.vimshell_hist',
    \   'scheme'   : $HOME . '/.vim/.gosh_completions'
    \}

    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()

    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction

    inoremap <expr><Tab> pumvisible() ? "\<Down>" : "\<Tab>"
    inoremap <expr><S-Tab> pumvisible() ? "\<up>" : "\<S-Tab>"
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif

    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
endfunction
unlet s:hooks

" marching
let s:hooks = neobundle#get_hooks("vim-marching")
function! s:hooks.on_post_source(bundle)
    let g:marching_clang_command = "clang"

    let g:marching#clang_command#options = {
    \   "cpp" : "-std=c++1y"
    \}

    let g:marching_include_paths = [
    \   "/Library/Developer/CommandLineTools/usr/include/c++",
    \   "/usr/local/include",
    \   "/usr/include",
    \]

    imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)

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

" snowdrop
let s:hooks = neobundle#get_hooks("vim-snowdrop")
function! s:hooks.on_post_source(bundle)
    let g:snowdrop#libclang_directory = "/Library/Developer/CommandLineTools/usr/lib"

    let g:snowdrop#include_paths = {
    \   "cpp": [
    \       "/Library/Developer/CommandLineTools/usr/include/c++",
    \       "/usr/local/include",
    \       "/usr/include",
    \   ]
    \}

    let g:snowdrop#command_options = {
    \   "cpp" : "-std=c++1y",
    \}
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
    \   "exec" : "%c %o %s -o %s:p:r",
    \   "cmdopt" : "-Wall -std=c++1y",
    \ },
    \ "cpp/watchdogs_checker" : {
    \   "type"   : "watchdogs_checker/clang++",
    \   "cmdopt" : "-Wall -std=c++1y -I . -I %:p:h",
    \ },
    \ "watchdogs_checker/_" : {
    \   "outputter/quickfix/open_cmd" : "",
    \ },
    \ "watchdogs_checker/clang++" : {
    \   "command" : "clang++",
    \   "exec"    : "%c %o -fsyntax-only %s:p",
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

let s:hooks = neobundle#get_hooks("vimfiler.vim")
function! s:hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
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

noremap Q <Nop>
noremap ZZ <Nop>
noremap ZQ <Nop>

" move by displayed line
noremap j gj
noremap k gk

nnoremap <silent> <C-l> :nohlsearch<CR>

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

function! s:cpp()
    if has("mac")
        setlocal path+=/Library/Developer/CommandLineTools/usr/bin/../include/c++/v1,/usr/local/include,/Library/Developer/CommandLineTools/usr/bin/../lib/clang/6.0/include,/Library/Developer/CommandLineTools/usr/include,/usr/include,/System/Library/Frameworks,/Library/Frameworks 
    endif
endfunction

augroup vimrc-cpp
    autocmd!
    autocmd FileType cpp call s:cpp()
augroup END

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
colorscheme molokai
