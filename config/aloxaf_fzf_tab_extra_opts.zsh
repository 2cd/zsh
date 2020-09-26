#!/usr/bin/env zsh
#: <<\EOF
#分组和补全项颜色
aloxaf_fzf_tab_extra_opt_01() {
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
}
#EOF
###############
aloxaf_fzf_tab_extra_opt_02() {
    #FZF-TAB右侧窗口配置
    local extract="
# trim input
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# real path
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"
    #zstyle ':fzf-tab:*' single-group ''
    #zstyle ':fzf-tab:complete:_zlua:*' query-string input
    zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
    zstyle ':fzf-tab:complete:(cd|ls|exa|bat|cat|nano|vi|vim):*' extra-opts --preview=$extract'ls -1 -A --color=always $realpath'
    #zstyle ':fzf-tab:complete:(cd|ls|nano|vi|vim):*' extra-opts --preview=$extract'ls -1A --color=auto ${~ctxt[hpre]}$in 2>/dev/null'
}
#################
check_fzf_tab_variable(){
case ${ALOXAF_FZF_TAB_EXTRA} in
false) ;;
true)
    aloxaf_fzf_tab_extra_opt_01
    aloxaf_fzf_tab_extra_opt_02
    ;;
01) aloxaf_fzf_tab_extra_opt_01 ;;
02) aloxaf_fzf_tab_extra_opt_02 ;;
esac
}
##################
check_fzf_tab_variable