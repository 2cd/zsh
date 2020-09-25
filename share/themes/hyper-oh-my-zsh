# Promp text information
PROMPT='%{$fg_bold[cyan]%}%c $(git_prompt_info)%{$reset_color%}$(_git_time_since_commit)$(git_prompt_status)${_return_status}➜ '
local _return_status="%{$fg_bold[red]%}%(?..⍉ )%{$reset_color%}"

# Git Status Indicators configuration
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "
ZSH_THEME_GIT_PROMPT_CLEAN=" "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}✓ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}△ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➜ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[blue]%}▲ "

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[white]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[white]%}"

# Get the time of the last commit on git 
# Used in the prompt variable
function _git_time_since_commit() {
  # Only proceed if there is actually a commit.
  # if not, don't do anything
  if git log -1 > /dev/null 2>&1; then
    # Get the last commit time information.
    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals of minute and hours
    minutes=$((seconds_since_last_commit / 60))
    hours=$((seconds_since_last_commit/3600))

    # Sub-hours and sub-minutes if applicable
    days=$((seconds_since_last_commit / 86400))
    sub_hours=$((hours % 24))
    sub_minutes=$((minutes % 60))

    if [ $hours -gt 24 ]; then
      commit_age="${days}d "
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m "
    else
      commit_age="${minutes}m "
    fi
    if [[ -n $(git status -s 2> /dev/null) ]]; then
      if [ "$hours" -gt 4 ]; then
        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
      elif [ "$minutes" -gt 30 ]; then
        COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
      else
        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
      fi
    else
      COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
    fi

    echo "$COLOR$commit_age%{$reset_color%}"
  fi
}
