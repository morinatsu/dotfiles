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
autocmd FileType text setlocal textwidth=0

" for neobundle
set nocompatible
filetype off

if has('vim_starting')
    if has("win32") || has("win64")
        set shellpipe=
        set runtimepath+=$HOME/vimfiles/bundle/neobundle.vim/
    else
        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
endif
if has("win32") || has("win64")
    call neobundle#rc(expand('$HOME/vimfiles/bundle'))
else
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \       'windows' : 'make -f make_mingw64.mak',
    \       'unix' : 'make -f make_unix.mak',
    \   }
    \ }
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'thinca/vim-scouter'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'thinca/vim-guicolorscheme'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'tpope/vim-fugitive'

filetype plugin on
filetype indent on

" Installation check
NeoBundleCheck

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
" Prevent auto complete
let g:neocomplcache_enable_insert_char_pre = 1

" for snippets
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" for solarized
if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

" disable IME, when exit insert mode
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" for YankRing.vim
let g:yankring_history_file = '.yankring_history_file'
set clipboard+=unnamedplus,unnamed
nmap ,y :YRShow<CR>
