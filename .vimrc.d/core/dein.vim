let s:dein_dir = expand('~/.vim/dein')
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

    let s:toml_dir = expand('~/.vimrc.d/plugin')
    let s:eagr_toml = s:toml_dir . '/plugins.eagr.toml'
    let s:lazy_toml = s:toml_dir . '/plugins.lazy.toml'

    call dein#load_toml(s:eagr_toml, { 'lazy': 0 })
    "call dein#load_toml(s:lazy_toml, { 'lazy': 1 })

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax enable
