# vim:ft=zsh ts=2 sw=2 sts=2

function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo %%; fi
}

function prompt_virtualenv {
	[[ -n "$VIRTUAL_ENV" && -n $VIRTUAL_ENV_DISABLE_PROMPT ]] && echo -n "%{$fg_bold[green]%}(${VIRTUAL_ENV:t})%{$reset_color%} " || echo -n ""
}

local ret_status="%(?:%{$fg_bold[cyan]%}@:%{$fg_bold[red]%}@)"

PROMPT='[$(prompt_virtualenv)%(!.%{$fg_bold[red]%}.%{$fg_bold[cyan]%}%n${ret_status})%{$fg_bold[cyan]%}%m %{$fg[red]%}%1~%{$reset_color%}] %{$fg_bold[yellow]%}$(git_prompt_info)% %{$fg[magenta]%}$(prompt_char)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="\ue0a0 "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
