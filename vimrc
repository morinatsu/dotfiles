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
set encoding=utf-8
set fileencodings=iso-2022-jp,sjis,utf-8,euc-jp
syntax on

" for neobundle
set nocompatible
filetype off

" patogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt

if has('vim_starting')
    if has("win32") || has("win64")
        set runtimepath+=$HOME/vimfiles/neobundle.vim.git
        call neobundle#rc(expand('$HOME/vimfiles/bundle'))
    else
        set runtimepath+=$HOME/.vim/neobundle.vim.git
        call neobundle#rc(expand('~/.bundle'))
    endif
endif

NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'
NeoBundle 'git://github.com/nvie/vim-pep8.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
NeoBundle "git://github.com/thinca/vim-ref.git"
NeoBundle "git://github.com/nathanaelkane/vim-indent-guides.git"

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

" neocomplcache
let g:neocomplcache_enable_at_startup = 1

" for project.vim
:let g:proj_flags = "imstc"
:nmap <silent> <Leader>P <Plug>ToggleProject
:nmap <silent> <Leader>p :Project<CR>
autocmd BufAdd .vimprojects silent! %foldopen!

" for vim-indent-guides
let g:indent_guides_enable_on_vim_startop = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
