# Chill zsh theme
# Created by PsychoPatate
# https://github.com/PsychoPatate

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

function path_prompt {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

function git_custom_prompt {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${cb}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

local ret_status="%(?:%{$fg[green]%}>:%{$fg[red]%}>%s)"

PROMPT='%{$fg[cyan]%}%p$(path_prompt) $(git_custom_prompt)${ret_status}%{$reset_color%} '
