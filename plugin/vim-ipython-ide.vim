func! FocusMain()
    echo exists('g:vide_main_buf') || CreateAndAttach()  
    " Second clause will only be evaluated if var is not set
    if g:vide_main_buf != bufnr('%')
        let g:vide_focus_buf = bufnr('%')
        execute 'sbuffer '. g:vide_main_buf
    else
        wincmd p
        " execute 'sbuffer '. g:vide_focus_buf
    endif
endfunc

func! InitBufList()
    if !exists('g:vide_buf_list') 
        let g:vide_buf_list = []
    endif
    return 1
endfunc

func! CreateAndAttach()
    let g:vide_main_buf = term_start('bash --login')
    call InitBufList()
    let g:vide_buf_list =  add(g:vide_buf_list, g:vide_main_buf)
endfunc


func! MakeBufferMainVideBuf()
    if &buftype ==# 'terminal'
        let g:vide_main_buf = bufnr('%')
        if InitBufList() && index(g:vide_buf_list, g:vide_main_buf) < 0
            let g:vide_buf_list =  add(g:vide_buf_list, g:vide_main_buf)
        endif
    endif
endfunc


" func AddCpaste(text)
"     return "%cpaste \<c-q>\<c-j>" . a:text . "\<c-q>\<c-j>--\<c-q>\<c-j>\n"
" endfunction

func! SendToTerminal(bufnr, text)
    call term_sendkeys(a:bufnr, a:text)
    " call term_wait(a:bufnr)
    " call term_scrape(a:bufnr, ".")
endfunc

func! CPasteMain() range
    let lines = getline(a:firstline, a:lastline)
    let text =  join(lines, "\<c-q>\<c-j>") . "\n"
    echo 'hi'
    call SendToTerminal(g:vide_main_buf, text)
endfunc


noremap <leader>df :call FocusMain()<cr>
noremap <leader>dc :call CreateAndAttach()<cr>
noremap <leader>dp :call CPasteMain()<cr> 
noremap <leader>dm :call MakeBufferMainVideBuf()<cr> 



"  ==== Settings to make terminal window automatically update when losing focus
" Switch to normal mode when entering terminal window
augroup VideTerminal
    autocmd!
     autocmd BufEnter * if &buftype ==# 'terminal' && exists('g:vide_buf_list') && index(g:vide_buf_list, bufnr('%')) >= 0  | call feedkeys("\<C-W>N")  | endif
     " Switch back to terminal mode when exiting
     autocmd BufLeave * if &buftype ==# 'terminal'  && exists('g:vide_buf_list') && index(g:vide_buf_list, bufnr('%')) >= 0  | execute "silent! normal! i"  | endif
augroup END


