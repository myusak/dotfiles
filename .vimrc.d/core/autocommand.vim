augroup vimrc_init
    autocmd!
    autocmd BufRead, BufNewFile *.md set filetype=markdown " set filetype markdown when the file extension is .md

    autocmd FileType latex call s:latex()
    autocmd FileType cpp call s:cpp()
    autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType sh,zsh setlocal noexpandtab
    autocmd FileType rst,markdown,gitrebase,gitcommit,vcs-commit,hybrid,text,help,tex set spell
augroup END

function! s:latex()
    let g:tex_flavor = "latex"
endfunction

function! s:cpp()
    setlocal path+=/usr/include,/usr/local/include

    if has("mac")
        setlocal path+=/Library/Developer/CommandLineTools/usr/include/c++/v1
    endif
endfunction

