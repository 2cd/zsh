#!/usr/bin/env bash
##############################################################
main() {
    terminal_color
    tmoe_zsh_plugin_env
    case "$1" in
    *) tmoe_zsh_plugin_main_menu ;;
    esac
}
###############
terminal_color() {
    RED=$(printf '\033[31m')
    GREEN=$(printf '\033[32m')
    YELLOW=$(printf '\033[33m')
    BLUE=$(printf '\033[34m')
    BOLD=$(printf '\033[1m')
    RESET=$(printf '\033[m')
}
###############
tmoe_zsh_plugin_env() {
    ZINIT_DIR="${HOME}/.zinit"
    ZINIT_THEME_DIR="${ZINIT_DIR}/themes/_local"
    OMZ_DIR="${ZINIT_DIR}/omz"
}
#############
press_enter_to_return() {
    echo "Press ${GREEN}enter${RESET} to ${BLUE}return.${RESET}"
    echo "按${GREEN}回车键${RESET}${BLUE}返回${RESET}"
    read
}
#####################
press_enter_to_continue() {
    echo "Press ${GREEN}enter${RESET} to ${BLUE}continue.${RESET}"
    echo "按${GREEN}回车键${RESET}${BLUE}继续${RESET}"
    read
}
################
do_you_want_to_continue_00() {
    echo "${YELLOW}Do you want to continue?[Y/n]${RESET}"
    echo "Press ${GREEN}enter${RESET} to ${BLUE}continue${RESET},type ${YELLOW}n${RESET} to ${BLUE}return.${RESET}"
    echo "按${GREEN}回车键${RESET}${BLUE}继续${RESET}，输${YELLOW}n${RESET}${BLUE}返回${RESET}"
}
#########
do_you_want_to_continue() {
    do_you_want_to_continue_00
    read opt
    case $opt in
    y* | Y* | "") ;;

    n* | N*)
        echo "skipped."
        ${RETURN_TO_WHERE}
        ;;
    *)
        echo "Invalid choice. skipped."
        ${RETURN_TO_WHERE}
        ;;
    esac
}
#############
do_you_want_to_continue_02() {
    do_you_want_to_continue_00
    read opt
    case $opt in
    y* | Y* | "") ;;

    n* | N*)
        echo "skipped."
        ${RETURN_TO_MENU}
        ;;
    *)
        echo "Invalid choice. skipped."
        ${RETURN_TO_MENU}
        ;;
    esac
}
###############
list_enabled_plugins() {
    CATCAT=''
    for i in bat batcat; do
        if [[ $(command -v ${i}) ]]; then
            CATCAT="${i}"
        fi
    done
    unset i
    case ${CATCAT} in
    "") cat ${HOME}/.zshrc | egrep -v '^#|.zinit/omz/lib' | egrep -n --color=auto '(zinit light|zinit load|zinit snippet).*?#' ;;
    *) cat ${HOME}/.zshrc | egrep -v '^#|.zinit/omz/lib' | egrep -n --color=auto '(zinit light|zinit load|zinit snippet).*?#' | ${CATCAT} -l zsh --pager "less -m -RFeQ" ;;
    esac
}
##############
tmoe_zsh_plugin_main_menu() {
    RETURN_TO_WHERE='tmoe_zsh_plugin_main_menu'
    TMOE_ZSH_FILE="${HOME}/.zshrc"
    ZSH_README_FILE_NAME='README.md'
    ZSH_README_FILE_NAME_02=''
    ZINIT_SPECIAL_LOADING_CONTENT=''
    WAIT_TIME='1'
    cd ${HOME}
    TMOE_OPTION=$(whiptail --title "PLUGINS" --menu "您想要管理哪个首字母开头的插件？\nBecause there are too many plugins, alphabetical sorting." 0 50 0 \
        "01" "🍎 A-C(a,b,c)" \
        "02" "🍇 D-G(d,e,f,g)" \
        "03" "🥝 H-M(h,i,j,k,l,m)" \
        "04" "🍑 N-R(n,o,p,q,r)" \
        "05" "🍓 S-T(s,t)" \
        "06" "🍉 U-Z(u,v,w,x,y,z)" \
        "07" "🍊 Extra 额外插件" \
        "08" "🍌 enabled plugins列出已启用插件" \
        "09" "zinit cesrach" \
        "00" "🌚 Back to the main menu 返回主菜单" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") exit 0 ;;
    01) tmoe_zsh_plugin_menu_01 ;;
    02) tmoe_zsh_plugin_menu_02 ;;
    03) tmoe_zsh_plugin_menu_03 ;;
    04) tmoe_zsh_plugin_menu_04 ;;
    05) tmoe_zsh_plugin_menu_05 ;;
    06) tmoe_zsh_plugin_menu_06 ;;
    07) tmoe_zsh_plugin_menu_07 ;;
    08) list_enabled_plugins ;;
    09) zinit_csearch ;;
    esac
    ##############################
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
zinit_csearch() {
    zsh -c "source ${HOME}/.zinit/bin/zinit.zsh && zinit csearch"
    cat <<-EOF
    ${BOLD}${YELLOW}COMMAND${RESET}${RESET}:${BOLD}${BLUE}zi csearch${RESET}${RESET} 
    ${BOLD}${YELLOW}Description${RESET}${RESET}: ${BLUE}Search for available completions from any plugin${RESET}.
    ${BOLD}${YELLOW}描述${RESET}${RESET}: ${BLUE}对插件目录进行搜索，列举所有可用补全，并显示其安装状态。${RESET}
    You can type ${GREEN}zi cenable${RESET} ${BLUE}\$PLUGIN_COMMAND${RESET} to enable completion,type ${GREEN}zi cdisnable${RESET} ${BLUE}\$PLUGIN_COMMAND${RESET} to disable it.
    For example,you can type ${GREEN}zi cenable${RESET} ${BLUE}docker${RESET} to enable docker's completion.
    示例：输${GREEN}zi cenable${RESET} ${BLUE}adb${RESET}启用adb的补全。
EOF
}
#############
tmoe_zsh_plugin_menu_01() {
    TMOE_ZSH_SETTINGS_MODEL='01'
    RETURN_TO_WHERE='tmoe_zsh_plugin_menu_01'
    TMOE_OPTION=$(whiptail --title "list of plugins" --menu "Which plugin do you want to choose?" 0 50 0 \
        "00" "🌚 Return to previous menu 返回上级菜单" \
        "01" "adb:为adb命令添加自动补全选项" \
        "02" "alias-finder:搜索定义别名,并输出与输入命令匹配的任何别名" \
        "03" "ansible:为[ansible]命令和[aliases]添加了多个别名" \
        "04" "ant:为[Ant.apache]提供了补全功能" \
        "05" "apache2-macports:启用别名以控制通过[MacPorts]安装的本地Apache2" \
        "06" "arcanist:为[arcanist]添加了许多有用的别名" \
        "07" "archlinux:添加了一些pacman和yay等常用命令的别名" \
        "08" "asdf:添加了可扩展版本管理器[asdf]的集成,并支持Ruby,Nodejs,Elixir,Erlang" \
        "09" "autoenv:高效、自动地加载文件目录的环境变量" \
        "10" "autojump:自动跳转导航工具" \
        "11" "autopep8:为[autopep8]添加了补全功能,可自动格式化Python代码以使其符合[PEP 8]样式" \
        "12" "aws:为[awscli]提供补全支持" \
        "13" "battery:添加了一些功能,可在自定义主题中显示电池信息" \
        "14" "bazel:来自[bazelbuild/bazel]的补全脚本" \
        "15" "bbedit:Mac OS X的HTML和文本编辑器" \
        "16" "bgnotify:跨平台后台通知,可长时间运行,支持OSX和Ubuntu" \
        "17" "boot2docker:为所有boot2docker命令添加自动补全选项" \
        "18" "bower:为[Bower]添加了补全功能,并为常见的Bower命令添加了一些有用的别名" \
        "19" "branch:快速显示当前的Git或Mercurial分支" \
        "20" "brew:为[brew]的常用命令添加了几个别名" \
        "21" "bundler:增加了基本bundler命令的补全" \
        "22" "cabal:为Haskell的构建工具[Cabal]提供了补全功能" \
        "23" "cake:为[CakePHP]提供了补全功能" \
        "24" "cakephp3:为[cakephp3]添加了别名和自动补全功能" \
        "25" "capistrano:为[Capistrano]提供了补全功能" \
        "26" "cargo:这个插件为Rust构建工具[Cargo]添加了补全功能" \
        "27" "cask:Emacs的项目管理工具" \
        "28" "catimg:[posva]提供的catimg脚本,在终端上显示图像" \
        "29" "celery:为[Celery]提供了补全功能" \
        "30" "chruby:改变当前的Ruby版本以及提供Ruby的补全和提示功能。" \
        "31" "chucknorris:Chuck Norris fortunes插件,完全适合将其用作为MOTD" \
        "32" "cloudfoundry:为[Cloud Foundry Cli]提供一些简单的别名" \
        "33" "codeclimate:为[codeclimate CLI]添加了自动补全功能" \
        "34" "coffee:提供别名,可快速编译和预览coffeescript" \
        "35" "colemak:在zsh的[vi的style导航模式]中重新映射按键" \
        "36" "colored-man-pages:为man说明手册页添加颜色" \
        "37" "colorize:支持为300多种语言格式的文本内容输出语法高亮" \
        "38" "command-not-found:自动搜索未找到命令的软件包" \
        "39" "common-aliases:为许多常用命令创建(自以为)有用的别名" \
        "40" "compleat:查找[compleat]并加载其补全内容" \
        "41" "composer:提供[composer]的完整信息以及别名" \
        "42" "copybuffer:将ctrl-o键盘快捷键绑定(映射)为复制文本的命令" \
        "43" "copydir:将当前文件夹的路径复制到系统剪贴板" \
        "44" "copyfile:将文件内容放入系统剪贴板,以便将其粘贴到任何地方" \
        "45" "cp:定义了一个使用[rsync]的[cpv]函数" \
        "46" "cpanm:为[Cpanm]提供了补全功能" \
        3>&1 1>&2 2>&3)
    ##############################
    #TMOE_ZSH_COMMENT_CONTENT
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01)
        TMOE_ZSH_GREP_NAME='adb'
        TMOE_ZSH_COMMENT_CONTENT='Adds autocomplete options for all adb commands.- Add autocomplete for `adb -s`-'
        ;;
    02)
        TMOE_ZSH_GREP_NAME='alias-finder'
        TMOE_ZSH_COMMENT_CONTENT='This plugin searches the defined aliases and outputs any that match the command inputted. This makes learning new aliases easier'
        ;;
    03)
        TMOE_ZSH_GREP_NAME='ansible'
        TMOE_ZSH_COMMENT_CONTENT='The `ansible plugin` adds several aliases for useful [ansible](https://docs.ansible.com/ansible/latest/index.html) commands and [aliases](#aliases).'
        ;;
    04)
        TMOE_ZSH_GREP_NAME='ant'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Ant](https://ant.apache.org/).'
        ;;
    05)
        TMOE_ZSH_GREP_NAME='apache2-macports'
        TMOE_ZSH_COMMENT_CONTENT='Enables aliases to control a local Apache2 installed via [MacPorts](https://www.macports.org/).'
        ;;
    06)
        TMOE_ZSH_GREP_NAME='arcanist'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds many useful aliases for [arcanist](https://github.com/phacility/arcanist).'
        ;;
    07)
        TMOE_ZSH_GREP_NAME='archlinux'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some aliases and functions to work with Arch Linux.'
        ;;
    08)
        TMOE_ZSH_GREP_NAME='asdf'
        TMOE_ZSH_COMMENT_CONTENT='Adds integration with [asdf](https://github.com/asdf-vm/asdf), the extendable version manager, with support for Ruby, Node.js, Elixir, Erlang and more.'
        ;;
    09)
        TMOE_ZSH_GREP_NAME='autoenv'
        INSTALL_ZSH_PLUGIN='autoenv'
        TMOE_ZSH_SETTINGS_MODEL='03'
        TMOE_IMPORTANT_TIPS=$(
            cat <<-EOF
举个例子：
    #新建一个测试目录
    ${GREEN}mkdir -p${RESET} ${BLUE}./tmp/test${RESET}

    #将指定命令输出到该目录的.env文件
    ${GREEN}echo "echo I am using tmoe-zsh."${RESET} ${RED}>${RESET} ${BLUE}./tmp/test/.env${RESET}

    #此时进入刚才新建的目录，将直接执行.env脚本命令
    ${GREEN}cd${RESET} ${BLUE}./tmp/test/${RESET}
    ${YELLOW}I am using tmoe-zsh.${RESET}
EOF
        )
        TMOE_ZSH_COMMENT_CONTENT='This plugin loads the [Autoenv](https://github.com/inishchith/autoenv).'
        ;;
    10)
        TMOE_ZSH_GREP_NAME='autojump'
        TMOE_ZSH_COMMENT_CONTENT='This plugin loads the [autojump navigation tool](https://github.com/wting/autojump).'
        ;;
    11)
        TMOE_ZSH_GREP_NAME='autopep8'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [autopep8](https://pypi.org/project/autopep8/), a tool that automatically formats Python code to conform to the [PEP 8](http://www.python.org/dev/peps/pep-0008/) style guide.'
        ;;
    12)
        TMOE_ZSH_GREP_NAME='aws'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion support for [awscli](https://docs.aws.amazon.com/cli/latest/reference/index.html)-and a few utilities to manage AWS profiles and display them in the prompt.'
        ;;
    13)
        TMOE_ZSH_GREP_NAME='battery'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some functions you can use to display battery information in your custom theme.'
        ;;
    14)
        TMOE_ZSH_GREP_NAME='bazel'
        TMOE_ZSH_COMMENT_CONTENT='A copy of the completion script from the-[bazelbuild/bazel](https://github.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel)-'
        ;;
    15)
        TMOE_ZSH_GREP_NAME='bbedit'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for BBEdit, an HTML and text editor for Mac OS X'
        ;;
    16)
        TMOE_ZSH_GREP_NAME='bgnotify'
        TMOE_ZSH_COMMENT_CONTENT='cross-platform background notifications for long running commands! Supports OSX and Ubuntu linux.'
        ;;
    17)
        TMOE_ZSH_GREP_NAME='boot2docker'
        TMOE_ZSH_COMMENT_CONTENT='- Adds autocomplete options for all boot2docker commands.'
        ;;
    18)
        TMOE_ZSH_GREP_NAME='bower'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [Bower](https://bower.io/) and a few useful aliases for common Bower commands.'
        ;;
    19)
        TMOE_ZSH_GREP_NAME='branch'
        TMOE_ZSH_COMMENT_CONTENT='Displays the current Git or Mercurial branch fast.'
        ;;
    20)
        TMOE_ZSH_GREP_NAME='brew'
        TMOE_ZSH_COMMENT_CONTENT='The plugin adds several aliases for common [brew](https://brew.sh) commands.'
        ;;
    21)
        TMOE_ZSH_GREP_NAME='bundler'
        TMOE_ZSH_COMMENT_CONTENT='Adds completion for basic bundler commands'
        ;;
    22)
        TMOE_ZSH_GREP_NAME='cabal'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Cabal](https://www.haskell.org/cabal/), a build tool for Haskell. It-also provides a function `cabal_sandbox_info` that prints whether the current working directory is in a sandbox.-'
        ;;
    23)
        TMOE_ZSH_GREP_NAME='cake'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [CakePHP](https://cakephp.org/).'
        ;;
    24)
        TMOE_ZSH_GREP_NAME='cakephp3'
        TMOE_ZSH_COMMENT_CONTENT='The plugin adds aliases and autocompletion for [cakephp3](https://book.cakephp.org/3.0/en/index.html).'
        ;;
    25)
        TMOE_ZSH_GREP_NAME='capistrano'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Capistrano](https://capistranorb.com/).'
        ;;
    26)
        TMOE_ZSH_GREP_NAME='cargo'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the Rust build tool [`Cargo`](https://github.com/rust-lang/cargo).'
        ;;
    27)
        TMOE_ZSH_GREP_NAME='cask'
        TMOE_ZSH_COMMENT_CONTENT='[Cask](https://github.com/cask/cask) is a project management tool for Emacs that helps-automate the package development cycle; development, dependencies, testing, building,-'
        ;;
    28)
        TMOE_ZSH_GREP_NAME='catimg'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for displaying images on the terminal using the the `catimg.sh` script provided by [posva](https://github.com/posva/catimg)'
        ;;
    29)
        TMOE_ZSH_GREP_NAME='celery'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Celery](http://www.celeryproject.org/).'
        ;;
    30)
        TMOE_ZSH_GREP_NAME='chruby'
        TMOE_ZSH_COMMENT_CONTENT='This plugin loads [chruby](https://github.com/postmodern/chruby), a tool that changes the-current Ruby version, and completion and a prompt function to display the Ruby version.-'
        ;;
    31)
        TMOE_ZSH_GREP_NAME='chucknorris'
        TMOE_ZSH_COMMENT_CONTENT='Chuck Norris fortunes plugin for oh-my-zsh. Perfectly suitable as MOTD.'
        ;;
    32)
        TMOE_ZSH_GREP_NAME='cloudfoundry'
        TMOE_ZSH_COMMENT_CONTENT='This plugin is intended to offer a few simple aliases for regular users of the [Cloud Foundry Cli][1]. Most are just simple aliases that will save a bit of typing. Others include mini functions and or accept parameters. Take a look at the table below for details.'
        ;;
    33)
        TMOE_ZSH_GREP_NAME='codeclimate'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletion for the [`codeclimate` CLI](https://github.com/codeclimate/codeclimate).'
        ;;
    34)
        TMOE_ZSH_GREP_NAME='coffee'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides aliases for quickly compiling and previewing your-coffeescript code.-'
        ;;
    35)
        TMOE_ZSH_GREP_NAME='colemak'
        TMOE_ZSH_COMMENT_CONTENT='This plugin remaps keys in `zsh`’s [`vi`-style navigation mode](http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Keymaps)-for a [Colemak](https://colemak.com/) keyboard layout, to match the QWERTY position:-'
        ;;
    36)
        TMOE_ZSH_GREP_NAME='colored-man-pages'
        WAIT_TIME="3"
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds colors to man pages.'
        ZINIT_SPECIAL_LOADING_CONTENT='zinit ice lucid wait="3" pick"colored-man-pages.plugin.zsh" && zinit light _local/colored-man-pages #man手册彩色输出 This plugin adds colors to man pages'
        ;;
    37)
        TMOE_ZSH_GREP_NAME='colorize'
        TMOE_ZSH_COMMENT_CONTENT='With this plugin you can syntax-highlight file contents of over 300 supported languages and other text formats.'
        ;;
    38)
        TMOE_ZSH_GREP_NAME='command-not-found'
        TMOE_ZSH_COMMENT_CONTENT='This plugin uses the command-not-found package for zsh to provide suggested packages to be installed if a command cannot be found.'
        ZINIT_SPECIAL_LOADING_CONTENT='[[ -e /usr/lib/command-not-found ]] && zinit ice lucid wait="0" pick"command-not-found.plugin.zsh" && zinit light _local/command-not-found #用于显示未找到的命令来源于哪个软件包  This plugin uses the command-not-found package for zsh to provide suggested packages to be installed if a command cannot be found.'
        ;;
    39)
        TMOE_ZSH_GREP_NAME='common-aliases'
        TMOE_ZSH_COMMENT_CONTENT='This plugin creates helpful shortcut aliases for many commonly used commands.'
        ;;
    40)
        TMOE_ZSH_GREP_NAME='compleat'
        TMOE_ZSH_COMMENT_CONTENT='This plugin looks for [compleat](https://github.com/mbrubeck/compleat) and loads its completion.'
        ;;
    41)
        TMOE_ZSH_GREP_NAME='composer'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [composer](https://getcomposer.org/), as well as aliases-for frequent composer commands. It also adds Composer’s global binaries to the PATH, using-'
        ;;
    42)
        TMOE_ZSH_GREP_NAME='copybuffer'
        TMOE_ZSH_COMMENT_CONTENT='This plugin binds the ctrl-o keyboard shortcut to a command that copies the text-that is currently typed in the command line ($BUFFER) to the system clipboard.-'
        ;;
    43)
        TMOE_ZSH_GREP_NAME='copydir'
        TMOE_ZSH_COMMENT_CONTENT='Copies the path of your current folder to the system clipboard.'
        ;;
    44)
        TMOE_ZSH_GREP_NAME='copyfile'
        TMOE_ZSH_COMMENT_CONTENT='Puts the contents of a file in your system clipboard so you can paste it anywhere.'
        ;;
    45)
        TMOE_ZSH_GREP_NAME='cp'
        TMOE_ZSH_COMMENT_CONTENT='This plugin defines a `cpv` function that uses `rsync` so that you-get the features and security of this command.-'
        ;;
    46)
        TMOE_ZSH_GREP_NAME='cpanm'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Cpanm](https://github.com/miyagawa/cpanminus) ([docs](https://metacpan.org/pod/App::cpanminus)).'
        ;;
    esac
    ##############################
    case_tmoe_zsh_settings_model
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
#l | awk '{print $NF}' | egrep '^[d-g]' >233  ;cat 233 |sed 's@^@cat @g' | sed 's@$@/README.md | sed -n 3,4p | tr "\\n\\t" -d | tr -d "*" ; echo ""@g' >234
tmoe_zsh_plugin_menu_02() {
    TMOE_ZSH_SETTINGS_MODEL='01'
    RETURN_TO_WHERE='tmoe_zsh_plugin_menu_02'
    TMOE_OPTION=$(whiptail --title "list of plugins" --menu "Which plugin do you want to choose?" 0 50 0 \
        "00" "🌚 Return to previous menu 返回上级菜单" \
        "01" "dash:为[Dash]增强命令行功能" \
        "02" "debian:提供apt和dpkg相关的别名和功能" \
        "03" "dircycle:用于循环浏览目录堆栈" \
        "04" "direnv:创建[Direnv]挂钩" \
        "05" "dirhistory:添加用于浏览目录历史记录和层次结构的键盘快捷键" \
        "06" "dirpersist:使~/.zdirs文件中的前20个目录保持运行状态" \
        "07" "django:为[Django Project]的manage.py命令添加补全和提示" \
        "08" "dnf:为dnf的常用命令添加别名,使其更易于使用" \
        "09" "dnote:为[Dnote]项目添加自动补全功能" \
        "10" "docker:为[docker]添加自动补全功能" \
        "11" "docker-compose:为[docker-compose]以及一些插件提供补全功能" \
        "12" "docker-machine:快速创建、切换、停止容器" \
        "13" "doctl:为[Doctl]提供补全功能" \
        "14" "dotenv:进入项目根目录时,自动从.env文件中加载环境变量" \
        "15" "dotnet:为[.NET Core CLI]提供补全和有用的别名" \
        "16" "droplr:使用[Droplr]上传文件并生成短链接" \
        "17" "drush:添加别名,使草绘工作更轻松,更高效" \
        "18" "eecms:为[eecms]添加自动补全的控制台命令" \
        "19" "emacs:利用Emacs守护程序功能,允许用户快速打开框架" \
        "20" "ember-cli:为ember-cli添加别名" \
        "21" "emoji:方便地使用Unicode表情符号" \
        "22" "emoji-clock:将当前时间显示为表情符号,精度为半小时" \
        "23" "emotty:输出当前TTY号的表情符号" \
        "24" "encode64:为base64命令添加别名,简化编码和解码命令" \
        "25" "extract:简化解压命令,只需输x 压缩包名称即可快速解压" \
        "26" "fabric:为[Fabric]提供补全功能" \
        "27" "fancy-ctrl-z:按Ctrl+Z回到vim" \
        "28" "fasd:命令行生产力的助推器,快速访问POSIX shell的文件和目录" \
        "29" "fastfile:引用经常使用的某些文件或文件夹" \
        "30" "fbterm:自动启动[fbterm]" \
        "31" "fd:为文件搜索工具[fd]添加补全功能" \
        "32" "firewalld:使用firewalld-cmd命令为FirewallD添加一些别名和功能" \
        "33" "flutter:提供补全和有用的别名" \
        "34" "forklift:OS X的FTP应用程序" \
        "35" "fossil:增加对fossil库的补全支持和提示功能" \
        "36" "frontend-search:搜索功能让Web前端开发变得更容易" \
        "37" "fzf:启用[junegunn的fzf]模糊自动补全和按键绑定(映射)" \
        "38" "gas:为[gas]命令添加自动补全功能" \
        "39" "gatsby:为gatsby命令添加自动补全选项" \
        "40" "gb:用于Go语言的构建工具" \
        "41" "gcloud:为[Google Cloud SDK CLI]提供补全功能" \
        "42" "geeknote:为[Geeknote]提供自动补全功能" \
        "43" "gem:为[Gem]添加别名和补全功能，包括gem常用的子命令以及当前目录中已安装的gems" \
        "44" "git:提供了许多git的别名,例如将git clone简化为gcl" \
        "45" "git-auto-fetch:在git初始化目录中工作时,自动从所有远程获取所有更改" \
        "46" "git-escape-magic:提供的zle函数具有上下文感知功能" \
        "47" "git-extras:为[git-extras]定义的某些命令提供补全功能" \
        "48" "gitfast:为git添加补全功能,而且速度比zsh官方版本快得多" \
        "49" "git-flow:为[git-flow]添加别名和补全功能" \
        "50" "git-flow-avh:为[git-flow]添加补全功能" \
        "51" "github:通过命令行使用GitHub" \
        "52" "git-hubflow:为[HubFlow]添加别名和补全功能" \
        "53" "gitignore:通过命令行使用[gitignore.io]" \
        "54" "git-prompt:显示当前git仓库信息" \
        "55" "glassfish:为asadmin添加补全功能,该命令用于管理[Oracle GlassFish]" \
        "56" "globalias:扩展所有glob表达式,子命令和别名" \
        "57" "gnu-utils:将GNU coreutils绑定到其默认名称" \
        "58" "golang:为[Go语言]添加补全内容" \
        "69" "gpg-agent:自动启用[GPG的gpg代理]" \
        "60" "gradle:为[Gradle]添加别名和补全功能" \
        "61" "grails:为[Grails 2 CLI]添加补全功能" \
        "62" "grunt:为[grunt]添加补全功能" \
        "63" "gulp:为[gulp]任务添加自动补全功能，从当前目录的gulpfile.js中获取所有可用任务" \
        3>&1 1>&2 2>&3)
    #已廢棄插件        "55" "git-remote-branch:为[grb]添加补全内容" \
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01)
        TMOE_ZSH_GREP_NAME='dash'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds command line functionality for [Dash](https://kapeli.com/dash),--an API Documentation Browser for macOS. This plugin requires Dash to be installed  to work.'
        ;;
    02)
        TMOE_ZSH_GREP_NAME='debian'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides Debian-related aliases and functions for zsh.'
        ;;
    03)
        TMOE_ZSH_GREP_NAME='dircycle'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for cycling through the directory stack.This plugin enables directory navigation similar to using back and forward on browsers or common file explorers like Finder or Nautilus. It uses a small zle trick that lets you cycle through your directory stack left or right using <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Left</kbd> / <kbd>Right</kbd> . This is useful when moving back and forth between directories in development environments, and can be thought of as kind of a nondestructive pushd/popd.'
        ;;
    04)
        TMOE_ZSH_GREP_NAME='direnv'
        TMOE_ZSH_COMMENT_CONTENT='This plugin creates the [Direnv](https://direnv.net/) hook.'
        ;;
    05)
        TMOE_ZSH_GREP_NAME='dirhistory'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds keyboard shortcuts for navigating directory history and hierarchy.'
        ;;
    06)
        TMOE_ZSH_GREP_NAME='dirpersist'
        TMOE_ZSH_COMMENT_CONTENT='This plugin keeps a running tally of the previous 20 unique directories in the `$HOME/.zdirs` file.-When you cd to a new directory, it is prepended to the beginning of the file.-'
        ;;
    07)
        TMOE_ZSH_GREP_NAME='django'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion and hints for the [Django Project](https://www.djangoproject.com/) `manage.py` commands-and options.-'
        ;;
    08)
        TMOE_ZSH_GREP_NAME='dnf'
        TMOE_ZSH_COMMENT_CONTENT='This plugin makes `dnf` usage easier by adding aliases for the most common commands.'
        ;;
    09)
        TMOE_ZSH_GREP_NAME='dnote'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds auto-completion for [Dnote](https://dnote.io) project.'
        ;;
    10)
        TMOE_ZSH_GREP_NAME='docker'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds auto-completion for [docker](https://www.docker.com/).'
        ;;
    11)
        TMOE_ZSH_GREP_NAME='docker-compose'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [docker-compose](https://docs.docker.com/compose/) as well as some-aliases for frequent docker-compose commands.-'
        ;;
    12)
        TMOE_ZSH_GREP_NAME='docker-machine'
        TMOE_ZSH_COMMENT_CONTENT='docker-vm：Will create a docker-machine with the name "dev" (required only once).To create a second machine call "docker-vm foobar" or pass any other name.docker-up :This will start your "dev" docker-machine (if necessary) and set it as the active one .To start a named machine use "docker-up foobar"'
        ;;
    13)
        TMOE_ZSH_GREP_NAME='doctl'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Doctl](https://github.com/digitalocean/doctl).'
        ;;
    14)
        TMOE_ZSH_GREP_NAME='dotenv'
        TMOE_ZSH_COMMENT_CONTENT='Automatically load your project ENV variables from `.env` file when you `cd` into project root directory.'
        ;;
    15)
        TMOE_ZSH_GREP_NAME='dotnet'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion and useful aliases for [.NET Core CLI](https://dotnet.microsoft.com/).'
        ;;
    16)
        TMOE_ZSH_GREP_NAME='droplr'
        TMOE_ZSH_COMMENT_CONTENT='Use [Droplr](https://droplr.com/) from the command line to upload files and shorten-links. It needs to have [Droplr.app](https://droplr.com/apps) installed and logged-'
        ;;
    17)
        TMOE_ZSH_GREP_NAME='drush'
        TMOE_ZSH_COMMENT_CONTENT='This plugin offers aliases and functions to make the work with drush easier and more productive.-'
        ;;
    18)
        TMOE_ZSH_GREP_NAME='eecms'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds auto-completion of console commands for [`eecms`](https://github.com/ExpressionEngine/ExpressionEngine).'
        ;;
    19)
        TMOE_ZSH_GREP_NAME='emacs'
        TMOE_ZSH_COMMENT_CONTENT='This plugin utilizes the Emacs daemon capability, allowing the user to quickly open frames, whether they are opened in a terminal via a ssh connection, or X frames opened on the same host. The plugin also provides some aliases for such operations.'
        ;;
    20)
        TMOE_ZSH_GREP_NAME='ember-cli'
        TMOE_ZSH_SETTINGS_MODEL='03'
        TMOE_IMPORTANT_TIPS=$(
            cat <<-EOF
    如需运行本插件，那么请在安装完nodejs和npm后执行以下命令
    ${GREEN}npm install${RESET} -g ${BLUE}ember-cli${RESET}
EOF
        )
        TMOE_ZSH_COMMENT_CONTENT='alias es="ember serve" eb="ember build"'
        ;;
    21)
        TMOE_ZSH_GREP_NAME='emoji'
        TMOE_ZSH_COMMENT_CONTENT='Support for conveniently working with Unicode emoji in Zsh.'
        ;;
    22)
        TMOE_ZSH_GREP_NAME='emoji-clock'
        TMOE_ZSH_COMMENT_CONTENT='The plugin displays current time as an emoji symbol with half hour accuracy.'
        ;;
    23)
        TMOE_ZSH_GREP_NAME='emotty'
        TMOE_ZSH_COMMENT_CONTENT='This plugin returns an emoji for the current $TTY number so it can be used-in a prompt.-'
        ;;
    24)
        TMOE_ZSH_GREP_NAME='encode64'
        TMOE_ZSH_COMMENT_CONTENT='Alias plugin for encoding or decoding using `base64` command.'
        ;;
    25)
        TMOE_ZSH_GREP_NAME='extract'
        TMOE_ZSH_COMMENT_CONTENT='This plugin defines a function called `extract` that extracts the archive file-you pass it, and it supports a wide variety of archive filetypes.-'
        ZINIT_SPECIAL_LOADING_CONTENT='zinit ice lucid wait="1" pick"extract.plugin.zsh" && zinit light _local/extract && zinit ice lucid as"completion" wait="1" && zinit snippet ${HOME}/.zinit/plugins/_local---extract/_extract #解压插件，输x 压缩包名称（例如`x 233.7z`或`x 233.tar.xz`) 即可解压文件。This plugin defines a function called `extract` that extracts the archive file you pass it, and it supports a wide variety of archive filetypes.'
        ;;
    26)
        TMOE_ZSH_GREP_NAME='fabric'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Fabric](https://www.fabfile.org/).'
        ;;
    27)
        TMOE_ZSH_GREP_NAME='fancy-ctrl-z'
        TMOE_ZSH_COMMENT_CONTENT='I frequently need to execute random commands in my shell. To achieve it I pause -Vim by pressing Ctrl-z, type command and press fg<Enter> to switch back to Vim.-'
        ;;
    28)
        TMOE_ZSH_GREP_NAME='fasd'
        TMOE_ZSH_COMMENT_CONTENT='[`Fasd`](https://github.com/clvv/fasd) (pronounced similar to "fast") is a command-line productivity booster. Fasd offers quick access to files and directories for POSIX shells.'
        ;;
    29)
        TMOE_ZSH_GREP_NAME='fastfile'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds a way to reference certain files or folders used frequently using-a global alias or shortcut.-'
        ;;
    30)
        TMOE_ZSH_GREP_NAME='fbterm'
        TMOE_ZSH_COMMENT_CONTENT='This plugin automatically starts [fbterm](https://github.com/zhangyuanwei/fbterm)-if on a real TTY (`/dev/tty`).-'
        ;;
    31)
        TMOE_ZSH_GREP_NAME='fd'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the file search tool [`fd`](https://github.com/sharkdp/fd), also known as `fd-find`.'
        ;;
    32)
        TMOE_ZSH_GREP_NAME='firewalld'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some aliases and functions for FirewallD using the `firewalld-cmd` command. To use it, add firewalld to your plugins array.'
        ;;
    33)
        TMOE_ZSH_GREP_NAME='flutter'
        TMOE_ZSH_COMMENT_CONTENT='The Flutter plugin provides completion and useful aliases'
        ;;
    34)
        TMOE_ZSH_GREP_NAME='forklift'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for ForkLift, an FTP application for OS X.'
        ;;
    35)
        TMOE_ZSH_GREP_NAME='fossil'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion support and prompt for fossil repositories.-The prompt will display the current branch and status been dirty or clean.-'
        ;;
    36)
        TMOE_ZSH_GREP_NAME='frontend-search'
        TMOE_ZSH_COMMENT_CONTENT='Searches for your frontend web development made easier'
        ;;
    37)
        TMOE_ZSH_GREP_NAME='fzf'
        TMOE_ZSH_COMMENT_CONTENT='This plugin enables [junegunn’s fzf](https://github.com/junegunn/fzf) fuzzy auto-completion and key bindings'
        ;;
    38)
        TMOE_ZSH_GREP_NAME='gas'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletion for the [gas](http://walle.github.com/gas) command,-a utility to manage Git authors.-'
        ;;
    39)
        TMOE_ZSH_GREP_NAME='gatsby'
        TMOE_ZSH_COMMENT_CONTENT=' Adds autocomplete options for all gatsby commands.'
        ;;
    40)
        TMOE_ZSH_GREP_NAME='gb'
        TMOE_ZSH_COMMENT_CONTENT='A project based build tool for the Go programming language.'
        ;;
    41)
        TMOE_ZSH_GREP_NAME='gcloud'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion support for the-[Google Cloud SDK CLI](https://cloud.google.com/sdk/gcloud/).-'
        ;;
    42)
        TMOE_ZSH_GREP_NAME='geeknote'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides autocompletion for [Geeknote](https://github.com/VitaliyRodnenko/geeknote)-and an alias for `geeknote` called `gn`.-'
        ;;
    43)
        TMOE_ZSH_GREP_NAME='gem'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completions and aliases for [Gem](https://rubygems.org/). The completions include the common `gem` subcommands as well as the installed gems in the current directory.'
        ;;
    44)
        TMOE_ZSH_GREP_NAME='git'
        TMOE_ZSH_COMMENT_CONTENT='The git plugin provides many [aliases](#aliases) and a few useful [functions](#functions).'
        ZINIT_SPECIAL_LOADING_CONTENT='zinit ice lucid pick"git.plugin.zsh" wait="1" && zinit light _local/git #git的一些alias,例如将git clone简化为gcl.  The git plugin provides many aliases and a few useful functions.'
        ;;
    45)
        TMOE_ZSH_GREP_NAME='git-auto-fetch'
        TMOE_ZSH_COMMENT_CONTENT='Automatically fetches all changes from all remotes while you are working in git-initialized directory.'
        ;;
    46)
        TMOE_ZSH_GREP_NAME='git-escape-magic'
        TMOE_ZSH_COMMENT_CONTENT='This plugin is copied from the original at-https://github.com/knu/zsh-git-escape-magic. '
        ;;
    47)
        TMOE_ZSH_GREP_NAME='git-extras'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion definitions for some of the commands defined by [git-extras](https://github.com/tj/git-extras).'
        ;;
    48)
        TMOE_ZSH_GREP_NAME='gitfast'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion and aliases for the [`git-flow` command](https://github.com/nvie/gitflow).'
        ;;
    49)
        TMOE_ZSH_GREP_NAME='git-flow'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the [git-flow (AVH Edition)](https://github.com/petervanderdoes/gitflow-avh).-The AVH Edition of the git extensions that provides high-level repository operations for [Vincent Driessen’s branching model](https://nvie.com/posts/a-successful-git-branching-model/).-'
        ;;
    50)
        TMOE_ZSH_GREP_NAME='git-flow-avh'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [HubFlow](https://datasift.github.io/gitflow/) (GitFlow for GitHub), as well as some-aliases for common commands. HubFlow is a git extension to make it easy to use GitFlow with GitHub. '
        ;;
    51)
        TMOE_ZSH_GREP_NAME='github'
        TMOE_ZSH_COMMENT_CONTENT='A `zsh` prompt that displays information about the current git repository. In particular:-the branch name, difference with remote branch, number of files staged or changed, etc.-'
        ;;
    52)
        TMOE_ZSH_GREP_NAME='git-hubflow'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for Git, using the zsh completion from git.git folks, which is much faster than the official one from zsh. A lot of zsh-specific features are not supported, like descriptions for every argument, but everything the bash completion has, this one does too (as it is using it behind the scenes). Not only is it faster, it should be more robust, and updated regularly to the latest git upstream version.'
        ;;
    53)
        TMOE_ZSH_GREP_NAME='gitignore'
        TMOE_ZSH_COMMENT_CONTENT='This plugin supports working with GitHub from the command line.'
        ;;
    54)
        TMOE_ZSH_GREP_NAME='git-prompt'
        TMOE_ZSH_COMMENT_CONTENT='This plugin enables you the use of [gitignore.io](https://www.gitignore.io/) from the command line. You need an active internet connection.'
        ;;
    55)
        TMOE_ZSH_GREP_NAME='glassfish'
        TMOE_ZSH_COMMENT_CONTENT='The glassfish plugin adds completion for the `asadmin` utility, a command to manage-[Oracle GlassFish](https://docs.oracle.com/cd/E18930_01/html/821-2416/giobi.html) servers.-'
        ;;
    56)
        TMOE_ZSH_GREP_NAME='globalias'
        TMOE_ZSH_COMMENT_CONTENT='Expands all glob expressions, subcommands and aliases (including global).'
        ;;
    57)
        TMOE_ZSH_GREP_NAME='gnu-utils'
        TMOE_ZSH_COMMENT_CONTENT='This plugin binds GNU coreutils to their default names, so that you don’t have-to call them using their prefixed name, which starts with `g`. '
        ;;
    58)
        TMOE_ZSH_GREP_NAME='golang'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the [Go Programming Language](https://golang.org/),-as well as some aliases for common Golang commands.-'
        ;;
    59)
        TMOE_ZSH_GREP_NAME='gpg-agent'
        TMOE_ZSH_COMMENT_CONTENT='Enables [GPG’s gpg-agent](https://www.gnupg.org/documentation/manuals/gnupg/) if it is not running.'
        ;;
    60)
        TMOE_ZSH_GREP_NAME='gradle'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completions and aliases for [Gradle](https://gradle.org/).'
        ;;
    61)
        TMOE_ZSH_GREP_NAME='grails'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the [Grails 2 CLI](https://grails.github.io/grails2-doc/2.5.x/guide/commandLine.html)'
        ;;
    62)
        TMOE_ZSH_GREP_NAME='grunt'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completions for [grunt](https://github.com/gruntjs/grunt).'
        ;;
    63)
        TMOE_ZSH_GREP_NAME='gulp'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletion for your [`gulp`](https://gulpjs.com/) tasks. It grabs all available tasks from the `gulpfile.js` in the current directory.'
        ;;
    esac
    ##############################
    case_tmoe_zsh_settings_model
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
tmoe_zsh_plugin_menu_03() {
    TMOE_ZSH_SETTINGS_MODEL='01'
    RETURN_TO_WHERE='tmoe_zsh_plugin_menu_03'
    TMOE_OPTION=$(whiptail --title "list of plugins" --menu "Which plugin do you want to choose?" 0 50 0 \
        "00" "🌚 Return to previous menu 返回上级菜单" \
        "01" "hanami:受到了Rails插件的启发,让人感到宾至如归的插件" \
        "02" "helm:可为Kubernetes软件包管理器[Helm]添加补全功能" \
        "03" "heroku:为[Heroku CLI]提供了补全功能" \
        "04" "history:提供一些方便的别名,以便使用history命令检查您的命令行历史记录" \
        "05" "history-substring-search:这是[Fish shell]的历史记录搜索的整洁呈现" \
        "06" "hitokoto:显示摘自[hitokoto.cn]的(随机)一言" \
        "07" "homestead:为[Homestead]提供了补全功能" \
        "08" "httpie:为命令行HTTP [HTTPie]添加了补全功能" \
        "09" "ionic:为[Ionic CLI]添加了补全内容" \
        "10" "iterm2:添加了一些[iTerm2]有用的功能" \
        "11" "jake-node:为[Jake]提供了补全功能" \
        "12" "jenv:[jenv]Java版本管理器" \
        "13" "jfrog:提供了[JFrog CLI]的补全功能" \
        "14" "jhbuild:添加了一些[JHBuild]别名" \
        "15" "jira:JIRA交互CLI" \
        "16" "jruby:为[JRuby]添加了别名" \
        "17" "jsontools:方便的命令行工具,用于处理json数据" \
        "18" "jump:允许通过手动添加标记来实现在文件系统中跳转" \
        "19" "kate:为[Kate编辑器]添加了别名" \
        "20" "keychain:自动启动[keychain]" \
        "21" "kitchen:增加了对[Test Kitchen]的补全支持" \
        "22" "knife:为命令行工具[knife]添加了补全功能" \
        "23" "knife_ssh:添加了一个knife_ssh函数以及补全功能" \
        "24" "kops:为[kops]提供了补全功能" \
        "25" "kubectl:为[Kubernetes集群管理器]添加了补全功能" \
        "26" "kube-ps1:将Kubectl上配置的Kubernetes历史记录和名称空间添加到zsh提示字符串中" \
        "27" "laravel:为Laravel [Artisan]命令行界面添加了别名和自动补全功能" \
        "28" "laravel4:为[Laravel 4]常用命令添加了一些别名" \
        "29" "laravel5:为[Laravel 5]常用命令添加了一些别名" \
        "30" "last-working-dir:跟踪上次使用的工作目录并自动跳入该目录" \
        "31" "lein:为[Leiningen]Clojure构建工具添加了补全功能" \
        "32" "lighthouse:添加了用于管理[Lighthouse]的命令" \
        "33" "lol:添加了catspeak的别名" \
        "34" "lxd:提供[lxd]的别名和补全功能" \
        "35" "macports:为软件包管理器[Macports]添加了补全内容" \
        "36" "magic-enter:通过将常用命令绑定到该插件,使您的回车键具有魔力" \
        "37" "man:添加了在上一个命令前插入man的快捷方式" \
        "38" "marked2:Mac OS X上的Markdown文件预览器" \
        "39" "mercurial:添加了一些方便的别名来使用Mercurial" \
        "40" "meteor:提供了许多meteor命令的别名" \
        "41" "microk8s:为[MicroK8s]提供了补全功能和有用的别名" \
        "42" "minikube:为[minikube]提供了补全功能" \
        "43" "mix:为[Elixir的Mix构建工具]添加了补全功能" \
        "44" "mix-fast:快速混合自动补全插件" \
        "45" "mosh:补全[mosh]主机名的SSH选项" \
        "46" "mvn:提供了许多有用的别名以及[Apache Maven]mvn命令 " \
        "47" "mysql-macports:为macOS上使用[MacPorts]安装的[MySQL]添加别名" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01)
        TMOE_ZSH_GREP_NAME='hanami'
        TMOE_ZSH_COMMENT_CONTENT='It’s inspired by Rails plugin, so if you’ve used it, you’ll feel like home.'
        ;;
    02)
        TMOE_ZSH_GREP_NAME='helm'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [Helm](https://helm.sh/), the Kubernetes package manager.'
        ;;
    03)
        TMOE_ZSH_GREP_NAME='heroku'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli).'
        ;;
    04)
        TMOE_ZSH_GREP_NAME='history'
        TMOE_ZSH_COMMENT_CONTENT='Provides a couple of convenient aliases for using the `history` command to examine your command line history.'
        ;;
    05)
        TMOE_ZSH_GREP_NAME='history-substring-search'
        TMOE_ZSH_COMMENT_CONTENT='This is a clean-room implementation of the [Fish shell][1]’s history search-feature, where you can type in any part of any command from history '
        ;;
    06)
        TMOE_ZSH_GREP_NAME='hitokoto'
        TMOE_ZSH_COMMENT_CONTENT='Displays a random quote taken from [hitokoto.cn](https://v1.hitokoto.cn/)'
        ;;
    07)
        TMOE_ZSH_GREP_NAME='homestead'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Homestead](https://laravel.com/docs/homestead).'
        ;;
    08)
        TMOE_ZSH_GREP_NAME='httpie'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [HTTPie](https://httpie.org), a command line HTTP-client, a friendlier cURL replacement.-'
        ;;
    09)
        TMOE_ZSH_GREP_NAME='ionic'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the [Ionic CLI](https://ionicframework.com/docs/cli),-as well as some aliases for common Ionic commands.-'
        ;;
    10)
        TMOE_ZSH_GREP_NAME='iterm2'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds a few functions that are useful when using [iTerm2](https://www.iterm2.com/).'
        ;;
    11)
        TMOE_ZSH_GREP_NAME='jake-node'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Jake](http://jakejs.com/).'
        ;;
    12)
        TMOE_ZSH_GREP_NAME='jenv'
        TMOE_ZSH_COMMENT_CONTENT='[jenv](https://www.jenv.be/) is a Java version manager similiar to [rbenv](https://github.com/rbenv/rbenv)-and [pyenv](https://github.com/yyuu/pyenv).-'
        ;;
    13)
        TMOE_ZSH_GREP_NAME='jfrog'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [JFrog CLI](https://github.com/jfrog/jfrog-cli).'
        ;;
    14)
        TMOE_ZSH_GREP_NAME='jhbuild'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some [JHBuild](https://developer.gnome.org/jhbuild/) aliases.'
        ;;
    15)
        TMOE_ZSH_GREP_NAME='jira'
        TMOE_ZSH_COMMENT_CONTENT='CLI support for JIRA interaction'
        ;;
    16)
        TMOE_ZSH_GREP_NAME='jruby'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds aliases for [JRuby](https://www.jruby.org/).'
        ;;
    17)
        TMOE_ZSH_GREP_NAME='jsontools'
        TMOE_ZSH_COMMENT_CONTENT='Handy command line tools for dealing with json data.'
        ;;
    18)
        TMOE_ZSH_GREP_NAME='jump'
        TMOE_ZSH_COMMENT_CONTENT='This plugin allows to easily jump around the file system by manually adding marks.-Those marks are stored as symbolic links in the directory `$MARKPATH` (default `$HOME/.marks`)-'
        ;;
    19)
        TMOE_ZSH_GREP_NAME='kate'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds aliases for the [Kate editor](https://kate-editor.org).'
        ;;
    20)
        TMOE_ZSH_GREP_NAME='keychain'
        TMOE_ZSH_COMMENT_CONTENT='This plugin starts automatically [`keychain`](https://www.funtoo.org/Keychain)-to set up and load whichever credentials you want for both gpg and ssh-'
        ;;
    21)
        TMOE_ZSH_GREP_NAME='kitchen'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion support for the [Test Kitchen](https://kitchen.ci).'
        ;;
    22)
        TMOE_ZSH_GREP_NAME='knife'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [knife](https://docs.chef.io/knife.html), a command-line tool-to interact with [Chef](https://chef.io), a platform to automate and manage infrastructure via-'
        ;;
    23)
        TMOE_ZSH_GREP_NAME='knife_ssh'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds a `knife_ssh` function as well as completion for it, to allow-connecting via ssh to servers managed with [Chef](https://www.chef.io/).-'
        ;;
    24)
        TMOE_ZSH_GREP_NAME='kops'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [kops](https://github.com/kubernetes/kops) (Kubernetes Operations),-the command line interface to get a production grade Kubernetes cluster up and running.-'
        ;;
    25)
        TMOE_ZSH_GREP_NAME='kubectl'
        TMOE_ZSH_COMMENT_CONTENT='-A script that lets you add the current Kubernetes context and namespace-'
        ;;
    26)
        TMOE_ZSH_GREP_NAME='kube-ps1'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the [Kubernetes cluster manager](https://kubernetes.io/docs/reference/kubectl/kubectl/),-as well as some aliases for common kubectl commands.-'
        ;;
    27)
        TMOE_ZSH_GREP_NAME='laravel'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds aliases and autocompletion for Laravel [Artisan](https://laravel.com/docs/artisan) and [Bob](http://daylerees.github.io/laravel-bob/) command-line interfaces.'
        ;;
    28)
        TMOE_ZSH_GREP_NAME='laravel4'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some aliases for common [Laravel 4](https://laravel.com/docs/4.2) commands.'
        ;;
    29)
        TMOE_ZSH_GREP_NAME='laravel5'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some aliases for common [Laravel 5](https://laravel.com/docs) commands.'
        ;;
    30)
        TMOE_ZSH_GREP_NAME='last-working-dir'
        TMOE_ZSH_COMMENT_CONTENT='Keeps track of the last used working directory and automatically jumps into it-for new shells, unless:-'
        ;;
    31)
        TMOE_ZSH_GREP_NAME='lein'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completions for the [Leiningen](https://leiningen.org/) Clojure build tool.'
        ;;
    32)
        TMOE_ZSH_GREP_NAME='lighthouse'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds commands to manage [Lighthouse](https://lighthouseapp.com/).'
        ;;
    33)
        TMOE_ZSH_GREP_NAME='lol'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for adding catspeak aliases, because why not.'
        ;;
    34)
        TMOE_ZSH_GREP_NAME='lxd'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [lxd](https://linuxcontainers.org/lxd/), as well as aliases-for frequent lxc commands.-'
        ;;
    35)
        TMOE_ZSH_GREP_NAME='macports'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the package manager [Macports](https://macports.com/),-as well as some aliases for common Macports commands.-'
        ;;
    36)
        TMOE_ZSH_GREP_NAME='magic-enter'
        TMOE_ZSH_COMMENT_CONTENT='This plugin makes your enter key magical, by binding commonly used commands to it.'
        ;;
    37)
        TMOE_ZSH_GREP_NAME='man'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds a shortcut to insert man before the previous command.'
        ;;
    38)
        TMOE_ZSH_GREP_NAME='marked2'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for Marked 2, a previewer for Markdown files on Mac OS X '
        ;;
    39)
        TMOE_ZSH_GREP_NAME='mercurial'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some handy aliases for using Mercurial as well as a few-utility and prompt functions that can be used in a theme.-'
        ;;
    40)
        TMOE_ZSH_GREP_NAME='meteor'
        TMOE_ZSH_COMMENT_CONTENT='The [meteor plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/meteor) provides many-[useful aliases](#aliases) as well as completion for the `meteor` command.-'
        ;;
    41)
        TMOE_ZSH_GREP_NAME='microk8s'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion and useful aliases for [MicroK8s](https://microk8s.io/).'
        ;;
    42)
        TMOE_ZSH_GREP_NAME='minikube'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [minikube](https://github.com/kubernetes/minikube).'
        ;;
    43)
        TMOE_ZSH_GREP_NAME='mix'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completions for the [Elixir’s Mix build tool](https://hexdocs.pm/mix/Mix.html).'
        ;;
    44)
        TMOE_ZSH_GREP_NAME='mix-fast'
        TMOE_ZSH_COMMENT_CONTENT='Fast mix autocompletion plugin.'
        ;;
    45)
        TMOE_ZSH_GREP_NAME='mosh'
        TMOE_ZSH_COMMENT_CONTENT='This plugin allows SSH tab completion for [mosh](https://mosh.org/) hostnames.'
        ;;
    46)
        TMOE_ZSH_GREP_NAME='mvn'
        TMOE_ZSH_COMMENT_CONTENT='The mvn plugin provides many [useful aliases](#aliases) as well as completion for-the [Apache Maven](https://maven.apache.org/) command (`mvn`).-'
        ;;
    47)
        TMOE_ZSH_GREP_NAME='mysql-macports'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds aliases for some of the commonly used [MySQL](https://www.mysql.com/) commands when installed using [MacPorts](https://www.macports.org/) on macOS.'
        ;;
    esac
    ##############################
    case_tmoe_zsh_settings_model
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
tmoe_zsh_plugin_menu_04() {
    TMOE_ZSH_SETTINGS_MODEL='01'
    RETURN_TO_WHERE='tmoe_zsh_plugin_menu_04'
    TMOE_OPTION=$(whiptail --title "list of plugins" --menu "Which plugin do you want to choose?" 0 50 0 \
        "00" "🌚 Return to previous menu 返回上级菜单" \
        "01" "n98-magerun:适用于Magento开发人员,系统管理员和开发人员的瑞士军刀" \
        "02" "nanoc:为[Nanoc]的常用命令添加了一些别名和自动补全功能" \
        "03" "ng:为[Angular的CLI]添加了自动补全支持" \
        "04" "nmap:为[Nmap]添加一些有用的别名,类似于zenmap中的配置文件" \
        "05" "node:添加了node-docs功能,可在[Node.js]中打开特定文档" \
        "06" "nomad:为[Nomad]提供了一个简单的自动补全功能,可轻松部署任何规模的应用程序" \
        "07" "npm:npm插件提供了补全功能,并添加了许多有用的别名" \
        "08" "npx:会自动注册npx命令未找到的程序" \
        "09" "nvm:为[nvm](Node.js版本管理器)添加自动补全功能" \
        "10" "oc:为[OC]命令提供自动补全功能,可构建,管理和更新操作" \
        "11" "osx:提供了一些macOS实用函数" \
        "12" "otp:使用[oathtool]创建一次性密码" \
        "13" "pass:为[pass]密码管理器提供了补全功能" \
        "14" "paver:为[Paver]的paver命令行工具添加了补全功能" \
        "15" "pep8:为[pep8]添加了补全功能" \
        "16" "percol:为[percol]提供一些有用的功能" \
        "17" "per-directory-history:[jimhester]的捆绑包,添加了zsh的每个目录及全局历史记录,并可以使用键盘快捷键切换" \
        "18" "perl:为[perl]添加了一些有用的别名和功能" \
        "19" "perms:可快速处理Unix文件系统权限" \
        "20" "phing:为[phing]目标添加自动补全功能" \
        "21" "pip:为[pip]添加补全功能" \
        "22" "pipenv:简化Pipenv的使用" \
        "23" "pj:pj插件(Project Jump)允许您定义几个文件夹来存储项目,以便您可以快速跳转" \
        "24" "please:支持流行语言,几乎可以自动化完成构建过程,着重于高性能,可扩展性和可复制性" \
        "25" "pod:为[CocoaPods]添加补全功能" \
        "26" "postgres:为Postgres命令添加了一些有用的别名" \
        "27" "pow:为[pow]添加了补全功能" \
        "28" "powder:为[powder]提供了补全功能" \
        "29" "powify:为[powify]添加了自动补全功能" \
        "30" "profiles:允许您为基于zsh的文件中创建单独的配置文件" \
        "31" "pyenv:简单的Python版本管理系统,还会加载pyenv-virtualenv来管理virtualenv的插件" \
        "32" "pylint:为[Pylint]添加了别名和自动补全功能" \
        "33" "python:为[python]命令添加了几个有用的别名" \
        "34" "rails:为[Ruby On Rails Framework]添加补全功能,以及一些日志和环境变量的别名" \
        "35" "rake:增加了对[rake](Ruby)的支持" \
        "36" "rake-fast:快速的rake自动补全插件" \
        "37" "rand-quote:显示来自[quotationspage.com]的随机引用(random quote)" \
        "38" "rbenv:提供rbenv_prompt_info,可以将其添加到您的主题中to include Ruby" \
        "39" "react-native:为[react-native]添加补全功能" \
        "40" "rebar:为[rebar] Erlang构建工具添加了补全功能" \
        "41" "redis-cli:基于Homebrew,添加了[redis-cli]的补全功能" \
        "42" "repo:主要添加了一些别名,并支持自动补全[git-repo命令行工具]" \
        "43" "ripgrep:为文本搜索工具[ripgrep](也称为rg)添加了补全功能" \
        "44" "ros:为[Roswell]添加了补全功能和别名" \
        "45" "rsync:为[rsync]的常用命令添加别名" \
        "46" "ruby:为[Ruby]的常用命令添加了别名" \
        "47" "rust:为Rust编程语言的编译器[rustc]添加了补全功能" \
        "48" "rustup:为[rustup](Rust编程语言的工具链安装程序)添加了补全功能" \
        "49" "rvm:为[Ruby Version Manager]添加了一些实用函数和补全功能" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01)
        TMOE_ZSH_GREP_NAME='n98-magerun'
        TMOE_ZSH_COMMENT_CONTENT='The swiss army knife for Magento developers, sysadmins and devops. The tool provides a huge set of well tested command line commands which save hours of work time.'
        ;;
    02)
        TMOE_ZSH_GREP_NAME='nanoc'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some aliases and autocompletion for common [Nanoc](https://nanoc.ws) commands.'
        ;;
    03)
        TMOE_ZSH_GREP_NAME='ng'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletion support for [Angular’s CLI](https://github.com/angular/angular-cli)-(named `ng`).-'
        ;;
    04)
        TMOE_ZSH_GREP_NAME='nmap'
        TMOE_ZSH_COMMENT_CONTENT='Adds some useful aliases for [Nmap](https://nmap.org/) similar to the profiles in zenmap.'
        ;;
    05)
        TMOE_ZSH_GREP_NAME='node'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds `node-docs` function that opens specific section in [Node.js](https://nodejs.org)-documentation (depending on the installed version).-'
        ;;
    06)
        TMOE_ZSH_GREP_NAME='nomad'
        TMOE_ZSH_COMMENT_CONTENT='The `nomad` plugin provides a simple autocompletion for [Nomad](https://nomadproject.io/), a tool from Hashicorp for easily deploy applications at any scale.'
        ;;
    07)
        TMOE_ZSH_GREP_NAME='npm'
        TMOE_ZSH_COMMENT_CONTENT='The npm plugin provides completion as well as adding many useful aliases.'
        ;;
    08)
        TMOE_ZSH_GREP_NAME='npx'
        TMOE_ZSH_COMMENT_CONTENT='-This plugin automatically registers npx command-not-found handler if `npx` exists in your `$PATH`.-'
        ;;
    09)
        TMOE_ZSH_GREP_NAME='nvm'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletions for [nvm](https://github.com/creationix/nvm) — a Node.js version manager.-It also automatically sources nvm, so you don’t need to do it manually in your `.zshrc`.-'
        ;;
    10)
        TMOE_ZSH_GREP_NAME='oc'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides autocompletion for [OC](https://docs.openshift.com/container-platform/3.7/cli_reference/index.html) commands, building, managing and updating operations.'
        ;;
    11)
        TMOE_ZSH_GREP_NAME='osx'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides a few utilities to make it more enjoyable on macOS (previously named OSX).'
        ;;
    12)
        TMOE_ZSH_GREP_NAME='otp'
        TMOE_ZSH_COMMENT_CONTENT='This plugin allows you to create one-time passwords using [`oathtool`](https://www.nongnu.org/oath-toolkit/man-oathtool.html),-able to replace MFA devices. The oathtool key is kept in a GPG-encrypted file so the codes-'
        ;;
    13)
        TMOE_ZSH_GREP_NAME='pass'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for the [pass](https://www.passwordstore.org/) password manager.'
        ;;
    14)
        TMOE_ZSH_GREP_NAME='paver'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the `paver` command-line tool of [Paver](https://pythonhosted.org/Paver/).'
        ;;
    15)
        TMOE_ZSH_GREP_NAME='pep8'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [pep8](https://pep8.readthedocs.io/en/release-1.7.x/#), a tool to check your Python code against some of the style conventions in [PEP 8](http://www.python.org/dev/peps/pep-0008/).'
        ;;
    16)
        TMOE_ZSH_GREP_NAME='percol'
        TMOE_ZSH_COMMENT_CONTENT='-This plugin adds per-directory history for zsh, as well as a global history,-'
        ;;
    17)
        TMOE_ZSH_GREP_NAME='per-directory-history'
        TMOE_ZSH_COMMENT_CONTENT='Provides some useful function to make [percol](https://github.com/mooz/percol) work with zsh history and [jump plugin](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/jump/jump.plugin.zsh)'
        ;;
    18)
        TMOE_ZSH_GREP_NAME='perl'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds [perl](https://www.perl.org/) useful aliases/functions.'
        ;;
    19)
        TMOE_ZSH_GREP_NAME='perms'
        TMOE_ZSH_COMMENT_CONTENT='Plugin to handle some unix filesystem permissions quickly.'
        ;;
    20)
        TMOE_ZSH_GREP_NAME='phing'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletion for [`phing`](https://github.com/phingofficial/phing) targets.'
        ;;
    21)
        TMOE_ZSH_GREP_NAME='pip'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [pip](https://pip.pypa.io/en/latest/),-the Python package manager.-'
        ;;
    22)
        TMOE_ZSH_GREP_NAME='pipenv'
        TMOE_ZSH_COMMENT_CONTENT='Installation-In your `.zshrc` file, add `pipenv` to the plugins section-'
        ;;
    23)
        TMOE_ZSH_GREP_NAME='pj'
        TMOE_ZSH_COMMENT_CONTENT='The `pj` plugin (short for `Project Jump`) allows you to define several-folders where you store your projects, so that you can jump there directly-'
        ;;
    24)
        TMOE_ZSH_GREP_NAME='please'
        TMOE_ZSH_COMMENT_CONTENT='[Please](https://please.build) is a cross-language build system with an emphasis on-high performance, extensibility and reproduceability. It supports a number of popular-'
        ;;
    25)
        TMOE_ZSH_GREP_NAME='pod'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [`CocoaPods`](https://cocoapods.org/).-CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects.-'
        ;;
    26)
        TMOE_ZSH_GREP_NAME='postgres'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some aliases for useful Postgres commands.'
        ;;
    27)
        TMOE_ZSH_GREP_NAME='pow'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion and commands for [pow](http://pow.cx/), a-zero-configuration Rack server for macOS.-'
        ;;
    28)
        TMOE_ZSH_GREP_NAME='powder'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [powder](https://github.com/powder-rb/powder/).'
        ;;
    29)
        TMOE_ZSH_GREP_NAME='powify'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletion for [powify](https://github.com/sethvargo/powify),-an easy-to-use wrapper for Basecamp’s [pow](https://github.com/basecamp/pow).-'
        ;;
    30)
        TMOE_ZSH_GREP_NAME='profiles'
        TMOE_ZSH_COMMENT_CONTENT='This plugin allows you to create separate configuration files for zsh based-on your long hostname (including the domain).-'
        ;;
    31)
        TMOE_ZSH_GREP_NAME='pyenv'
        TMOE_ZSH_COMMENT_CONTENT='This plugin looks for [pyenv](https://github.com/pyenv/pyenv), a Simple Python version-management system, and loads it if it is found. It also loads pyenv-virtualenv, a pyenv-'
        ;;
    32)
        TMOE_ZSH_GREP_NAME='pylint'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds aliases and autocompletion for [Pylint](https://www.pylint.org/),-the Python code style checking tool.-'
        ;;
    33)
        TMOE_ZSH_GREP_NAME='python'
        TMOE_ZSH_COMMENT_CONTENT='The plugin adds several aliases for useful [python](https://www.python.org/) commands.'
        ;;
    34)
        TMOE_ZSH_GREP_NAME='rails'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [Ruby On Rails Framework](https://rubyonrails.org/) and [Rake](https://ruby.github.io/rake/) commands, as well as some aliases for logs and environment variables.'
        ;;
    35)
        TMOE_ZSH_GREP_NAME='rake'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds support for [rake](https://ruby.github.io/rake/), the Ruby-build tool or Ruby Make.-'
        ;;
    36)
        TMOE_ZSH_GREP_NAME='rake-fast'
        TMOE_ZSH_COMMENT_CONTENT='Fast rake autocompletion plugin.'
        ;;
    37)
        TMOE_ZSH_GREP_NAME='rand-quote'
        TMOE_ZSH_COMMENT_CONTENT='Displays a random quote taken from [quotationspage.com](http://www.quotationspage.com/random.php)'
        ;;
    38)
        TMOE_ZSH_GREP_NAME='rbenv'
        TMOE_ZSH_COMMENT_CONTENT='The primary job of this plugin is to provide `rbenv_prompt_info` which can be added to your theme to include Ruby-version and gemset information into your prompt.-'
        ;;
    39)
        TMOE_ZSH_GREP_NAME='react-native'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [`react-native`](https://facebook.github.io/react-native/).-It also defines a few [aliases] for the commands more frequently used.-'
        ;;
    40)
        TMOE_ZSH_GREP_NAME='rebar'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completions for the [rebar](https://www.rebar3.org/) Erlang build tool.'
        ;;
    41)
        TMOE_ZSH_GREP_NAME='redis-cli'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds [redis-cli](https://redis.io/topics/rediscli) completion, based off of Homebrew completion.'
        ;;
    42)
        TMOE_ZSH_GREP_NAME='repo'
        TMOE_ZSH_COMMENT_CONTENT='This plugin mainly adds some aliases and support for automatic completion for-the [repo command line tool](https://code.google.com/p/git-repo/).-'
        ;;
    43)
        TMOE_ZSH_GREP_NAME='ripgrep'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the text search tool [`ripgrep`](https://github.com/BurntSushi/ripgrep), also known as `rg`.'
        ;;
    44)
        TMOE_ZSH_GREP_NAME='ros'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completions and aliases for [Roswell](https://github.com/roswell/roswell/).'
        ;;
    45)
        TMOE_ZSH_GREP_NAME='rsync'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds aliases for frequent [rsync](https://rsync.samba.org/) commands.'
        ;;
    46)
        TMOE_ZSH_GREP_NAME='ruby'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds aliases for common commands used in dealing with [Ruby](https://www.ruby-lang.org/en/) and [gem packages](https://rubygems.org/).'
        ;;
    47)
        TMOE_ZSH_GREP_NAME='rust'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [`rustc`](https://doc.rust-lang.org/rustc/index.html), the compiler for the Rust programming language.'
        ;;
    48)
        TMOE_ZSH_GREP_NAME='rustup'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [`rustup`](https://rustup.rs/), the toolchain installer for the Rust programming language.'
        ;;
    49)
        TMOE_ZSH_GREP_NAME='rvm'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some utility functions and completions for [Ruby Version Manager](https://rvm.io/).'
        ;;
    esac
    ##############################
    case_tmoe_zsh_settings_model
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
tmoe_zsh_plugin_menu_05() {
    TMOE_ZSH_SETTINGS_MODEL='01'
    RETURN_TO_WHERE='tmoe_zsh_plugin_menu_05'
    TMOE_OPTION=$(whiptail --title "list of plugins" --menu "Which plugin do you want to choose?" 0 50 0 \
        "00" "🌚 Return to previous menu 返回上级菜单" \
        "01" "safe-paste:在运行之前检查实际粘贴的内容,防止代码在粘贴时运行" \
        "02" "salt:A copy of the completion script from the salt" \
        "03" "sbt:为[sbt,交互式构建工具]添加了补全功能" \
        "04" "scala:[scala and scalac]命令的补全脚本" \
        "05" "scd:定义scd shell函数以更改为任何目录" \
        "06" "screen:可为[screen]设置标签的窗口标题和hardstatus" \
        "07" "scw:CLI管理Bare Metal服务器(和Docker一样简单)" \
        "08" "sdk:管理多个软件开发套件的并行版本的工具" \
        "09" "sfdx:为[Salesforce DX]CLI提供自动补全功能" \
        "10" "sfffe:可搜索前端Web开发中使用的文件" \
        "11" "shell-proxy:这是一个纯用户空间程序,用于设置shell代理" \
        "12" "shrink-path:简化路径的插件,简洁明了" \
        "13" "singlechar:为某些命令添加了一个char快捷方式" \
        "14" "spring:为所有spring boot命令添加自动补全选项" \
        "15" "sprunge:上传数据并从pastebin获取URL" \
        "16" "ssh-agent:自动启动ssh-agent并加载" \
        "17" "stack:为[Stack]提供补全功能" \
        "18" "sublime:[Sublime Text]插件,跨平台文本和代码编辑器" \
        "19" "sudo:按两次ESC键,可以在当前命令前加上sudo前缀" \
        "20" "supervisor:在[Supervisor]中为supervisord/supervisorctl添加TAB补全功能" \
        "21" "suse:为zypper命令添加一些实用的别名" \
        "22" "svcat:为[Kubernetes service catalog cli]提供了补全功能" \
        "23" "svn:添加了一些实用程序功能,以显示您当前svn存储库的其他信息" \
        "24" "svn-fast-info:更快的SVN主插件实现的替代方案,可与svn 16及更高版本一起使用" \
        "25" "swiftpm:提供了[Swift软件包管理器]和Swift 51的自动补全功能" \
        "26" "symfony:为[Symfony]提供了补全功能" \
        "27" "symfony2:提供[Symfony 2]的补全以及Symfony的常用命令的别名。" \
        "28" "systemadmin:添加了一系列别名和功能,让系统管理员的工作更加轻松惬意" \
        "29" "systemd:为systemd提供了许多有用的别名" \
        "30" "taskwarrior:为[TaskWarrior]添加了智能标签补全功能" \
        "31" "terminitor:为[Terminitor]开发工作流程设置工具添加了补全内容" \
        "32" "terraform:用于Terraform的插件,这是Hashicorp的一种工具,用于安全高效地管理基础架构" \
        "33" "textastic:Textastic插件,Mac OS X的文本和代码编辑器" \
        "34" "textmate:为[TextMate]编辑器添加了一些功能" \
        "35" "thefuck:可纠正您之前输错的命令" \
        "36" "themes:可让您随时随地更改ZSH主题" \
        "37" "thor:为[Thor]添加了补全功能" \
        "38" "tig:为[tig]添加了一些别名" \
        "39" "timer:允许以非干扰(介入)的方式显示命令的执行时间" \
        "40" "tmux:为终端多路复用器[tmux]提供别名" \
        "41" "tmux-cssh:为[tmux-cssh]添加了自动补全功能" \
        "42" "tmuxinator:为[tmuxinator]提供了补全功能" \
        "43" "torrent:通过[MagnetURI]来创建Torrent种子文件" \
        "44" "transfer:易于使用的文件共享服务" \
        "45" "tugboat:为Tugboat添加了自动补全功能,Tugboat是一款交互式命令行工具" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01)
        TMOE_ZSH_GREP_NAME='safe-paste'
        TMOE_ZSH_COMMENT_CONTENT='Preventing any code from actually running while pasting, so you have a chance to review what was actually pasted before running it.'
        ;;
    02)
        TMOE_ZSH_GREP_NAME='salt'
        TMOE_ZSH_COMMENT_CONTENT='A copy of the completion script from the-[salt](https://github.com/saltstack/salt/blob/develop/pkg/zsh_completion.zsh)-'
        ;;
    03)
        TMOE_ZSH_GREP_NAME='sbt'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the [sbt, the interactive build tool](https://scala-sbt.org/),-as well as some aliases for common sbt commands.-'
        ;;
    04)
        TMOE_ZSH_GREP_NAME='scala'
        TMOE_ZSH_COMMENT_CONTENT='Completion script for [scala and scalac](https://www.scala-lang.org/) commands.'
        ;;
    05)
        TMOE_ZSH_GREP_NAME='scd'
        TMOE_ZSH_COMMENT_CONTENT='Define `scd` shell function for changing to any directory with-a few keystrokes.-'
        ;;
    06)
        TMOE_ZSH_GREP_NAME='screen'
        TMOE_ZSH_COMMENT_CONTENT='This plugin sets title and hardstatus of the tab window for [screen](https://www.gnu.org/software/screen/),-the terminal multiplexer.-'
        ;;
    07)
        TMOE_ZSH_GREP_NAME='scw'
        TMOE_ZSH_COMMENT_CONTENT='[scw](https://github.com/scaleway/scaleway-cli): Manage Bare Metal servers from Command Line (as easily as with Docker)'
        ;;
    08)
        TMOE_ZSH_GREP_NAME='sdk'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for SDKMAN, a tool for managing parallel versions of multiple Software Development Kits on most Unix based systems.-Provides autocompletion for all known commands.-'
        ;;
    09)
        TMOE_ZSH_GREP_NAME='sfdx'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides autocompletion for the [Salesforce DX](https://developer.salesforce.com/tools/sfdxcli) CLI.'
        ;;
    10)
        TMOE_ZSH_GREP_NAME='sfffe'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds a few functions for searching files used in Front-End web development.'
        ;;
    11)
        TMOE_ZSH_GREP_NAME='shell-proxy'
        TMOE_ZSH_COMMENT_CONTENT='This a pure user-space program, shell-proxy setter, written Python3 and Bash.'
        ;;
    12)
        TMOE_ZSH_GREP_NAME='shrink-path'
        TMOE_ZSH_COMMENT_CONTENT='A plugin to shrink directory paths for brevity and pretty-printing.For a fish-style working directory in your command prompt, add the following to your theme or zshrc : setopt prompt_subst && PS1=’%n@%m $(shrink_path -f)>’'
        ;;
    13)
        TMOE_ZSH_GREP_NAME='singlechar'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds single char shortcuts (and combinations) for some commands.'
        ;;
    14)
        TMOE_ZSH_GREP_NAME='spring'
        TMOE_ZSH_COMMENT_CONTENT='Spring Boot autocomplete plugin-'
        ;;
    15)
        TMOE_ZSH_GREP_NAME='sprunge'
        TMOE_ZSH_COMMENT_CONTENT='This plugin uploads data and fetch URL from the pastebin http://sprunge.us'
        ;;
    16)
        TMOE_ZSH_GREP_NAME='ssh-agent'
        TMOE_ZSH_COMMENT_CONTENT='This plugin starts automatically `ssh-agent` to set up and load whichever-credentials you want for ssh connections.-'
        ;;
    17)
        TMOE_ZSH_GREP_NAME='stack'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Stack](https://haskellstack.org).'
        ;;
    18)
        TMOE_ZSH_GREP_NAME='sublime'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for [Sublime Text](https://www.sublimetext.com/), a cross platform text and code editor,-available for Linux, macOS, and Windows.-'
        ;;
    19)
        TMOE_ZSH_GREP_NAME='sudo'
        TMOE_ZSH_COMMENT_CONTENT='Easily prefix your current or previous commands with `sudo` by pressing <kbd>esc</kbd> twice'
        ;;
    20)
        TMOE_ZSH_GREP_NAME='supervisor'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds tab-completion for `supervisord`/`supervisorctl` in [Supervisor](http://supervisord.org/).-Supervisor is a client/server system that allows its users to monitor and control a number-'
        ;;
    21)
        TMOE_ZSH_GREP_NAME='suse'
        TMOE_ZSH_COMMENT_CONTENT='Alias for Zypper according to the official Zypper’s alias'
        ;;
    22)
        TMOE_ZSH_GREP_NAME='svcat'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for the [Kubernetes service catalog cli](https://github.com/kubernetes-incubator/service-catalog).'
        ;;
    23)
        TMOE_ZSH_GREP_NAME='svn'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some utility functions to display additional information regarding your current-svn repository. See https://subversion.apache.org/ for the full svn documentation.-'
        ;;
    24)
        TMOE_ZSH_GREP_NAME='svn-fast-info'
        TMOE_ZSH_COMMENT_CONTENT='Faster alternative to the main SVN plugin implementation. Works with svn 1.6 and newer.-Use as a drop-in replacement to the svn plugin, not as complementary.-'
        ;;
    25)
        TMOE_ZSH_GREP_NAME='swiftpm'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides a few utilities that make you faster on your daily work with the [Swift Package Manager](https://github.com/apple/swift-package-manager), as well as autocompletion for Swift 5.1.'
        ;;
    26)
        TMOE_ZSH_GREP_NAME='symfony'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Symfony](https://symfony.com/).'
        ;;
    27)
        TMOE_ZSH_GREP_NAME='symfony2'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [Symfony 2](https://symfony.com/), as well as aliases for frequent Symfony commands.'
        ;;
    28)
        TMOE_ZSH_GREP_NAME='systemadmin'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds a series of aliases and functions which make a System Administrator’s life easier.- -'
        ;;
    29)
        TMOE_ZSH_GREP_NAME='systemd'
        TMOE_ZSH_COMMENT_CONTENT='The systemd plugin provides many useful aliases for systemd.'
        ;;
    30)
        TMOE_ZSH_GREP_NAME='taskwarrior'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds smart tab completion for [TaskWarrior](https://taskwarrior.org/).-It uses the zsh tab completion script (`_task`) shipped with TaskWarrior for the-'
        ;;
    31)
        TMOE_ZSH_GREP_NAME='terminitor'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completions for the [Terminitor](https://github.com/achiurizo/terminitor) development workflow setup tool.'
        ;;
    32)
        TMOE_ZSH_GREP_NAME='terraform'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for Terraform, a tool from Hashicorp for managing infrastructure safely and efficiently.'
        ;;
    33)
        TMOE_ZSH_GREP_NAME='textastic'
        TMOE_ZSH_COMMENT_CONTENT='Plugin for Textastic, a text and code editor for Mac OS X'
        ;;
    34)
        TMOE_ZSH_GREP_NAME='textmate'
        TMOE_ZSH_COMMENT_CONTENT='The plugin adds a function for the [TextMate](https://macromates.com) editor.'
        ;;
    35)
        TMOE_ZSH_GREP_NAME='thefuck'
        TMOE_ZSH_COMMENT_CONTENT='[The Fuck](https://github.com/nvbn/thefuck) plugin — magnificent app which corrects your previous console command. You can type `pip3 install thefuck` to install dependency.'
        ;;
    36)
        TMOE_ZSH_GREP_NAME='themes'
        TMOE_ZSH_COMMENT_CONTENT='This plugin allows you to change ZSH theme on the go.'
        ;;
    37)
        TMOE_ZSH_GREP_NAME='thor'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for [Thor](http://whatisthor.com/), -a ruby toolkit for building powerful command-line interfaces.-'
        ;;
    38)
        TMOE_ZSH_GREP_NAME='tig'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds some aliases for people who work with [`tig`](https://jonas.github.io/tig/) (text-mode interface for Git) in-a regular basis. To use it, add `tig` to your plugins array:-'
        ;;
    39)
        TMOE_ZSH_GREP_NAME='timer'
        TMOE_ZSH_COMMENT_CONTENT='Timer can be tuned by these two variables:- `TIMER_PRECISION` allows to control number of decimal places (default `1`)-'
        ;;
    40)
        TMOE_ZSH_GREP_NAME='tmux'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides aliases for [tmux](https://tmux.github.io/), the terminal multiplexer.-To use it add `tmux` to the plugins array in your zshrc file.-'
        ;;
    41)
        TMOE_ZSH_GREP_NAME='tmux-cssh'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletion for [`tmux-cssh`](https://github.com/zinic/tmux-cssh/).'
        ;;
    42)
        TMOE_ZSH_GREP_NAME='tmuxinator'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides completion for [tmuxinator](https://github.com/tmuxinator/tmuxinator),-as well as aliases for frequent tmuxinator commands.-'
        ;;
    43)
        TMOE_ZSH_GREP_NAME='torrent'
        TMOE_ZSH_COMMENT_CONTENT='This plugin creates a Torrent file based on a [MagnetURI](https://en.wikipedia.org/wiki/Magnet_URI_scheme).'
        ;;
    44)
        TMOE_ZSH_GREP_NAME='transfer'
        TMOE_ZSH_COMMENT_CONTENT='[`transfer.sh`](https://transfer.sh) is an easy to use file sharing service from the command line'
        ;;
    45)
        TMOE_ZSH_GREP_NAME='tugboat'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletion for Tugboat, a command line tool for interacting with your-[DigitalOcean droplets](https://www.digitalocean.com/products/droplets/).-'
        ;;
    esac
    ##############################
    case_tmoe_zsh_settings_model
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
tmoe_zsh_plugin_menu_06() {
    TMOE_ZSH_SETTINGS_MODEL='01'
    RETURN_TO_WHERE='tmoe_zsh_plugin_menu_06'
    TMOE_OPTION=$(whiptail --title "list of plugins" --menu "Which plugin do you want to choose?" 0 50 0 \
        "00" "🌚 Return to previous menu 返回上级菜单" \
        "01" "ubuntu:为apt和apt-add-repository等常用命令添加了别名和补全功能" \
        "02" "ufw:简易方便地管理防火墙" \
        "03" "urltools:为URL编码和URL解码字符串提供了两个别名" \
        "04" "vagrant:为[Vagrant]命令,任务名称和框名称添加了自动补全功能" \
        "05" "vagrant-prompt:提示Vagrant VM的状态,支持单主机和多主机配置" \
        "06" "vim-interaction:提供了一个名为callvim的函数" \
        "07" "vi-mode:增加了类似于vi的zsh功能" \
        "08" "virtualenv:显示创建的虚拟容器的信息,并允许设定背景主题。" \
        "09" "virtualenvwrapper:加载Python的[virtualenvwrapper]shell工具" \
        "10" "vscode:简化VS Code和VSCodium编辑器的CLI交互" \
        "11" "vundle:添加了一些功能来控制vim的[vundle]插件管理器" \
        "12" "wakeonlan:wakeonlan工具的包装" \
        "13" "wd:warp directory使您无需使用cd即可跳转到zsh中的自定义目录" \
        "14" "web-search:添加了通过Google,Wiki,Bing,YouTube和其他流行服务进行搜索的别名" \
        "15" "wp-cli:添加了wp-cli(WordPress)的几个别名" \
        "16" "xcode:提供了一些实用程序,可以帮助您日常使用Xcode和iOS开发" \
        "17" "yarn:为[Yarn包管理器]添加了补全功能" \
        "18" "yii:为[yii]添加了自动补全命令和子命令" \
        "19" "yii2:为yii添加自动补全命令和子命令" \
        "20" "yum:为[Yum]命令添加了有用的别名" \
        "21" "z:z命令可以跟踪您访问次数最多的目录,并允许您快速访问它们" \
        "22" "zeus:预加载您的Rails环境,有效地加快Rails启动速度" \
        "23" "zsh-interactive-cd:为cd命令添加了类似于fish的交互式TAB补全功能" \
        "24" "zsh-navigation-tools:一组工具,例如n-history(多词历史搜索器),n-cd(目录书签管理器),还有近似匹配,高级历史记录管理" \
        "25" "zsh_reload:定义了一个函数来重新加载zsh会话" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01)
        TMOE_ZSH_GREP_NAME='ubuntu'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completions and aliases for [Ubuntu](https://www.ubuntu.com/).'
        ;;
    02)
        TMOE_ZSH_GREP_NAME='ufw'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for managing everybody’s favorite Uncomplicated Firewall (UFW),-a simple interface for managing iptables. Learn more about [`UFW`](https://wiki.ubuntu.com/UncomplicatedFirewall).-'
        ;;
    03)
        TMOE_ZSH_GREP_NAME='urltools'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides two aliases to URL-encode and URL-decode strings.'
        ;;
    04)
        TMOE_ZSH_GREP_NAME='vagrant'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds autocompletion for [Vagrant](https://www.vagrantup.com/) commands, task names, box names and built-in handy documentation.'
        ;;
    05)
        TMOE_ZSH_GREP_NAME='vagrant-prompt'
        TMOE_ZSH_COMMENT_CONTENT='-Look inside the source for documentation about custom variables. -'
        ;;
    06)
        TMOE_ZSH_GREP_NAME='vim-interaction'
        TMOE_ZSH_COMMENT_CONTENT='This plugin increase `vi-like` zsh functionality.'
        ;;
    07)
        TMOE_ZSH_GREP_NAME='vi-mode'
        TMOE_ZSH_COMMENT_CONTENT='The plugin presents a function called `callvim` whose usage is:'
        ;;
    08)
        TMOE_ZSH_GREP_NAME='virtualenv'
        TMOE_ZSH_COMMENT_CONTENT='The plugin displays information of the created virtual container and allows background theming.'
        ;;
    09)
        TMOE_ZSH_GREP_NAME='virtualenvwrapper'
        TMOE_ZSH_COMMENT_CONTENT='This plugin loads Python’s [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/) shell tools.'
        ;;
    10)
        TMOE_ZSH_GREP_NAME='vscode'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides useful aliases to simplify the interaction between the command line and VS Code or VSCodium editor.'
        ;;
    11)
        TMOE_ZSH_GREP_NAME='vundle'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds functions to control [vundle](https://github.com/VundleVim/Vundle.vim) plug-in manager for vim.'
        ;;
    12)
        TMOE_ZSH_GREP_NAME='wakeonlan'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides a wrapper around the "wakeonlan" tool available from most-distributions’ package repositories, or from [the following website](https://github.com/jpoliv/wakeonlan).-'
        ;;
    13)
        TMOE_ZSH_GREP_NAME='wd'
        TMOE_ZSH_COMMENT_CONTENT=' `wd` (*warp directory*) lets you jump to custom directories in zsh, without using `cd`.'
        ;;
    14)
        TMOE_ZSH_GREP_NAME='web-search'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds aliases for searching with Google, Wiki, Bing, YouTube and other popular services.'
        ;;
    15)
        TMOE_ZSH_GREP_NAME='wp-cli'
        TMOE_ZSH_COMMENT_CONTENT='WP-CLI is a set of command-line tools for managing WordPress installations. You can update plugins, set up multisite installs and much more, without using a web browser.'
        ;;
    16)
        TMOE_ZSH_GREP_NAME='xcode'
        TMOE_ZSH_COMMENT_CONTENT='This plugin provides a few utilities that can help you on your daily use of Xcode and iOS development.'
        ;;
    17)
        TMOE_ZSH_GREP_NAME='yarn'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds completion for the [Yarn package manager](https://yarnpkg.com/en/),-as well as some aliases for common Yarn commands.-'
        ;;
    18)
        TMOE_ZSH_GREP_NAME='yii'
        TMOE_ZSH_COMMENT_CONTENT='The plugin adds autocomplete commands and subcommands for [yii](https://www.yiiframework.com/).'
        ;;
    19)
        TMOE_ZSH_GREP_NAME='yii2'
        TMOE_ZSH_COMMENT_CONTENT=' Adds autocomplete commands and subcommands for yii.'
        ;;
    20)
        TMOE_ZSH_GREP_NAME='yum'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds useful aliases for common [Yum](http://yum.baseurl.org/) commands.'
        ;;
    21)
        TMOE_ZSH_GREP_NAME='z'
        TMOE_ZSH_SETTINGS_MODEL='02'
        ZSH_README_FILE_NAME_02='README'
        TMOE_ZSH_COMMENT_CONTENT='This plugin defines the [z command](https://github.com/rupa/z) that tracks your most visited directories and allows you to access them with very few keystrokes.'
        ZINIT_SPECIAL_LOADING_CONTENT='zinit ice lucid wait="1" pick"z.plugin.zsh" && zinit light _local/z && unsetopt BG_NICE #记录访问目录，输z获取,输`z 目录名称`快速跳转  This plugin defines the [z command](https://github.com/rupa/z) that tracks your most visited directories and allows you to access them with very few keystrokes.'
        ;;
    22)
        TMOE_ZSH_GREP_NAME='zeus'
        TMOE_ZSH_COMMENT_CONTENT='[Zeus](https://github.com/burke/zeus) preloads your Rails environment and forks that-process whenever needed. This effectively speeds up Rails’boot process to under 1 sec.-'
        ;;
    23)
        TMOE_ZSH_GREP_NAME='zsh-interactive-cd'
        TMOE_ZSH_COMMENT_CONTENT='This plugin adds a fish-like interactive tab completion for the `cd` command.'
        ;;
    24)
        TMOE_ZSH_GREP_NAME='zsh-navigation-tools'
        TMOE_ZSH_SETTINGS_MODEL='02'
        ZSH_README_FILE_NAME_02='.config/znt/README.txt'
        TMOE_ZSH_COMMENT_CONTENT='Set of tools like `n-history` – multi-word history searcher, `n-cd` – directory bookmark manager, `n-kill` – `htop` like kill utility, and more. Based on `n-list`, a tool generating selectable curses-based list of elements that has access to current `Zsh` session, i.e. has broad capabilities to work together with it. Feature highlights include incremental multi-word searching, approximate matching, ANSI coloring, themes, unique mode, horizontal scroll, grepping, advanced history management and various integrations with `Zsh`.'
        ;;
    25)
        TMOE_ZSH_GREP_NAME='zsh_reload'
        TMOE_ZSH_COMMENT_CONTENT='The zsh_reload plugin defines a function to reload the zsh session with-just a few keystrokes.'
        ;;
    esac
    ##############################
    case_tmoe_zsh_settings_model
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
tmoe_zsh_plugin_menu_07() {
    TMOE_ZSH_SETTINGS_MODEL='04'
    RETURN_TO_WHERE='tmoe_zsh_plugin_menu_07'
    TMOE_ZSH_COMMENT_CONTENT=''
    WAIT_TIME='0'
    TMOE_OPTION=$(whiptail --title "list of plugins" --menu "Which plugin do you want to choose?" 0 50 0 \
        "00" "🌚 Return to previous menu 返回上级菜单" \
        "01" "fzf-tab:通过hook zsh补全系统的底层函数来截获补全列表" \
        "02" "fast-syntax-highlighting:语法高亮插件,速度快" \
        "03" "zsh-autosuggestions:自动建议" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01)
        TMOE_ZSH_GREP_NAME='fzf-tab'
        ZINIT_SPECIAL_LOADING_CONTENT='[[ $(command -v fzf) ]] && zinit ice lucid pick"fzf-tab.zsh" && zinit light _local/fzf-tab #aloxaf:fzf-tab 是一个能够极大提升 zsh 补全体验的插件。它通过 hook zsh 补全系统的底层函数 compadd 来截获补全列表，从而实现了在补全命令行参数、变量、目录栈和文件时都能使用 fzf 进行选择的功能。Replace zsh’s default completion selection menu with fzf!'
        ZSH_README_FILE_NAME='README_CN.md'
        ZSH_README_FILE_NAME_02='README.md lib/zsh-ls-colors/README.md'
        # TMOE_IMPORTANT_TIPS=$(
        #    cat <<-EOF
        #   若本插件加载后${RED}无法${RESET}正常运行，则请前往${GREEN}FAQ${RESET}处重置插件
        #EOF
        #       )
        ;;
    02)
        TMOE_ZSH_GREP_NAME='fast-syntax-highlighting'
        ZINIT_SPECIAL_LOADING_CONTENT='zinit ice wait lucid pick"fast-syntax-highlighting.plugin.zsh" atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" && zinit light _local/fast-syntax-highlighting    #语法高亮插件，速度比zsh-syntax-highlighting更快。(Short name F-Sy-H). Syntax-highlighting for Zshell – fine granularity, number of features, 40 work hours themes.'
        #ZSH_README_FILE_NAME_02='docs/highlighters/*md tests/README.md'
        ZSH_README_FILE_NAME_02='README.md THEME_GUIDE.md'
        ;;
    03)
        TMOE_ZSH_GREP_NAME='zsh-autosuggestions'
        ZINIT_SPECIAL_LOADING_CONTENT='zinit ice wait lucid pick"zsh-autosuggestions.zsh" atload'_zsh_autosuggest_start' && zinit light _local/zsh-autosuggestions #自动建议插件 It suggests commands as you type based on history and completions.'
        TMOE_IMPORTANT_TIPS=$(
            cat <<-EOF
    ${YELLOW}https://github.com/zsh-users/zsh-autosuggestions${RESET}
EOF
        )
        ;;
    esac
    ##############################
    INSTALL_ZSH_PLUGIN="${TMOE_ZSH_GREP_NAME}"
    case_tmoe_zsh_settings_model
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
check_zsh_plugin_folder() {
    TMOE_ZSH_OPTION_01="Readme of ${TMOE_ZSH_GREP_NAME} 说明"
    ZSH_PLUGIN_DIR="${ZINIT_DIR}/plugins/_local---${TMOE_ZSH_GREP_NAME}"
    #CUSTOM_ZSH_PLUGIN_DIR="${ZINIT_DIR}/plugins/${TMOE_ZSH_GREP_NAME}"
    ZINIT_LOCAL_PLUGIN="_local/${TMOE_ZSH_GREP_NAME}"
    if [ -e "${ZSH_PLUGIN_DIR}/${TMOE_ZSH_GREP_NAME}.plugin.zsh" ]; then
        ZINIT_PICK_FILE="${TMOE_ZSH_GREP_NAME}.plugin.zsh"
    elif [ -e "${ZSH_PLUGIN_DIR}/${TMOE_ZSH_GREP_NAME}.zsh" ]; then
        ZINIT_PICK_FILE="${TMOE_ZSH_GREP_NAME}.zsh"
    else
        ZINIT_PICK_FILE=""
    fi

    if [ -e "${ZSH_PLUGIN_DIR}/_${TMOE_ZSH_GREP_NAME}" ]; then
        ZINIT_LOCAL_SNIPPET_FILE="${ZSH_PLUGIN_DIR}/_${TMOE_ZSH_GREP_NAME}"
    elif [ -e "${ZSH_PLUGIN_DIR}/_${TMOE_ZSH_GREP_NAME}.sh" ]; then
        ZINIT_LOCAL_SNIPPET_FILE="${ZSH_PLUGIN_DIR}/_${TMOE_ZSH_GREP_NAME}.sh"
    else
        ZINIT_LOCAL_SNIPPET_FILE=""
    fi
}
############
case_tmoe_zsh_settings_model() {
    case ${WAIT_TIME} in
    "") WAIT_TIME=1 ;;
    esac
    check_zsh_plugin_folder
    case "${TMOE_ZSH_SETTINGS_MODEL}" in
    01) tmoe_zsh_settings_model_01 ;;
    02) tmoe_zsh_settings_model_02 ;;
    03) tmoe_zsh_settings_model_03 ;;
    04) tmoe_zsh_settings_model_04 ;;
    esac
}
######################
check_tmoe_zsh_config_value() {
    #if ! egrep -q '^[^#]*zinit.*/fast-syntax-highlighting' "${HOME}/.zshrc"; then
    if egrep -q "^[^#]*zinit.*pick\"${TMOE_ZSH_GREP_NAME}\.(zsh|plugin.zsh)\"" "${TMOE_ZSH_FILE}"; then
        TMOE_ZSH_CONFIG_STATUS="您已启用${TMOE_ZSH_GREP_NAME}插件 You have enabled this plugin."
        TMOE_ZSH_CONFIG_ENABLED='true'
        TMOE_ZSH_CONFIG_LINE=$(cat ${TMOE_ZSH_FILE} | egrep -n "^[^#]*zinit.*pick\"${TMOE_ZSH_GREP_NAME}\.(zsh|plugin.zsh)\"" | head -n 1 | awk '{print $1}' | cut -d ':' -f 1)
    elif egrep -q "^[^#]*zinit.*snippet.*${TMOE_ZSH_GREP_NAME}/_" "${TMOE_ZSH_FILE}"; then
        TMOE_ZSH_CONFIG_STATUS="您已启用${TMOE_ZSH_GREP_NAME}插件 You have enabled this zsh plugin."
        TMOE_ZSH_CONFIG_ENABLED='yes'
        TMOE_ZSH_CONFIG_LINE=$(cat ${TMOE_ZSH_FILE} | egrep -n "^[^#]*zinit.*snippet.*${TMOE_ZSH_GREP_NAME}/_" | head -n 1 | awk '{print $1}' | cut -d ':' -f 1)
    else
        TMOE_ZSH_CONFIG_LINE=''
        TMOE_ZSH_CONFIG_STATUS="您已禁用${TMOE_ZSH_GREP_NAME}插件 You have disabled this plugin."
        TMOE_ZSH_CONFIG_ENABLED='false'
    fi
}
######################
add_new_zinit_plugin_to_zshrc_01() {
    cat >>${HOME}/.zshrc <<-EOF01
zinit ice lucid wait="${WAIT_TIME}" pick"${ZINIT_PICK_FILE}" && zinit light ${ZINIT_LOCAL_PLUGIN} #${TMOE_ZSH_COMMENT_CONTENT}
EOF01
}
#################
add_new_zinit_plugin_to_zshrc_02() {
    cat >>${HOME}/.zshrc <<-EOF02
zinit ice lucid wait="${WAIT_TIME}" pick"${ZINIT_PICK_FILE}" && zinit light ${ZINIT_LOCAL_PLUGIN} && zinit ice lucid wait="${WAIT_TIME}" as"completion" && zinit snippet ${ZINIT_LOCAL_SNIPPET_FILE}  #${TMOE_ZSH_COMMENT_CONTENT}
EOF02
}
#################
add_new_zinit_plugin_to_zshrc_03() {
    echo "${ZINIT_SPECIAL_LOADING_CONTENT}" >>${HOME}/.zshrc
}
#################
add_new_zinit_plugin_to_zshrc_04() {
    cat >>${HOME}/.zshrc <<-EOF02
zinit ice lucid wait="${WAIT_TIME}" && zinit light ${ZINIT_LOCAL_PLUGIN} && zinit ice lucid wait="${WAIT_TIME}" as"completion" && zinit snippet ${ZINIT_LOCAL_SNIPPET_FILE}  #${TMOE_ZSH_COMMENT_CONTENT}
EOF02
}
#################
case_new_zinit_plugin() {
    if [ -z "${ZINIT_PICK_FILE}" ] && [ -n ${ZINIT_LOCAL_SNIPPET_FILE} ]; then
        add_new_zinit_plugin_to_zshrc_04
    else
        case ${ZINIT_LOCAL_SNIPPET_FILE} in
        "") add_new_zinit_plugin_to_zshrc_01 ;;
        *) add_new_zinit_plugin_to_zshrc_02 ;;
        esac
    fi
}
###########
enable_zsh_plugin() {
    check_zsh_plugin_folder
    case ${TMOE_ZSH_COMMENT_CONTENT} in
    "") echo "${YELLOW}$(echo ${ZINIT_SPECIAL_LOADING_CONTENT} | sed 's@^.*#@@g')${RESET}" ;;
    *) echo "${YELLOW}${TMOE_ZSH_COMMENT_CONTENT}${RESET}" ;;
    esac

    case "${TMOE_ZSH_CONFIG_ENABLED}" in
    true | yes)
        echo "您${YELLOW}已经启用过${RESET}本插件了，不要${RED}重复启用${RESET}哦！"
        echo "若脚本检测${RED}出错${RESET}，则请${GREEN}手动修改${RESET}${BLUE}${TMOE_ZSH_FILE}${RESET}的第${TMOE_ZSH_CONFIG_LINE}行内容"
        echo "${YELLOW}Do not enable this plugin repeatedly.${RESET}"
        ;;
    false)
        #sed -i "$ a\source ${ZSH_PLUGIN_FILE}" "${TMOE_ZSH_FILE}"
        case ${ZINIT_SPECIAL_LOADING_CONTENT} in
        "") case_new_zinit_plugin ;;
        *) add_new_zinit_plugin_to_zshrc_03 ;;
        esac
        ;;
    esac
    check_tmoe_zsh_config_value
    check_zsh_plugin_content
    echo ${TMOE_ZSH_CONFIG_STATUS}
}
############
check_zsh_plugin_content() {
    ZINIT_PLUGIN_CONTENT=$(cat ${TMOE_ZSH_FILE} | sed -n ${TMOE_ZSH_CONFIG_LINE}p | sed 's@#.*@@')
    echo "${BLUE}${ZINIT_PLUGIN_CONTENT}${RESET}"
}
##########
disable_zsh_plugin() {
    check_zsh_plugin_folder
    case "${TMOE_ZSH_CONFIG_ENABLED}" in
    yes | true)
        case ${TMOE_ZSH_CONFIG_LINE} in
        "" | 0)
            echo "禁用失败，请手动编辑~/.zshrc"
            echo "Disable failed, please edit zshrc manually."
            ;;
        *) sed -i "${TMOE_ZSH_CONFIG_LINE} d" "${TMOE_ZSH_FILE}" ;;
        esac
        ;;
        #yes)
        #check_zsh_plugin_content
        #NEW_TMOE_ZSH_CONFIG_LINE_CONTENT=$(cat ${TMOE_ZSH_FILE} | sed -n ${TMOE_ZSH_CONFIG_LINE}p | sed "s@${TMOE_ZSH_GREP_NAME} @@" | sed "s@ ${TMOE_ZSH_GREP_NAME})@)@")
        #space key!
        #sed -i "${TMOE_ZSH_CONFIG_LINE} c ${NEW_TMOE_ZSH_CONFIG_LINE_CONTENT}" "${TMOE_ZSH_FILE}"
        #check_zsh_plugin_content
        #;;
    false)
        echo "您${YELLOW}已禁用${RESET}本插件，不要${RED}重复禁用${RESET}哦！"
        echo "若脚本检测${RED}出错${RESET}，则请${GREEN}手动编辑${RESET}${BLUE}${TMOE_ZSH_FILE}${RESET}"
        ;;
    esac
    check_tmoe_zsh_config_value
    echo ${TMOE_ZSH_CONFIG_STATUS}
}
###################
check_bat() {
    if [ $(command -v batcat) ]; then
        batcat ${ZSH_README_FILE_PATH} --pager "less -m -RFeQ"
    elif [ $(command -v bat) ]; then
        bat ${ZSH_README_FILE_PATH} --pager "less -m -RFeQ"
    elif [ $(command -v mdv) ]; then
        mdv ${ZSH_README_FILE_PATH}
    elif [ $(command -v less) ]; then
        less -meQ ${ZSH_README_FILE_PATH}
    else
        cat ${ZSH_README_FILE_PATH}
    fi
}
############
cat_zsh_plugin_readme_02() {
    #ZSH_README_FILE='README'
    #README_CN.md
    cd ${ZSH_PLUGIN_DIR}
    ZSH_README_FILE_PATH="${ZSH_README_FILE_NAME_02}"
    check_bat
}
################
cat_zsh_plugin_readme_01() {
    #README_CN.md
    if [ -e "${ZSH_PLUGIN_DIR}/${ZSH_README_FILE_NAME}" ]; then
        ZSH_README_FILE_PATH="${ZSH_PLUGIN_DIR}/${ZSH_README_FILE_NAME}"
    elif [ -e "${CUSTOM_ZSH_PLUGIN_DIR}/${ZSH_README_FILE_NAME}" ]; then
        ZSH_README_FILE_PATH="${CUSTOM_ZSH_PLUGIN_DIR}/${ZSH_README_FILE_NAME}"
    fi
    check_bat
}
#############
edit_zshrc_manually() {
    if [ $(command -v editor) ]; then
        editor ${HOME}/.zshrc
    elif [ $(command -v vim) ]; then
        vim ${HOME}/.zshrc
    elif [ $(command -v nano) ]; then
        nano ${HOME}/.zshrc
    else
        vi ${HOME}/.zshrc
    fi
}
###########
case_plugin_line() {
    case ${TMOE_ZSH_CONFIG_LINE} in
    "") EDIT_ZSHRC_LINE=$(echo "edit .zshrc") ;;
    *) EDIT_ZSHRC_LINE=$(echo "edit .zshrc[LINE ${TMOE_ZSH_CONFIG_LINE}]第${TMOE_ZSH_CONFIG_LINE}行") ;;
    esac
}
############
tmoe_zsh_settings_model_01() {
    #此处不要设置RETURN_TO_WHERE的变量
    check_tmoe_zsh_config_value
    case_plugin_line
    RETURN_TO_MENU='tmoe_zsh_settings_model_01'
    TMOE_OPTION=$(whiptail --title "${TMOE_ZSH_CONFIG_STATUS}" --menu "${TMOE_ZSH_COMMENT_CONTENT}" 0 50 0 \
        "0" "🌚 Return to previous menu 返回上级菜单" \
        "1" "${TMOE_ZSH_OPTION_01}" \
        "2" "Enable 启用" \
        "3" "Disable 禁用" \
        "4" "${EDIT_ZSHRC_LINE}" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    0 | "")
        ZINIT_SPECIAL_LOADING_CONTENT=''
        WAIT_TIME='1'
        ${RETURN_TO_WHERE}
        ;;
    1) cat_zsh_plugin_readme_01 ;;
    2) enable_zsh_plugin ;;
    3) disable_zsh_plugin ;;
    4) edit_zshrc_manually ;;
    esac
    ##############################
    press_enter_to_return
    tmoe_zsh_settings_model_01
}
######################
tmoe_zsh_settings_model_02() {
    check_tmoe_zsh_config_value
    case_plugin_line
    RETURN_TO_MENU='tmoe_zsh_settings_model_02'
    TMOE_OPTION=$(whiptail --title "${TMOE_ZSH_CONFIG_STATUS}" --menu "${TMOE_ZSH_COMMENT_CONTENT}" 0 50 0 \
        "0" "🌚 Return to previous menu 返回上级菜单" \
        "1" "${TMOE_ZSH_OPTION_01}" \
        "2" "Enable 启用" \
        "3" "Disable 禁用" \
        "4" "Extra note 额外说明" \
        "5" "${EDIT_ZSHRC_LINE}" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    0 | "")
        ZINIT_SPECIAL_LOADING_CONTENT=''
        WAIT_TIME='1'
        ${RETURN_TO_WHERE}
        ;;
    1) cat_zsh_plugin_readme_01 ;;
    2) enable_zsh_plugin ;;
    3) disable_zsh_plugin ;;
    4) cat_zsh_plugin_readme_02 ;;
    5) edit_zshrc_manually ;;
    esac
    ##############################
    press_enter_to_return
    tmoe_zsh_settings_model_02
}
################
pip_install_autoenv() {
    echo "${GREEN}pip3 install autoenv${RESET}"
    if [ $(command -v pip3) ]; then
        pip3 install autoenv || sudo pip3 install autoenv
    elif [ $(command -v pip) ]; then
        pip install autoenv || sudo pip install autoenv
    else
        echo "${GREEN}apt install python3-pip${RESET}"
        if [ "$(uname -o)" = "Android" ]; then
            apt update
            apt install python
        else
            sudo apt install python3-pip || sudo pacman -Syu python-pip || sudo dnf install python3-pip
            sudo pip3 install autoenv
        fi
        if [ ! $(command -v pip) ]; then
            echo "pip3 command not found."
            echo "无法安装本插件,请先安装python-pip"
            echo "例如apt install pyhon3-pip"
        fi
    fi
}
#############
git_pull_origin_master() {
    git reset --hard origin/master
    git pull --depth=1 origin master --allow-unrelated-histories
}
###########
git_clone_zsh_plugin() {
    if [ ! -d "${ZSH_PLUGIN_GIT_FOLDER}/.git" ]; then
        rm -rfv ${ZSH_PLUGIN_GIT_FOLDER} 2>/dev/null
        git clone --depth=1 ${ZSH_PLUGIN_GIT_URL_01} "${ZSH_PLUGIN_GIT_FOLDER}" || git clone --depth=1 ${ZSH_PLUGIN_GIT_URL_02} "${ZSH_PLUGIN_GIT_FOLDER}"
        chmod 755 -R "${ZSH_PLUGIN_GIT_FOLDER}"
    else
        cd "${ZSH_PLUGIN_GIT_FOLDER}"
        git_pull_origin_master
        echo "${BLUE}${ZSH_PLUGIN_GIT_URL_02}${RESET}"
    fi
}
#############
git_clone_fzf_tab() {
    if [ ! $(command -v fzf) ]; then
        apt update || sudo apt update
        apt install -y fzf || sudo apt install fzf || sudo pacman -Syu fzf || sudo dnf install fzf
    fi
    if [ ! $(command -v fzf) ]; then
        echo "检测到您尚未安装fzf,请手动使用包管理安装。"
    fi
    ZSH_PLUGIN_GIT_URL_01='https://github.com/Aloxaf/fzf-tab.git'
    ZSH_PLUGIN_GIT_URL_02='git://github.com/Aloxaf/fzf-tab.git'
    git_clone_zsh_plugin
}
###########
git_clone_fast_syntax_highlighting() {
    ZSH_PLUGIN_GIT_URL_01='https://github.com/zdharma/fast-syntax-highlighting.git'
    ZSH_PLUGIN_GIT_URL_02='git://github.com/zdharma/fast-syntax-highlighting'
    git_clone_zsh_plugin
}
################
git_clone_zsh_autosuggestions() {
    ZSH_PLUGIN_GIT_URL_01='https://github.com/zsh-users/zsh-autosuggestions'
    ZSH_PLUGIN_GIT_URL_02='git://github.com/zsh-users/zsh-autosuggestions'
    git_clone_zsh_plugin
}
##########
tmoe_zsh_plugin_install_function() {
    ZSH_PLUGIN_GIT_FOLDER="${ZINIT_DIR}/plugins/_local---${TMOE_ZSH_GREP_NAME}"
    case "${INSTALL_ZSH_PLUGIN}" in
    autoenv) pip_install_autoenv ;;
    fzf-tab) git_clone_fzf_tab ;;
    fast-syntax-highlighting) git_clone_fast_syntax_highlighting ;;
    zsh-autosuggestions) git_clone_zsh_autosuggestions ;;
    esac
}
#############
tmoe_zsh_plugin_remove_function() {
    case "${INSTALL_ZSH_PLUGIN}" in
    autoenv) pip uninstall autoenv || sudo pip uninstall autoenv || sudo pip3 uninstall autoenv ;;
    esac
}
#########
tmoe_zsh_settings_model_03() {
    check_tmoe_zsh_config_value
    case_plugin_line
    RETURN_TO_MENU='tmoe_zsh_settings_model_03'
    TMOE_OPTION=$(whiptail --title "${TMOE_ZSH_CONFIG_STATUS}" --menu "${TMOE_ZSH_COMMENT_CONTENT}" 0 50 0 \
        "0" "🌚 Return to previous menu 返回上级菜单" \
        "1" "${TMOE_ZSH_OPTION_01}" \
        "2" "Enable 启用" \
        "3" "Disable 禁用" \
        "4" "Extra note 额外说明" \
        "5" "${EDIT_ZSHRC_LINE}" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    0 | "")
        INSTALL_ZSH_PLUGIN=''
        ZINIT_SPECIAL_LOADING_CONTENT=''
        WAIT_TIME='1'
        ${RETURN_TO_WHERE}
        ;;
    1)
        cat <<-EOF
    ${TMOE_IMPORTANT_TIPS} 
