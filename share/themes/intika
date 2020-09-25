ZSH_THEME_GIT_PROMPT_PREFIX=" (%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[130] ✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ±%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%} ▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%} ▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✓%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ♥%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ♡%{$reset_color%}"

function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

# Line every return
# PROMPT='$FG[237]----------------------------------------------------------------------------------------%{$reset_color%}
#PROMPT='%{$fg[gray]%}[%T][%n@%m%{$reset_color%}:$FG[069]%~%{$reset_color%}%{$fg[gray]%}$(git_prompt_info)]$(prompt_char)%{$reset_color%} '

PROMPT='%{$fg[gray]%}[%T][%n@%m%{$reset_color%}:%c%{$reset_color%}%{$fg[gray]%}$(git_prompt_info)]$(prompt_char)%{$reset_color%} '

# %W instead of %D for us
#RPROMPT='$FG[059][%D %*]%(?,$FG[022][R-$?],$FG[130][R-$?])$FG[024][!%!]%{$reset_color%}'
RPROMPT='$FG[059][%~]$FG[059][%D/%*]%(?,$FG[022][R-$?],$FG[130][$?])$FG[024][!%!]%{$reset_color%}'
