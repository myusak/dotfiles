function! s:cpp()
    setlocal path+=/usr/include,/usr/local/include

    if has("mac")
        setlocal path+=/Library/Developer/CommandLineTools/usr/include/c++/v1
    endif
endfunction

function! s:ruby()
    " ruby
    let g:rubycomplete_buffer_loading = 1
    let g:rubycomplete_classes_in_global = 1
    let g:rubycomplete_rails = 1

    " For ruby refactory
    if has('nvim')
      runtime! macros/matchit.vim
    else
      packadd! matchit
    endif
endfunction


""*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
augroup vimrc_init
    autocmd!
    autocmd BufRead, BufNewFile *.md set filetype=markdown " set filetype markdown when the file extension is .md
    autocmd BufRead, BufNewFile Vagrantfile set filetype=ruby

    autocmd FileType cpp call s:cpp()
    autocmd FileType latex let g:tex_flavor = 'latex'
    autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType sh,zsh setlocal noexpandtab
    autocmd FileType sh,zsh setlocal nolist
    autocmd FileType rst,markdown,gitrebase,gitcommit,vcs-commit,hybrid,text,help,tex set spell
augroup END


"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END


augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END


augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
augroup END


