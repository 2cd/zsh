# A prompt that fills my needs.
#
# Clojure features:
#  - None yet.
# Python features:
#  - None yet.

CLJ_PROJ="λ "
PY_PROJ="⟳ "
JVA_PROJ=" ☕"
JS_PROJ=" ⬡"
UN_PROJ=" ☯"
TF_SYMB="  ↳ "

ENL_EXEC_TIME_ELAPSED=5

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="-[%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="-[✔"
ZSH_THEME_GIT_PROMPT_ADDED="-[%{$fg[red]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="-[%{$fg[red]%}✚%{$reset_color%}"

function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%dd' $D
  [[ $H > 0 ]] && printf '%dh' $H
  [[ $M > 0 ]] && printf '%dm' $M
  printf '%ds' $S
}

preexec() {
  cmd_timestamp=`date +%s`
}

precmd() {
  local stop=`date +%s`
  local start=${cmd_timestamp:-$stop}
  let ENL_last_exec_duration=$stop-$start
  cmd_timestamp=''
}

function _time_display() {
  if [ $ENL_last_exec_duration -gt $ENL_EXEC_TIME_ELAPSED ]; then
    echo "◀%{$bg[yellow]%}%{$fg[black]%} $(displaytime $ENL_last_exec_duration) %{$reset_color%}▶"
  else
    echo ''
  fi
}

function _in_repo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

function _path_color() {
  # If we are in a git repo, color the path green
  if $(_in_repo); then
    echo "%{%F{green}%}ᴳ"
  else
    echo ' '
  fi
}

function _node_version() {
  # If we are in a git repo
  if $(_in_repo); then
    # And we see a project.clj file.
    if $(find package.json >/dev/null 2>&1); then
      echo "" $(node --version)
    else
      echo ''
    fi
  else
    echo ''
  fi
}

function _clj_version() {
  # If we are in a git repo
  if $(_in_repo); then
    # And we see a project.clj file.
    if $(find project.clj >/dev/null 2>&1); then
      echo "" $(cat project.clj | grep org.clojure/clojure\ | awk '{ print $3 }' | sed s/\"//g | sed s/]//g)
      #echo "" $(cat project.clj | grep org.clojure/clojure\ | awk '{ print $3 }' | sed s/[][\"\)]//g )
    else
      echo ''
    fi
  else
    echo ''
  fi
}

function _py_version() {
  # If we are in a git repo
  if $(_in_repo); then
    # And we see a project.clj file.
    if $(find *.py >/dev/null 2>&1); then
      echo "" $(python -c 'import sys; print(sys.version_info[:])' | sed s/\(//g | sed s/,\ /./g | sed s/\)//g)
    else
      echo ''
    fi
  else
    echo ''
  fi
}

function _js_info() {
  # If lein is installed, show lambda.
  if $(type nvm >/dev/null 2>&1); then
    echo "%{$fg[yellow]%}$JS_PROJ$(_node_version)%{$reset_color%}"
  else
    echo ''
  fi
}

function _vi_mode() {
  NORMAL_MODE="%{$fg[red]%}"
  echo "${${KEYMAP/vicmd/$NORMAL_MODE}/(main|viins)/}"
}

function _create_rprompt() {
  OPENSTR='[ '
  CLJSTR=''
  PYSTR=''
  CLOSESTR=']'

  # If lein is installed, show lambda.
  if $(type lein >/dev/null 2>&1); then
    #CLJSTR="%{$fg[yellow]%}$CLJ_PROJ$(_clj_version)%{$reset_color%}"
    CLJSTR="%{$fg[yellow]%}$CLJ_PROJ%{$reset_color%}"
  fi

  # If python is installed, show snake.
  if $(type python >/dev/null 2>&1); then
    #PYSTR="%{$fg[green]%}$PY_PROJ$(_py_version)%{$reset_color%}"
    PYSTR="%{$fg[green]%}$PY_PROJ%{$reset_color%}"
  fi

  (){ print -l "$*" } $OPENSTR$CLJSTR$PYSTR$CLOSESTR
}

PROMPT=$'
%{%{$fg[white]%}$(_vi_mode)$UN_PROJ%{$reset_color%} %{$fg[yellow]%}%1~%{$reset_color%} $(git_prompt_info) $(_time_display)\n%}%{$fg[cyan]%}$TF_SYMB%{$reset_color%}'

RPROMPT="$(_create_rprompt)"

export LC_CTYPE=en_US.UTF-8
