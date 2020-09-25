#
# Oh-My-VIA ZSH Theme
# Fork from the historical VIA Centrale Réseaux ZSH Theme
#
# This work is free.  You can redistribute it and/or modify it under the terms of
# the Do What The Fuck You Want To Public License, Version 2, as published by Sam
# Hocevar.  See  the COPYING file  or  http://www.wtfpl.net/  for  more  details.
#

#################################################################################
# Source functions
#################################################################################

OHMYVIA_INSTALLATION_PATH="$(dirname "$0")"

source $OHMYVIA_INSTALLATION_PATH/functions/prompt_utils.zsh
source $OHMYVIA_INSTALLATION_PATH/functions/utils.zsh
source $OHMYVIA_INSTALLATION_PATH/functions/vcs_themes.zsh
source $OHMYVIA_INSTALLATION_PATH/functions/vcs_utils.zsh

#################################################################################
# Variables initialization
#################################################################################

## Properties

set_default OHMYVIA_CONTEXT_HOSTNAME         "full"
set_default OHMYVIA_CONTEXT_HOSTNAME_COLOR   "%B%F{white}"
set_default OHMYVIA_CONTEXT_SEPARATOR_COLOR  "%B%F{yellow}"
set_default OHMYVIA_CONTEXT_ROOT_COLOR       "%B%F{blue}"
set_default OHMYVIA_CONTEXT_USER_COLOR       "%B%F{red}"

set_default OHMYVIA_DIR_COLOR                "%B%F{green}"
set_default OHMYVIA_DIR_SIZE                 "0"

set_default OHMYVIA_STATUS_OK_COLOR          "%B%F{yellow}"
set_default OHMYVIA_STATUS_ERROR_COLOR       "%B%F{red}"

set_default OHMYVIA_TIME_COLOR               "%B%F{cyan}"
set_default OHMYVIA_TIME_FORMAT              "%D{%H:%M}"

set_default OHMYVIA_VCS_COLOR_UNSTAGED       "red"
set_default OHMYVIA_VCS_COLOR_STAGE          "yellow"
set_default OHMYVIA_VCS_COLOR_UNTRACKED      "blue"
set_default OHMYVIA_VCS_COLOR_STASH          "cyan"
set_default OHMYVIA_VCS_COLOR_CLEAN          "green"
set_default OHMYVIA_VCS_THEME                "default"


#################################################################################
# Build left & right prompts
#################################################################################

OHMYVIA_EOL="%(?.$OHMYVIA_STATUS_OK_COLOR.$OHMYVIA_STATUS_ERROR_COLOR)%#%f%b"

PROMPT="$(prompt_time) $(prompt_context) $(prompt_dir)${OHMYVIA_EOL} "

# Display vcs info
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
autoload -Uz vcs_info

zstyle ':vcs_info:*' max-exports 1		# vcs_info only sets vcs_info_msg_0_
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true	# enable %c and %u sequences usage

zstyle ':vcs_info:*' unstagedstr $OHMYVIA_VCS_COLOR_UNSTAGED
zstyle ':vcs_info:*' stagedstr   $OHMYVIA_VCS_COLOR_STAGED

zstyle ':vcs_info:git*+set-message:*' hooks misc-init git-stash git-untracked

# Load VCS theme
eval +vi-theme-$OHMYVIA_VCS_THEME

zstyle ':vcs_info:*' formats       " $OHMYVIA_VCS_PROMPT_NORMAL"
zstyle ':vcs_info:*' actionformats " $OHMYVIA_VCS_PROMPT_ACTION"

# Override precmd to update vcs_info_msg_0_ before prompt.
# See http://zsh.sourceforge.net/Doc/Release/Functions.html#Hook-Functions
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

# vim: ft=zsh fenc=utf-8
