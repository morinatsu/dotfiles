" 行末のスペースを自動的に削除する
" Version: 1.0
" Author: thinca <thinca+vim@gmail.com>
" License: VIM LICENSE

if exists('g:loaded_sweep_trail')
    finish
endif
let g:loaded_sweep_trail = 1

let s:save_cpo = &cpo
set cpo&vim

command! -bar SweepTrail call sweep_trail#sweep()

noremap <silent> <Plug>(sweep_trail) :<C-u>SweepTrail<CR>

if !hasmapto('<Plug>(sweep_trail)')
        \ && (!exists('g:sweep_trail_no_default_key_mappings')
        \   || !g:sweep_trail_no_default_key_mappings)
    silent! map <unique> <Leader>sw <Plug>(sweep_trail)
endif

augroup plugin-sweep_trail
    autocmd!
    autocmd BufWritePre * call sweep_trail#auto_sweep()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
