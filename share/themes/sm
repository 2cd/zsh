#!/bin/bash

# ------------------------[CONFIG]-------------------------

# SM_SMILEYS=1 => with smileys, using "[ಠ_ಠ]" & "[･‿･]"
# SM_SMILEYS=0 => without smileys, using "✘" & "✔︎"
SM_SMILEYS=1

# SM_CORNERS=1 => the prompt's corner aren't rounded: "╭"
# SM_CORNERS=0 => the prompt's corner are rounded: "╓"
SM_CORNERS=1

# SM_MULTILINES=1 => the prompt is displayed on 3 lines
# SM_MULTILINES=0 => the prompt is displayed on 2 lines
SM_MULTILINES=1

# -----------------------[SET PROMPT]----------------------

# 1. SET SMILEYS
set_smileys() {
    if [ "$SM_SMILEYS" -eq 1 ] ; then 
        smileys=("[ಠ_ಠ]" "[･‿･]");
    elif [ "$SM_SMILEYS" -eq 0 ] ; then
        smileys=(" ✘" " ✔︎");
    fi
}
set_smileys

# 2. SET CORNERS
set_corners () {
    if [ "$SM_CORNERS" -eq 1 ] ; then 
        corners=("╓" "╟" "╙");
    elif [ "$SM_CORNERS" -eq 0 ] ; then 
        corners=("╭" "├" "╰");
    fi
}
set_corners

set_multilines() {
    if [ "$SM_MULTILINES" -eq 1 ] ; then 
        sm_prompt='$SM_PREFIX $SM_USER $(git_prompt_info) $(git_prompt_status)
$SM_MIDFIX $SM_DIR
$SM_SUFFIX';
    elif [ "$SM_MULTILINES" -eq 0 ] ; then 
        sm_prompt='$SM_PREFIX $SM_USER $SM_DIR $(git_prompt_info) $(git_prompt_status)
$SM_SUFFIX';
    fi
} 
set_multilines

# display red user if sudo is enabeled
sudo_color() {
    if [ "$UID" -eq 0 ] ; then 
        echo "red"; 
    else 
        echo "blue"; 
    fi
}

# custom my prompt
return_code="%(?..%F{red}%? - )%F{default}";
SM_USER="%F{$(sudo_color)}%n%F{yellow}@%F{cyan}%m";
SM_DIR="%F{default}%~%F{default}";
SM_CLOCK="${return_code}%F{cyan}%D%F{yellow} / %F{blue}%T";
SM_PREFIX="%F{yellow}${corners[1]}─";
SM_MIDFIX="%F{yellow}${corners[2]}─";
SM_SUFFIX="%F{yellow}${corners[3]}──→%F{default} ";

# set new prompt
PROMPT="$sm_prompt";
RPROMPT="$SM_CLOCK";

# update vcs values
ZSH_THEME_GIT_PROMPT_PREFIX="%F{magenta}git:%F{default}";
ZSH_THEME_GIT_PROMPT_SUFFIX="";
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}${smileys[1]}%F{default}";
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}${smileys[2]}%F{default}";
ZSH_THEME_GIT_PROMPT_ADDED="%F{green}●%F{default} ";
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{yellow}◎%F{default} ";
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}○%F{default} ";
ZSH_THEME_GIT_PROMPT_RENAMED="%F{blue}‣%F{default} ";
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{magenta}✦%F{default} ";
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{magenta}✖%F{default} ";