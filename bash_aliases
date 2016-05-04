#bash_aliases

# less.sh
if [ -f /usr/local/share/vim/vim74/macros/less.sh ]; then
    alias less.sh='/usr/local/share/vim/vim74/macros/less.sh'
fi
if [ -f /usr/share/vim/vim74/macros/less.sh ]; then
    alias less.sh='/usr/share/vim/vim74/macros/less.sh'
fi

# ctags
alias ctags='ctags -f .tags'
