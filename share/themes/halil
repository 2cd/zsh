# vim:ft=zsh ts=2 sw=2 sts=2

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
case $USER in
	root)
		echo "%{$fg_bold[yellow]%}%  ⚡ # %{$reset_color%} "
	;;
	*)
		echo " $ "
	;;
esac
} 
PROMPT="%{$fg_bold[green]%} %2~%{$reset_color%} ☪ %{$fg_bold[red]%}%*%{$reset_color%}
$(prompt_char)%{$reset_color%} "
RPROMPT='$(git_prompt_info)'
