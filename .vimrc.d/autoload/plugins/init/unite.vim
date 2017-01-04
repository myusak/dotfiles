function! plugins#init#unite#hook_add() abort
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
    noremap <silent> [unite]z :<C-u>Unite spell_suggest<CR>

    let g:neomru#time_format = "(%Y/%m/%d %H:%M:%S) "
endfunction
