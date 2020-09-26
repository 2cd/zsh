# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#: <<\EOF
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#EOF
############
load_omz_lib() {
    for i in theme-and-appearance.zsh git.zsh prompt_info_functions.zsh history.zsh; do
        zinit snippet ${HOME}/.zinit/omz/lib/${i}
    done
    for i in completion.zsh key-bindings.zsh; do
        zinit ice lucid wait="1"
        zinit snippet ${HOME}/.zinit/omz/lib/${i}
    done
    unset i
}
########
load_zinit_compinit_function() {
    #autoload -Uz compinit ;compinit #载入补全相关function
    zpcompinit
    zpcdreplay
    zinit cdreplay -q
}
########
##LOAD MAIN LIB
TMOE_ZSH_DIR="${HOME}/.config/tmoe-zsh"
TMOE_ZSH_GIT_DIR="${TMOE_ZSH_DIR}/git"
TMOE_ZSH_TOOL_DIR="${TMOE_ZSH_GIT_DIR}/tools"
ZINIT_THEME_DIR="${HOME}/.zinit/themes/_local"
source ${HOME}/.zinit/bin/zinit.zsh
load_omz_lib
############
##THEME
zinit light ${ZINIT_THEME_DIR}/xiong-chiamiov-plus
#theme-and-appearance的加载顺序要先于主题,请在load_omz_lib之后加载主题。
skip_global_compinit=1
load_zinit_compinit_function
##############
ALOXAF_FZF_TAB_EXTRA=01
#当变量ALOXAF_FZF_TAB_EXTRA的值为01时，仅加载补全项颜色函数;为02时，加载右侧窗口配置;为true时，启用所有额外函数;为false时禁用。
source ${TMOE_ZSH_GIT_DIR}/config/aloxaf_fzf_tab_extra_opts.zsh
##########
[[ $(command -v fzf) ]] && zinit ice lucid pick"fzf-tab.zsh" && zinit light _local/fzf-tab #aloxaf:fzf-tab 是一个能够极大提升 zsh 补全体验的插件。它通过 hook zsh 补全系统的底层函数 compadd 来截获补全列表，从而实现了在补全命令行参数、变量、目录栈和文件时都能使用 fzf 进行选择的功能。Replace zsh's default completion selection menu with fzf!
##########
zinit ice lucid wait="1" pick"extract.plugin.zsh" && zinit light _local/extract && zinit ice lucid as"completion" wait="1" && zinit snippet ${HOME}/.zinit/plugins/_local---extract/_extract #解压插件，输x 压缩包名称（例如`x 233.7z`或`x 233.tar.xz`) 即可解压文件。This plugin defines a function called `extract` that extracts the archive file you pass it, and it supports a wide variety of archive filetypes.
#########
zinit ice lucid wait="1" pick"z.plugin.zsh" && zinit light _local/z && unsetopt BG_NICE #记录访问目录，输z获取,输`z 目录名称`快速跳转  This plugin defines the [z command](https://github.com/rupa/z) that tracks your most visited directories and allows you to access them with very few keystrokes.
########
zinit ice lucid pick"git.plugin.zsh" wait="1" && zinit light _local/git #git的一些alias,例如将git clone简化为gcl.  The git plugin provides many aliases and a few useful functions.
##########
[[ -e /usr/lib/command-not-found ]] && zinit ice lucid wait="0" pick"command-not-found.plugin.zsh" && zinit light _local/command-not-found #用于显示未找到的命令来源于哪个软件包  This plugin uses the command-not-found package for zsh to provide suggested packages to be installed if a command cannot be found.

zinit ice lucid wait="3" pick"colored-man-pages.plugin.zsh" && zinit light _local/colored-man-pages #man手册彩色输出 This plugin adds colors to man pages

zinit ice wait lucid pick"fast-syntax-highlighting.plugin.zsh" atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" && zinit light _local/fast-syntax-highlighting #语法高亮插件，速度比zsh-syntax-highlighting更快。(Short name F-Sy-H). Syntax-highlighting for Zshell – fine granularity, number of features, 40 work hours themes

zinit ice wait lucid pick"zsh-autosuggestions.zsh" atload'_zsh_autosuggest_start' && zinit light _local/zsh-autosuggestions #自动建议插件 It suggests commands as you type based on history and completions.

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh #powerlevel10k的prompt
#######
#ALIAS
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
alias egrep='egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias fgrep='fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias gc1='git clone --recursive --depth=1'
alias globurl='noglob urlglobber '
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias md='mkdir -p'
alias rd=rmdir
#######
if [ $(command -v exa) ]; then
    #DISABLE_LS_COLORS=true
    alias lls=ls
    alias ls="exa -b --color=auto" #exa是一款优秀的ls替代品,拥有更好的文件展示体验,输出结果更快,使用rust编写。Exa is a modern version of ls.
    alias l='exa -lbah'
    alias la='exa -lbahgR'
    alias ll='exa -lbgh'
    alias lsa='exa -labgh'
    alias lst='exa -lTabgh' #输入lst,将展示类似于tree的树状列表。