EOF
        ;;
    2)
        tmoe_zsh_plugin_install_function
        enable_zsh_plugin
        ;;
    3)
        tmoe_zsh_plugin_remove_function
        disable_zsh_plugin
        ;;
    4) cat_zsh_plugin_readme_01 ;;
    5) edit_zshrc_manually ;;
    esac
    ##############################
    press_enter_to_return
    tmoe_zsh_settings_model_03
}
####################
view_extra_note_of_zsh_plugin() {
    if [ ! -z "${TMOE_IMPORTANT_TIPS}" ]; then
        cat <<-EOF
    ${TMOE_IMPORTANT_TIPS} 
EOF
    fi

    if [ ! -z "${ZSH_README_FILE_NAME_02}" ]; then
        cat_zsh_plugin_readme_02
    fi
}
##############
tmoe_zsh_settings_model_04() {
    check_tmoe_zsh_config_value
    case_plugin_line
    RETURN_TO_MENU='tmoe_zsh_settings_model_04'
    TMOE_OPTION=$(whiptail --title "您想要对${TMOE_ZSH_GREP_NAME}小可爱做什么？" --menu "${TMOE_ZSH_CONFIG_STATUS}" 0 50 0 \
        "0" "🌚 Return to previous menu 返回上级菜单" \
        "1" "${TMOE_ZSH_OPTION_01}" \
        "2" "Enable 启用" \
        "3" "Remove & disable 移除并禁用" \
        "4" "Extra note 额外说明" \
        "5" "${EDIT_ZSHRC_LINE}" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    0 | "")
        INSTALL_ZSH_PLUGIN=''
        ZINIT_SPECIAL_LOADING_CONTENT=''
        WAIT_TIME='1'
        ZSH_README_FILE_NAME='README.md'
        ZSH_README_FILE_NAME_02=''
        ${RETURN_TO_WHERE}
        ;;
    1) cat_zsh_plugin_readme_01 ;;
    2)
        tmoe_zsh_plugin_install_function
        enable_zsh_plugin
        ;;
    3)
        cat <<-EOF
        ${RED}rm -rfv${RESET} ${BLUE}${ZINIT_DIR}/plugins/_local---${TMOE_ZSH_GREP_NAME}${RESET}
        Do you want to ${RED}disable${RESET} it?
        您真的要${RED}禁用${RESET}${BLUE}${TMOE_ZSH_GREP_NAME}${RESET}插件么?
EOF
        do_you_want_to_continue_02
        cd ${HOME}
        rm -rfv "${ZINIT_DIR}/plugins/_local---${TMOE_ZSH_GREP_NAME}" 2>/dev/null
        disable_zsh_plugin
        ;;
    4) view_extra_note_of_zsh_plugin ;;
    5) edit_zshrc_manually ;;
    esac
    ##############################
    press_enter_to_return
    tmoe_zsh_settings_model_04
}
####################
####################
main "$@"
##已经废弃的插件：fedora,rbfu,vault,cloudapp,go,nyan
