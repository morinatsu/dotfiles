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

# --- for tiny-care-terminal ---
# List of accounts to read the last tweet from, comma separated
# The first in the list is read by the party parrot.
export TTC_BOTS='tinycarebot,selfcare_bot,magicrealismbot'

# Use this to have a different animal say a message in the big box.
export TTC_SAY_BOX="cat"

# List of folders to look into for `git` commits, comma separated.
export TTC_REPOS='~/dotfiles,~/projects'

# The max directory-depth to look for git repositories in
# the directories defined with `TTC_REPOS`. Note that the deeper
# the directory depth, the slower the results will be fetched.
export TTC_REPOS_DEPTH=2

# Location/zip code to check the weather for. Both 90210 and "San Francisco, CA"
# _should_ be ok (the zip code doesn't always work -- use a location
# first, if you can). It's using weather.service.msn.com behind the curtains.
export TTC_WEATHER='Tokyo'

# Set to false if you're an imperial savage. <3
export TTC_CELSIUS=true

# Unset this if you _don't_ want to use Twitter keys and want to
# use web scraping instead.
export TTC_APIKEYS=false
#
# Refresh the dashboard every 20 minutes.
export TTC_UPDATE_INTERVAL=20

# Twitter api keys
export TTC_CONSUMER_KEY='...'
export TTC_CONSUMER_SECRET='...'
export TTC_ACCESS_TOKEN='...'
export TTC_ACCESS_TOKEN_SECRET='...'
