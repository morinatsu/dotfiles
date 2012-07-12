set paste
set expandtab
set textwidth=0
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set backspace=indent,eol,start
set incsearch
set ignorecase
set ruler
set wildmenu
set commentstring=\ #\ %s
set foldlevel=0
set clipboard+=unnamed
set number
set laststatus=2
set statusline=%F,%r,L=%l,C=%c
if has("win32")
    set termencoding=sjis
endif
set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,utf-8,euc-jp
set nobackup
set foldcolumn=4
syntax on

" for neobundle
set nocompatible
filetype off

if has('vim_starting')
    if has("win32") || has("win64")
        set shellpipe=
        set runtimepath+=$HOME/vimfiles/neobundle.vim.git
        call neobundle#rc(expand('$HOME/vimfiles/bundle'))
    else
        set runtimepath+=$HOME/.vim/neobundle.vim.git
        call neobundle#rc(expand('~/.bundle'))
    endif
endif

NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/vim-jp/vital.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/vim-jp/vimdoc-ja.git'
"NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
"NeoBundle 'git://github.com/Shougo/neocomplcache-snippets-complete.git'
NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
"NeoBundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
"NeoBundle 'git://github.com/tpope/vim-surround.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
"NeoBundle 'git://github.com/mattn/benchvimrc-vim.git'

filetype plugin on
filetype indent on

function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
\        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)

" for project.vim
":let g:proj_flags = "imstc"
":nmap <silent> <Leader>P <Plug>ToggleProject
":nmap <silent> <Leader>p :Project<CR>
"autocmd BufAdd .vimprojects silent! %foldopen!

" for vim-indent-guides
"let g:indent_guides_enable_on_vim_startop = 1
"let g:indent_guides_color_change_percent = 30
"let g:indent_guides_guide_size = 1

" """neocomplcache"""
let g:neocomplcache_auto_completion_start_length = 4
if has("win32") || has("win64")
"    let g:neocomplcache_snippets_dir = $HOME . '/vimfiles/snippets'
else
"    let g:neocomplcache_snippets_dir = $HOME . '/.vim/snippets'
endif

"Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 10
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Plugin key-mappings.
"imap <C-CR>     <Plug>(neocomplcache_snippets_expand)
"smap <C-CR>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" For snippet_complete marker.
"if has('conceal')
"  set conceallevel=2 concealcursor=i
"endif

