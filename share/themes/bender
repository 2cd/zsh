if [[ $BENDER_THEME_STYLE == "mini" ]] ; then
  local user_host_jobs=
else
  local user_host_jobs='[ %F{white}%n%F{red} :: %F{yellow}%m%F{red} ]-( %F{white}%j%F{red} )-'
fi

  PROMPT='
%B%F{red}┌───=${user_host_jobs}[ %F{white}%~%F{red} ]$(git_prompt_info)
└──(%b%f '

ZSH_THEME_GIT_PROMPT_PREFIX="-( %F{blue}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{red} )"
