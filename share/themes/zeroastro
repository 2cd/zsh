########
#
# Zeroastro ZSH Theme for Oh My ZSH
#
# Author: Zeroastro
# https://github.com/zeroastro/zeroastro-zsh-theme
#
########

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi

# Prompt
PROMPT='%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}@%{$fg[red]%}%m%{$reset_color%}: %{$fg_bold[white]%}%B%~%b%{$reset_color%} $(git_prompt_info)%(!.#.$) '
RPROMPT='[%*]'

# Git Branch
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg_no_bold[yellow]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%{$fg_bold[blue]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗"
