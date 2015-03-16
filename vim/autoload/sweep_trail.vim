" 行末のスペースを自動的に削除する
" Version: 1.0
" Author: thinca <thinca+vim@gmail.com>
" License: VIM LICENSE

let s:save_cpo = &cpo
set cpo&vim

function! sweep_trail#sweep()
    %substitute/\s\+$//e
endfunction

if !exists('g:sweep_trail#enable')
    let g:sweep_trail#enable = 1
endif

function! sweep_trail#auto_sweep()
    if g:sweep_trail#enable
        call sweep_trail#sweep()
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
