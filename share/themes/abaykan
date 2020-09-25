# abaykan zsh-theme
# Screenshot > https://abaykan.com/server/abaykan.zsh-theme~.png


# logo abaykan
abaykan="$fg_bold[cyan]
     _-----_
    |       |    
    |--(o)--|     ╒ $fg_bold[white]abaykan$fg_bold[cyan] ═════════════════════════════════════════════════════════╕
   '---------'    │$fg_bold[white]I was addicted to Hacking, more for the intellectual challenge,$fg_bold[cyan]   │
    ( _ U _ )     │$fg_bold[white]the curiosity, the seduction of adventure; not for stealing,$fg_bold[cyan]      │
    /___A___\	  │$fg_bold[white]or causing a damage or writing computer viruses. - Kevin Mitnick.$fg_bold[cyan] │
     |  ~  |	  ╘══════════════════════════════════════════════════════════════════╛ $fg_bold[cyan]
   __'.___.'__
 '   '  |° ' Y '
 "
# whoami
g_whoami="☉ $fg[white]Whomai  : `whoami`$fg[cyan]"

# id
g_id="☉ $fg[white]User    : `id $(whoami) | cut -d' ' -f1`$fg[cyan]"

# kernel version
g_kernel="☉ $fg[white]System  : `uname -v`$fg[cyan]"

# date time
g_date="☉ $fg[white]Today   : `date`$fg[cyan] \n\n"

# print
print -P $abaykan
print -P $g_whoami
print -P $g_id
print -P $g_kernel
print -P $g_date

# show staged changes in the repository
local g_changes="$FG[038][%c]%{$reset_color%}"
# Define prompts
#
PROMPT='${g_status}${g_changes} $(git_prompt_info)'

# git
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%})"