else
    alias ls='ls --color=auto'
    alias l='ls -lah'
    alias la='ls -lAh'
    alias ll='ls -lh'
    alias lsa='ls -lah'
fi
[[ ! $(command -v tmoe) ]] || alias t=tmoe
######
if [ $(command -v batcat) ]; then
    alias cat='batcat' #输q退出bat的页面视图，you can type q to quit bat.
elif [ $(command -v bat) ]; then
    alias cat='bat' #bat是cat的替代品，支持多语言语法高亮。支持自动分页，对于大文本，以 less 命令输出，则可使用类似 vim 的快捷键移动光标。
fi
########
#########
: <<\ENDOFZINITHELP
    zinit 基本用法
    zinit 可以简化为zi
    zi times 显示插件加载时间，默认单位为毫秒。
    zi loaded 显示已经加载的插件
    zi csearch 搜索所有可用的补全插件
    zi cenable docker 启用docker命令的补全，docker可替换为其他命令，但必须在zi csearch输出的列表中。
    zi cdisable docker 禁用docker命令的补全
    zi clist 列举已经启用的补全插件
    ---------------------
    zinit=zi
    You can type `zi -h` to get more help info.
Usage:
-h|--help|help                – usage information
man                           – manual
self-update                   – updates and compiles Zinit
times [-s] [-m]               – statistics on plugin load times, sorted in order of loading; -s – use seconds instead of milliseconds, -m – show plugin loading moments
zstatus                       – overall Zinit status
load plg-spec                 – load plugin, can also receive absolute local path
light [-b] plg-spec           – light plugin load, without reporting/tracking (-b – do track but bindkey-calls only)
unload plg-spec               – unload plugin loaded with `zinit load ...', -q – quiet
snippet [-f] {url}            – source local or remote file (by direct URL), -f: force – don't use cache
ls                            – list snippets in formatted and colorized manner
ice <ice specification>       – add ICE to next command, argument is e.g. from"gitlab"
update [-q] plg-spec|URL      – Git update plugin or snippet (or all plugins and snippets if ——all passed); besides -q accepts also ——quiet, and also -r/--reset – this option causes to run git reset --hard / svn revert before pulling changes
status plg-spec|URL           – Git status for plugin or svn status for snippet (or for all those if ——all passed)
report plg-spec               – show plugin's report (or all plugins' if ——all passed)
delete [--all|--clean] plg-spec|URL – remove plugin or snippet from disk (good to forget wrongly passed ice-mods); --all – purge, --clean – delete plugins and snippets that are not loaded
loaded|list {keyword}         – show what plugins are loaded (filter with \'keyword')
cd plg-spec                   – cd into plugin's directory; also support snippets, if feed with URL
create plg-spec               – create plugin (also together with Github repository)
edit plg-spec                 – edit plugin's file with $EDITOR
glance plg-spec               – look at plugin's source (pygmentize, {,source-}highlight)
stress plg-spec               – test plugin for compatibility with set of options
changes plg-spec              – view plugin's git log
recently [time-spec]          – show plugins that changed recently, argument is e.g. 1 month 2 days
clist|completions             – list completions in use
cdisable cname                – disable completion `cname'
cenable cname                 – enable completion `cname'
creinstall plg-spec           – install completions for plugin, can also receive absolute local path; -q – quiet
cuninstall plg-spec           – uninstall completions for plugin
csearch                       – search for available completions from any plugin
compinit                      – refresh installed completions
dtrace|dstart                 – start tracking what's going on in session
dstop                         – stop tracking what's going on in session
dunload                       – revert changes recorded between dstart and dstop
dreport                       – report what was going on in session
dclear                        – clear report of what was going on in session
compile plg-spec              – compile plugin (or all plugins if ——all passed)
uncompile plg-spec            – remove compiled version of plugin (or of all plugins if ——all passed)
compiled                      – list plugins that are compiled
cdlist                        – show compdef replay list
cdreplay [-q]                 – replay compdefs (to be done after compinit), -q – quiet
cdclear [-q]                  – clear compdef replay list, -q – quiet
srv {service-id} [cmd]        – control a service, command can be: stop,start,restart,next,quit; `next' moves the service to another Zshell
recall plg-spec|URL           – fetch saved ice modifiers and construct `zinit ice ...' command
env-whitelist [-v|-h] {env..} – allows to specify names (also patterns) of variables left unchanged during an unload. -v – verbose
bindkeys                      – lists bindkeys set up by each plugin
module                        – manage binary Zsh module shipped with Zinit, see `zinit module help'
add-fpath|fpath [-f|--front] \
    plg-spec [subdirectory]      – adds given plugin directory to $fpath; if the second argument is given, it is appended to the directory path; if the option -f/--front is given, the directory path is prepended instead of appended to $fpath. The plg-spec can be absolute path
run [-l] [plugin] {command}   – runs the given command in the given plugin's directory; if the option -l will be given then the plugin should be skipped – the option will cause the previous plugin to be reused
ENDOFZINITHELP
#################
