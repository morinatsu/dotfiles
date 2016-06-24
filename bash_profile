#########################################################################
#         .bash_profile: Personal initialisation file for bash          #
#########################################################################

# This script file is executed by bash(1) for login shells.  By default,
# it does nothing, as ~/.bashrc is already sourced by /etc/profile.
#
# [JNZ] Modified 23-Sep-2004
#
# Written by John Zaitseff and released into the public domain.

export PATH="/home/morinatsu/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

test -r ~/.bashrc && . ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
