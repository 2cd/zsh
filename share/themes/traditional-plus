# traditional-plus theme.  like a traditional prompt (no fancy colours) but with git info, single line.

if [[ $UID -eq 0 ]]; then
    local prompt_char="#"
else
    local prompt_char="$"
fi

PROMPT='%n%{$reset_color%}@%m%{$reset_color%}:$(git_prompt_info)%{$reset_color%}%~${prompt_char}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=":"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%} %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"
