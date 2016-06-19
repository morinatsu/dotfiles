setlocal fileencoding=utf-8
setlocal autoindent
setlocal textwidth=80
"setlocal smartindent smart$B$h$j(Bcindent$B$NJ}$,87L)$i$7$$(B
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal tabstop=4          " $B%?%V$NI}(B
setlocal expandtab          " $B%?%V$r%9%Z!<%9$KCV49(B
setlocal shiftwidth=4       " $B%$%s%G%s%HI}(B
setlocal softtabstop=4      " <tab>, <BS>$B;~$NI}(B
setlocal smarttab           " $B9TF,$G(B<TAB>$B$7$?;~$K(Bshiftwidth$B$G%$%s%G%s%H(B
setlocal colorcolumn=72

nmap <C-l> >>
nmap <C-h> <<
imap <C-l> <ESC>>>A
imap <C-l> <ESC><<A
imap <C-w> <ESC><C-w>

command! Python call s:Python()
nmap <F5> :Python<CR>

function! s:Python()
    :w
    :!python "%"
endfunction

command! PyChecker call s:PyChecker()
nmap <F4> :PyChecker<CR>

function! s:PyChecker()
    :w
    :!pychecker "%"
endfunction

autocmd FileType python call s:python_settings()
function! s:python_settings()
    autocmd BufWritePost <buffer> call Pep8()
endfunction
