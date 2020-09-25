#  Punctual, a Zsh prompt theme
#
#  by Danny (https://github.com/dannynimmo/punctual-zsh-theme)


#  Configuration
#
#  Set these variables in your .zshrc file
#  before including this theme file, e.g.:
#
#      PUNCTUAL_SHOW_HOSTNAME=false;
#      PUNCTUAL_CURRENT_DIR_COLOUR=yellow;

PUNCTUAL_SHOW_TIMESTAMP="${PUNCTUAL_SHOW_TIMESTAMP:-true}";
PUNCTUAL_SHOW_USER="${PUNCTUAL_SHOW_USER:-true}";
PUNCTUAL_SHOW_HOSTNAME="${PUNCTUAL_SHOW_HOSTNAME:-true}";
PUNCTUAL_SHOW_CURRENT_DIR="${PUNCTUAL_SHOW_CURRENT_DIR:-true}";
PUNCTUAL_SHOW_GIT="${PUNCTUAL_SHOW_GIT:-true}";

PUNCTUAL_TIMESTAMP_COLOUR="${PUNCTUAL_TIMESTAMP_COLOUR:-reset}";
PUNCTUAL_USER_COLOUR="${PUNCTUAL_USER_COLOUR:-blue}";
PUNCTUAL_ROOT_USER_COLOUR="${PUNCTUAL_ROOT_USER_COLOUR:-red}";
PUNCTUAL_HOSTNAME_COLOUR="${PUNCTUAL_HOSTNAME_COLOUR:-green}";
PUNCTUAL_CURRENT_DIR_COLOUR="${PUNCTUAL_CURRENT_DIR_COLOUR:-cyan}";
PUNCTUAL_GIT_COLOUR="${PUNCTUAL_GIT_COLOUR:-magenta}";

PUNCTUAL_TIMESTAMP_BOLD="${PUNCTUAL_TIMESTAMP_BOLD:-false}";
PUNCTUAL_USER_BOLD="${PUNCTUAL_USER_BOLD:-false}";
PUNCTUAL_ROOT_USER_BOLD="${PUNCTUAL_ROOT_USER_BOLD:-false}";
PUNCTUAL_HOSTNAME_BOLD="${PUNCTUAL_HOSTNAME_BOLD:-false}";
PUNCTUAL_CURRENT_DIR_BOLD="${PUNCTUAL_CURRENT_DIR_BOLD:-false}";
PUNCTUAL_GIT_BOLD="${PUNCTUAL_GIT_BOLD:-false}";

PUNCTUAL_TIMESTAMP_FORMAT="${PUNCTUAL_TIMESTAMP_FORMAT:-%H:%M:%S}"; # see man strftime

PUNCTUAL_PROMPT="${PUNCTUAL_PROMPT:-→}";

PUNCTUAL_GIT_SYMBOL_UNTRACKED="${PUNCTUAL_GIT_SYMBOL_UNTRACKED:-?}";
PUNCTUAL_GIT_SYMBOL_ADDED="${PUNCTUAL_GIT_SYMBOL_ADDED:-+}";
PUNCTUAL_GIT_SYMBOL_MODIFIED="${PUNCTUAL_GIT_SYMBOL_MODIFIED:-!}";
PUNCTUAL_GIT_SYMBOL_RENAMED="${PUNCTUAL_GIT_SYMBOL_RENAMED:-!}";
PUNCTUAL_GIT_SYMBOL_DELETED="${PUNCTUAL_GIT_SYMBOL_DELETED:-!}";
PUNCTUAL_GIT_SYMBOL_STASHED="${PUNCTUAL_GIT_SYMBOL_STASHED:-*}";
PUNCTUAL_GIT_SYMBOL_UNMERGED="${PUNCTUAL_GIT_SYMBOL_UNMERGED:-M}";
PUNCTUAL_GIT_SYMBOL_AHEAD="${PUNCTUAL_GIT_SYMBOL_AHEAD:-↑}";
PUNCTUAL_GIT_SYMBOL_BEHIND="${PUNCTUAL_GIT_SYMBOL_BEHIND:-↓}";
PUNCTUAL_GIT_SYMBOL_DIVERGED="${PUNCTUAL_GIT_SYMBOL_DIVERGED:-~}";

# --



