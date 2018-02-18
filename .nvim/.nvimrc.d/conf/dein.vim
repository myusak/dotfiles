let s:cache_dir = empty($XDG_CACHE_HOME) ? expand('~/.cache/') : $XDG_CACHE_HOME

let s:dein_dir = s:cache_dir . 'dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:dein_remote_repo_url = "git://github.com/Shougo/dein.vim"

function! s:install()
    if input("install dein.vim? [y/N]: ") == "y"
        if !isdirectory(s:dein_repo_dir)
            call mkdir(s:dein_repo_dir, "p")
        endif

        execute "!git clone " . s:dein_remote_repo_url . " " . s:dein_repo_dir
        echo "dein installed. please restart."
    else
        echo "canceled."
    endif
endfunction

" entry point
"
"
if !executable('git')
    echo 'git not found. abort'
    finish
endif

if !isdirectory(s:dein_repo_dir)
    echo "dein not found."

    augroup dein-install
        autocmd!
        autocmd VimEnter * call s:install()
    augroup END

    finish
endif

execute "set runtimepath+=" . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir = expand('~/.config/nvim/.nvimrc.d/plugins/')

    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})
    call dein#add('tomasr/molokai')

    call dein#load_toml(s:toml_dir . 'dein.toml',        { 'lazy': 0 })
    call dein#load_toml(s:toml_dir . 'dein_denite.toml', { 'lazy': 0 })

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax enable


" colorscheme setting
colorscheme molokai

highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE
highlight TablineSel ctermbg=NONE
highlight LineNr ctermbg=NONE
highlight CursorLineNr ctermbg=NONE

