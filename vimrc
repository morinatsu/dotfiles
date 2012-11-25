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
        set runtimepath+=$HOME/vimfiles/bundle/neobundle.vim/
        call neobundle#rc(expand('$HOME/vimfiles/bundle'))
    else
        set runtimepath+=$HOME/.vim/neobundle.vim.git
        call neobundle#rc(expand('~/.bundle'))
    endif
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \       'windows' : 'make -f make_mingw64.mak',
    \       'unix' : 'make -f make_unix.mak',
    \   }
    \ }
NeoBundle 'git://github.com/vim-jp/vital.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/vim-jp/vimdoc-ja.git'
NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
NeoBundle 'git://github.com/thinca/vim-guicolorscheme.git'

filetype plugin on
filetype indent on

" Installation check
if neobundle#exists_not_installed_bundles()
    echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
    echomsg 'Please execute ":NeoBundleInstall" command.'
endif

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

" """neocomplcache"""
if has("win32") || has("win64")
"    let g:neocomplcache_snippets_dir = $HOME . '/vimfiles/snippets'
else
"    let g:neocomplcache_snippets_dir = $HOME . '/.vim/snippets'
endif

"Disable AutoComplPop.
let g:acp_enableAtStartup = 0
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

" Recommended key-mappings.

" For snippet_complete marker.
"if has('conceal')
"  set conceallevel=2 concealcursor=i
"endif