ZSH_THEME_GIT_PROMPT_UNTRACKED="${ZSH_THEME_GIT_PROMPT_UNTRACKED:-${PUNCTUAL_GIT_SYMBOL_UNTRACKED}}";
ZSH_THEME_GIT_PROMPT_ADDED="${ZSH_THEME_GIT_PROMPT_ADDED:-${PUNCTUAL_GIT_SYMBOL_ADDED}}";
ZSH_THEME_GIT_PROMPT_MODIFIED="${ZSH_THEME_GIT_PROMPT_MODIFIED:-${PUNCTUAL_GIT_SYMBOL_MODIFIED}}";
ZSH_THEME_GIT_PROMPT_RENAMED="${ZSH_THEME_GIT_PROMPT_RENAMED:-${PUNCTUAL_GIT_SYMBOL_RENAMED}}";
ZSH_THEME_GIT_PROMPT_DELETED="${ZSH_THEME_GIT_PROMPT_DELETED:-${PUNCTUAL_GIT_SYMBOL_DELETED}}";
ZSH_THEME_GIT_PROMPT_STASHED="${ZSH_THEME_GIT_PROMPT_STASHED:-${PUNCTUAL_GIT_SYMBOL_STASHED}}";
ZSH_THEME_GIT_PROMPT_UNMERGED="${ZSH_THEME_GIT_PROMPT_UNMERGED:-${PUNCTUAL_GIT_SYMBOL_UNMERGED}}";
ZSH_THEME_GIT_PROMPT_AHEAD="${ZSH_THEME_GIT_PROMPT_AHEAD:-${PUNCTUAL_GIT_SYMBOL_AHEAD}}";
ZSH_THEME_GIT_PROMPT_BEHIND="${ZSH_THEME_GIT_PROMPT_BEHIND:-${PUNCTUAL_GIT_SYMBOL_BEHIND}}";
ZSH_THEME_GIT_PROMPT_DIVERGED="${ZSH_THEME_GIT_PROMPT_DIVERGED:-${PUNCTUAL_GIT_SYMBOL_DIVERGED}}";


punctualNewline () {
    echo '';
}

punctualDecorate () {
    if [[ $2 == 'reset' ]]; then
        echo -n "%{$reset_color%}";
    else
        echo -n "%{$fg[$2]%}";
    fi;

    if [[ $3 = true ]]; then
        echo -n "%{$terminfo[bold]%}";
    fi;

    echo -n ${1};
    echo -n "%{$reset_color%}";
}


punctualUser () {
    echo -n 'as';
    echo -n ' ';
    if [[ $USER == 'root' ]]; then
        punctualDecorate '%n' "${PUNCTUAL_ROOT_USER_COLOUR}" "${PUNCTUAL_ROOT_USER_BOLD}";
    else
        punctualDecorate '%n' "${PUNCTUAL_USER_COLOUR}" "${PUNCTUAL_USER_BOLD}";
    fi;
}

punctualHostname () {
    echo -n 'on';
    echo -n ' ';
    punctualDecorate '%m' "${PUNCTUAL_HOSTNAME_COLOUR}" "${PUNCTUAL_HOSTNAME_BOLD}";
}

punctualCurrentDir () {
    echo -n 'in';
    echo -n ' ';
    punctualDecorate '%~' "${PUNCTUAL_CURRENT_DIR_COLOUR}" "${PUNCTUAL_CURRENT_DIR_BOLD}";
}

punctualGitStatus () {
    PUNCTUAL_GIT_CURRENT_BRANCH=`git_current_branch | xargs echo -n`;
    PUNCTUAL_GIT_PROMPT_STATUS=`git_prompt_status | sed -E 's/!+/!/g' | xargs echo -n`;
    if [[ ! -z "${PUNCTUAL_GIT_CURRENT_BRANCH}" ]]; then
        echo -n 'at';
        echo -n ' ';
        punctualDecorate "${PUNCTUAL_GIT_CURRENT_BRANCH}" "${PUNCTUAL_GIT_COLOUR}" "${PUNCTUAL_GIT_BOLD}";
        if [[ ! -z "${PUNCTUAL_GIT_PROMPT_STATUS}" ]]; then
            punctualDecorate "(${PUNCTUAL_GIT_PROMPT_STATUS})" "${PUNCTUAL_GIT_COLOUR}" "${PUNCTUAL_GIT_BOLD}";
        fi;
    fi;
}

punctualTimestamp () {
    punctualDecorate "%D{${PUNCTUAL_TIMESTAMP_FORMAT}}" "${PUNCTUAL_TIMESTAMP_COLOUR}" "${PUNCTUAL_TIMESTAMP_BOLD}";
}

punctualPrompt () {
    echo -n "%(?.%{$reset_color%}.%{$fg[red]%})";
    echo -n "${PUNCTUAL_PROMPT}";
    echo -n "%{$reset_color%}";
    echo -n ' ';
}


punctualBuildTheme () {
    punctualNewline;
    echo -n '  ';
    if [[ ${PUNCTUAL_SHOW_TIMESTAMP} = true ]]; then
        punctualTimestamp;
        echo -n ' ';
    fi;
    if [[ ${PUNCTUAL_SHOW_USER} = true ]]; then
        punctualUser;
        echo -n ' ';
    fi;
    if [[ ${PUNCTUAL_SHOW_HOSTNAME} = true ]]; then
        punctualHostname;
        echo -n ' ';
    fi;
    if [[ ${PUNCTUAL_SHOW_CURRENT_DIR} = true ]]; then
        punctualCurrentDir;
        echo -n ' ';
    fi;
    if [[ ${PUNCTUAL_SHOW_GIT} = true ]]; then
        punctualGitStatus;
    fi;
    punctualNewline;
    punctualPrompt;
}

PROMPT='$(punctualBuildTheme)'
