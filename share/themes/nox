# nox theme

_collapsed_pwd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}

PROMPT='%{$fg[green]%}%n%{$reset_color%}@%m\
:[%{$fg[green]%}$(_collapsed_pwd)%{$reset_color%}]:'

RPROMPT='$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[green]%} +"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"

