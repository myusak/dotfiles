augroup vimrc_init
    autocmd!
    autocmd BufRead, BufNewFile *.md set filetype=markdown " set filetype markdown when the file extension is .md

    autocmd FileType latex call s:latex()
    autocmd FileType cpp call s:cpp()
    autocmd FileType ruby call s:ruby()
    autocmd FileType sh,zsh call s:shellscript()
    autocmd FileType rst,markdown,gitrebase,gitcommit,vcs-commit,hybrid,text,help,tex set spell
augroup END

function! s:shellscript()
    setlocal noexpandtab
    setlocal nolist
endfunction

function! s:ruby()
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal softtabstop=2
endfunction

function! s:latex()
    let g:tex_flavor = "latex"
endfunction

function! s:cpp()
    setlocal path+=/usr/include,/usr/local/include

    if has("mac")
        setlocal path+=/Library/Developer/CommandLineTools/usr/include/c++/v1
    endif
endfunction

