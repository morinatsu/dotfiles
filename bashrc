# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias bagend='ssh bagend@bagend.sakura.ne.jp'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# setup pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi
# virtualenvwrapper
export VIRTUALENV_USE_DISTRIBUTE=true
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi

# google app engine
if [ -d ~/google_appengine ]; then
    PATH=$PATH:~/google_appengine
    export PATH
fi

# remake vimrc
if [ -f ~/.vimrc ]; then
    rm ~/.vimrc
    ln -s ~/dotfiles/vim/vimrc ~/.vimrc
fi

# pythonz
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

# set tmux to byobu-backend
export BYOBU_BACKEND=tmux

# powerline
export PATH=$PATH:~/.local/bin
if [ -d "/usr/local/lib/python2.7/dist-packages/powerline/" ]; then
    POWERLINE_ROOT="/usr/local/lib/python2.7/dist-packages/powerline/"
fi
if [ -d "/usr/local/lib/python3.5/dist-packages/powerline/" ]; then
    POWERLINE_ROOT="/usr/local/lib/python3.5/dist-packages/powerline/"
fi
if [ -d "$HOME/.local/lib/python3.5/site-packages/powerline/" ]; then
    POWERLINE_ROOT="$HOME/.local/lib/python3.5/site-packages/powerline/"
fi

if [ -d "$POWERLINE_ROOT" ]; then
#    if [ -e $HOME/.local/bin/powerline-daemon ]; then
#	$HOME/.local/bin/powerline-daemon -q
#    else
#	if [ -e /usr/local/bin/powerline-daemon ]; then
#	    /usr/local/bin/powerline-daemon -q
#	fi
#    fi
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . $POWERLINE_ROOT/bindings/bash/powerline.sh
fi

# for get-git-ignore
function _peco_ggi_list () {
    lang=$(get-git-ignore | peco)

    if [ -n "$lang" ]; then
        get-git-ignore --lang=$lang
    fi
}
alias ggi=_peco_ggi_list

function peco-hist() {
    time_column=`echo $HISTTIMEFORMAT | awk '{printf("%s",NF)}'`
    column=`expr $time_column + 3`
    cmd=`history | tac | peco | sed -e 's/^ //' | sed -e 's/ +/ /g' | cut -d " " -f $column-`
    history -s "$cmd"
    eval $cmd
}

if ls --color=auto --show-control-char >/dev/null 2>&1;then
  alias ls='ls --color=auto --show-control-char'
  alias la='ls -A --color=auto --show-control-char'
else
  alias ls='ls --color=auto'
  alias la='ls -A --color=auto'
fi
if [[ "$OSTYPE" =~ cygwin ]];then
  export CYGWIN="winsymlinks $CYGWIN"
fi

if [ -d "$HOME/node_modules/.bin" ]; then
  export PATH="$HOME/node_modules/.bin:$PATH"
fi

if [ -d "$HOME/.local/go" ]; then
  export GOPATH="$HOME/.local/go"
  export PATH="$HOME/.local/go/bin:$PATH"
fi

if [ -f "$HOME/.peco-anyenv/peco-anyenv.sh" ]; then
  source "$HOME/.peco-anyenv/peco-anyenv.sh"
fi

# $PATH operate
path_append ()  { path_remove $1; export PATH="$PATH:$1"; }
path_prepend () { path_remove $1; export PATH="$1:$PATH"; }
path_remove ()  { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`; }
