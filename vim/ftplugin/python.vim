setlocal fileencoding=utf-8
setlocal autoindent
setlocal textwidth=80
"setlocal smartindent smartよりcindentの方が厳密らしい
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal tabstop=4          " タブの幅
setlocal expandtab          " タブをスペースに置換
setlocal shiftwidth=4       " インデント幅
setlocal softtabstop=4      " <tab>, <BS>時の幅
setlocal smarttab           " 行頭で<TAB>した時にshiftwidthでインデント
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
