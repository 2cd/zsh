setopt prompt_subst

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE=''
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE='<'
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE='>'
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg[red]%}<>%{%F{14}%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED='%%'
ZSH_THEME_GIT_PROMPT_ADDED='+'
ZSH_THEME_GIT_PROMPT_MODIFIED='~'
ZSH_THEME_GIT_PROMPT_RENAMED='->'
ZSH_THEME_GIT_PROMPT_DELETED='-'
ZSH_THEME_GIT_PROMPT_STASHED='$'

function git_or_pwd() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch="$(git_current_branch)"
    if [[ -n "$branch" ]]; then
      branch_prompt="$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX"

      relative_dir="${$(pwd)#$(git rev-parse --show-toplevel)}"
      if [[ -n "$relative_dir" ]]; then
        relative_dir=":${relative_dir:1}"
      fi

      remote="$(git config branch.$branch.pushRemote)" || \
        remote="$(git config branch.$branch.remote)"
      if [[ -z "$remote" ]]; then
        echo "local$relative_dir|$branch_prompt%{%F{14}%}$(git_prompt_status)%{$reset_color%}"
	return
      fi

      url="$(git remote get-url --push $remote \
        | perl -pe 's;^(git@|git://|https?://)?(.*?)(\.git)?$/;\2' \
	| sed -e 's|:|/|')" || \
        url='git url not found'  # This has never happened yet
      echo "%{$fg[blue]%}$url%{$reset_color%}$relative_dir|$branch_prompt%{%F{14}%}$(git_remote_status)$(git_prompt_status)%{$reset_color%}"
      return
    fi
  fi
  echo '%~'
  return
}

PROMPT='$(git_or_pwd)$ '

# vim: set filetype=zsh:
