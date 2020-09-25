#
# Requires a nerdfont compatible font to display properly
#
# https://github.com/ryanoasis/nerd-fonts
#
#
function last_two_dir {
  # if we're at ~/ just display ~
  if [ $PWD = $HOME ]; then
    echo '%c'
  # display cwd and parent directory
  else
    echo '%2d'
  fi
}

function display_git {
  if [ $(git_current_branch) ]; then
    echo " {$(git_current_branch)}"
  fi
}

local cwd_color=214
local git_branch_color=001
local arrow_color=082
local arrow=''

# add indicator for when inside vim spawned shell
if [ $VIMRUNTIME ]; then
  arrow_color=196
  arrow=' '
fi

PROMPT='%{$FG[$cwd_color]%}$(last_two_dir)%{$FG[$git_branch_color]%}$(display_git) \
%{$FG[$arrow_color]%}$arrow%{$reset_color%} '

RPROMPT='$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"