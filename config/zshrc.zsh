# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] {
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
}
########
# Note
# If you find a permission problem with zsh-related directories, then try running `compaudit | xargs chmod g-w,o-w`

########
# Set env
path=(~/.local/bin $path)
typeset -x XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
TMOE_ZSH_DIR="${HOME}/.config/tmoe-zsh"
TMOE_ZSH_GIT_DIR="${TMOE_ZSH_DIR}/git"
TMOE_ZSH_TOOL_DIR="${TMOE_ZSH_GIT_DIR}/tools"
ZINIT_THEME_DIR="${HOME}/.zinit/themes/_local"
########
# Setopt
setopt correct
# setopt autocd

setopt interactive_comments
########
load_omz_lib() {
    for i (theme-and-appearance.zsh git.zsh prompt_info_functions.zsh history.zsh) {
        zinit snippet ${HOME}/.zinit/omz/lib/${i}
    }
    for i (completion.zsh key-bindings.zsh) {
        zinit ice lucid wait="1"
        zinit snippet ${HOME}/.zinit/omz/lib/${i}
    }
}
########
load_zinit_compinit_function() {
    # autoload -Uz compinit ;compinit #载入补全相关function
    zpcompinit
    zpcdreplay
    # compinit -u
    # zinit cdreplay -q
}
########
# LOAD MAIN LIB
source ${HOME}/.zinit/bin/zinit.zsh
load_omz_lib
########
# THEME
zinit light ${ZINIT_THEME_DIR}/xiong-chiamiov-plus
# theme-and-appearance的加载顺序要先于主题,请在load_omz_lib之后加载主题。
skip_global_compinit=1
load_zinit_compinit_function
########
ALOXAF_FZF_TAB_EXTRA=01
# 当变量ALOXAF_FZF_TAB_EXTRA的值为01时，仅加载补全项颜色函数;为02时，加载右侧窗口配置;为true时，启用所有额外函数;为false时禁用。
source ${TMOE_ZSH_GIT_DIR}/config/aloxaf_fzf_tab_extra_opts.zsh
########
zinit ice lucid wait="1" pick"extract.plugin.zsh" && zinit light _local/extract && zinit ice lucid as"completion" wait="1" && zinit snippet ${HOME}/.zinit/plugins/_local---extract/_extract #解压插件，输x 压缩包名称（例如`x 233.7z`或`x 233.tar.xz`) 即可解压文件。This plugin defines a function called `extract` that extracts the archive file you pass it, and it supports a wide variety of archive filetypes.
########
zinit ice lucid wait="1" pick"z.plugin.zsh" && zinit light _local/z && unsetopt BG_NICE #记录访问目录，输z获取,输`z 目录名称`快速跳转  This plugin defines the [z command](https://github.com/rupa/z) that tracks your most visited directories and allows you to access them with very few keystrokes.
########
zinit ice lucid pick"git.plugin.zsh" wait="1" && zinit light _local/git #The git plugin provides many aliases and a few useful functions. git的一些alias,例如将git clone简化为gcl.
########
[[ -e /usr/lib/command-not-found ]] && zinit ice lucid wait="0" pick"command-not-found.plugin.zsh" && zinit light _local/command-not-found #用于显示未找到的命令来源于哪个软件包  This plugin uses the command-not-found package for zsh to provide suggested packages to be installed if a command cannot be found.

zinit ice lucid wait="3" pick"colored-man-pages.plugin.zsh" && zinit light _local/colored-man-pages #This plugin adds colors to man pages. man手册彩色输出

zinit ice wait lucid pick"fast-syntax-highlighting.plugin.zsh" atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" && zinit light _local/fast-syntax-highlighting #语法高亮插件，速度比zsh-syntax-highlighting更快。(Short name F-Sy-H). Syntax-highlighting for Zshell – fine granularity, number of features, 40 work hours themes

zinit ice wait lucid pick"zsh-autosuggestions.zsh" atload'_zsh_autosuggest_start' && zinit light _local/zsh-autosuggestions #自动建议插件 It suggests commands as you type based on history and completions.

zinit ice lucid wait="2" pick"sudo.plugin.zsh" && zinit light _local/sudo #Easily prefix your current or previous commands with `sudo` by pressing <kbd>esc</kbd> twice 按两次ESC键,可以在当前命令前加上sudo前缀  

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # powerlevel10k的prompt
#######
# ALIASES
alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias _='sudo '
alias afind='ack -il'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gc1='git clone --recursive --depth=1'
alias globurl='noglob urlglobber '
alias grep='grep --color=auto'
alias md='mkdir -p'
alias rd=rmdir
########
if [[ $(command -v exa) ]] {
    DISABLE_LS_COLORS=true
    unset LS_BIN_FILE
    for i (/bin/ls ${PREFIX}/bin/ls /usr/bin/ls /usr/local/bin/ls) {
        [[ ! -x ${i} ]] || {
            local LS_BIN_FILE=${i}
            break
        }
    }
    [[ -n ${LS_BIN_FILE} ]] || local LS_BIN_FILE=$(whereis ls 2>/dev/null | awk '{print $2}')
    alias lls=${LS_BIN_FILE} 
    # lls is the original ls. lls为原版ls
    alias ls="exa --color=auto" 
    # Exa is a modern version of ls. exa是一款优秀的ls替代品,拥有更好的文件展示体验,输出结果更快,使用rust编写。
    alias l='exa -lbah --icons'
    alias la='exa -labgh --icons'
    alias ll='exa -lbg --icons'
    alias lsa='exa -lbagR --icons'
    alias lst='exa -lTabgh --icons' # 输入lst,将展示类似于tree的树状列表。
} else {
    alias ls='ls --color=auto'
    # color should not be always.
    alias lst='tree -pCsh'
    alias l='ls -lah'
    alias la='ls -lAh'
    alias ll='ls -lh'
    alias lsa='ls -lah'
}
[[ ! $(command -v tmoe) ]] || alias t=tmoe
########
set_bat_paper_variable() {
    unset CAT_BIN_FILE i
    for i (/bin/cat ${PREFIX}/bin/cat /usr/bin/cat /usr/local/bin/cat) {
        [[ ! -x ${i} ]] || {
            local CAT_BIN_FILE=${i}
            unset i
            break
        }
    }
    [[ -n ${CAT_BIN_FILE} ]] || local CAT_BIN_FILE=$(whereis cat 2>/dev/null | awk '{print $2}')
    alias lcat=${CAT_BIN_FILE} 
    # lcat is the original cat.
    typeset -g BAT_PAGER="less -m -RFQ" # You can type q to quit bat. 输q退出bat的页面视图
}
# bat supports syntax highlighting for a large number of programming and markup languages. bat是cat的替代品，支持多语言语法高亮。
for i (batcat bat) {
    if [[ $(command -v ${i}) ]] {
        alias cat="${i} -pp"
        set_bat_paper_variable
        break
    }
}
########
