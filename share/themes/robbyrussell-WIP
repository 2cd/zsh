# Reimplements OMZ's work_in_progress to customize the echo
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "[WIP!!] "
  fi
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
local git_branch='$(git_prompt_info)%{$reset_color%}'
local git_wip='%{$fg[red]%}$(work_in_progress)%{$reset_color%}'

PROMPT="${ret_status} %{$fg[cyan]%}%c%{$reset_color%} ${git_branch}${git_wip}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
