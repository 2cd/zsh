#!/usr/bin/env bash
##############################################################
main() {
    terminal_color
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
tmoe_zsh_plugin_main_menu() {
    RETURN_TO_WHERE='tmoe_zsh_plugin_main_menu'
    TMOE_ZSH_FILE="${HOME}/.zshrc"
    ZSH_README_FILE_NAME='README.md'
    ZSH_README_FILE_NAME_02=''
    TMOE_OPTION=$(whiptail --title "PLUGINS" --menu "您想要管理哪个首字母开头的插件？\nBecause there are too many plugins, alphabetical sorting." 0 50 0 \
        "01" "🍎 A-C(a,b,c)" \
        "02" "🍇 D-G(d,e,f,g)" \
        "03" "🥝 H-M(h,i,j,k,l,m)" \
        "04" "🍑 N-R(n,o,p,q,r)" \
        "05" "🍓 S-T(s,t)" \
        "06" "🍉 U-Z(u,v,w,x,y,z)" \
        "07" "🍊 Extra 额外插件" \
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
    esac
    ##############################
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
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
        "07" "archlinux:添加了一些pacman和yay的常用别名" \
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
        "20" "brew:为常用的[brew]命令添加了几个别名" \
        "21" "bundler:增加了基本bundler命令的补全" \
        "22" "cabal:为Haskell的构建工具[Cabal]提供了补全功能" \
        "23" "cake:为[CakePHP]提供了补全功能" \
        "24" "cakephp3:为[cakephp3]添加了别名和自动补全功能" \
        "25" "capistrano:为[Capistrano]提供了补全功能" \
        "26" "cargo:这个插件为Rust构建工具[Cargo]添加了补全功能" \
        "27" "cask:Emacs的项目管理工具" \
        "28" "catimg:[posva]提供的catimg脚本,在终端上显示图像" \
        "29" "celery:为[Celery]提供了补全功能" \
        "30" "chruby:改变当前的Ruby版本以及显示Ruby版本的完成和提示功能。" \
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
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01) TMOE_ZSH_GREP_NAME='adb' ;;
    02) TMOE_ZSH_GREP_NAME='alias-finder' ;;
    03) TMOE_ZSH_GREP_NAME='ansible' ;;
    04) TMOE_ZSH_GREP_NAME='ant' ;;
    05) TMOE_ZSH_GREP_NAME='apache2-macports' ;;
    06) TMOE_ZSH_GREP_NAME='arcanist' ;;
    07) TMOE_ZSH_GREP_NAME='archlinux' ;;
    08) TMOE_ZSH_GREP_NAME='asdf' ;;
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
        ;;
    10) TMOE_ZSH_GREP_NAME='autojump' ;;
    11) TMOE_ZSH_GREP_NAME='autopep8' ;;
    12) TMOE_ZSH_GREP_NAME='aws' ;;
    13) TMOE_ZSH_GREP_NAME='battery' ;;
    14) TMOE_ZSH_GREP_NAME='bazel' ;;
    15) TMOE_ZSH_GREP_NAME='bbedit' ;;
    16) TMOE_ZSH_GREP_NAME='bgnotify' ;;
    17) TMOE_ZSH_GREP_NAME='boot2docker' ;;
    18) TMOE_ZSH_GREP_NAME='bower' ;;
    19) TMOE_ZSH_GREP_NAME='branch' ;;
    20) TMOE_ZSH_GREP_NAME='brew' ;;
    21) TMOE_ZSH_GREP_NAME='bundler' ;;
    22) TMOE_ZSH_GREP_NAME='cabal' ;;
    23) TMOE_ZSH_GREP_NAME='cake' ;;
    24) TMOE_ZSH_GREP_NAME='cakephp3' ;;
    25) TMOE_ZSH_GREP_NAME='capistrano' ;;
    26) TMOE_ZSH_GREP_NAME='cargo' ;;
    27) TMOE_ZSH_GREP_NAME='cask' ;;
    28) TMOE_ZSH_GREP_NAME='catimg' ;;
    29) TMOE_ZSH_GREP_NAME='celery' ;;
    30) TMOE_ZSH_GREP_NAME='chruby' ;;
    31) TMOE_ZSH_GREP_NAME='chucknorris' ;;
    32) TMOE_ZSH_GREP_NAME='cloudfoundry' ;;
    33) TMOE_ZSH_GREP_NAME='codeclimate' ;;
    34) TMOE_ZSH_GREP_NAME='coffee' ;;
    35) TMOE_ZSH_GREP_NAME='colemak' ;;
    36) TMOE_ZSH_GREP_NAME='colored-man-pages' ;;
    37) TMOE_ZSH_GREP_NAME='colorize' ;;
    38) TMOE_ZSH_GREP_NAME='command-not-found' ;;
    39) TMOE_ZSH_GREP_NAME='common-aliases' ;;
    40) TMOE_ZSH_GREP_NAME='compleat' ;;
    41) TMOE_ZSH_GREP_NAME='composer' ;;
    42) TMOE_ZSH_GREP_NAME='copybuffer' ;;
    43) TMOE_ZSH_GREP_NAME='copydir' ;;
    44) TMOE_ZSH_GREP_NAME='copyfile' ;;
    45) TMOE_ZSH_GREP_NAME='cp' ;;
    46) TMOE_ZSH_GREP_NAME='cpanm' ;;
    esac
    ##############################
    case_tmoe_zsh_settings_model
    press_enter_to_return
    ${RETURN_TO_WHERE}
}
######################
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
        "08" "dnf:为dnf常用命令添加别名,使其更易使用" \
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
        "43" "gem:为[Gem]添加别名和补全功能，包括常用的gem子命令以及当前目录中已安装的gems" \
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
        "55" "git-remote-branch:为[grb]添加补全内容" \
        "56" "glassfish:为asadmin添加补全功能,该命令用于管理[Oracle GlassFish]" \
        "57" "globalias:扩展所有glob表达式,子命令和别名" \
        "58" "gnu-utils:将GNU coreutils绑定到其默认名称" \
        "59" "golang:为[Go语言]添加补全内容" \
        "60" "gpg-agent:自动启用[GPG的gpg代理]" \
        "61" "gradle:为[Gradle]添加别名和补全功能" \
        "62" "grails:为[Grails 2 CLI]添加补全功能" \
        "63" "grunt:为[grunt]添加补全功能" \
        "64" "gulp:为[gulp]任务添加自动补全功能，从当前目录的gulpfile.js中获取所有可用任务" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01) TMOE_ZSH_GREP_NAME='dash' ;;
    02) TMOE_ZSH_GREP_NAME='debian' ;;
    03) TMOE_ZSH_GREP_NAME='dircycle' ;;
    04) TMOE_ZSH_GREP_NAME='direnv' ;;
    05) TMOE_ZSH_GREP_NAME='dirhistory' ;;
    06) TMOE_ZSH_GREP_NAME='dirpersist' ;;
    07) TMOE_ZSH_GREP_NAME='django' ;;
    08) TMOE_ZSH_GREP_NAME='dnf' ;;
    09) TMOE_ZSH_GREP_NAME='dnote' ;;
    10) TMOE_ZSH_GREP_NAME='docker' ;;
    11) TMOE_ZSH_GREP_NAME='docker-compose' ;;
    12) TMOE_ZSH_GREP_NAME='docker-machine' ;;
    13) TMOE_ZSH_GREP_NAME='doctl' ;;
    14) TMOE_ZSH_GREP_NAME='dotenv' ;;
    15) TMOE_ZSH_GREP_NAME='dotnet' ;;
    16) TMOE_ZSH_GREP_NAME='droplr' ;;
    17) TMOE_ZSH_GREP_NAME='drush' ;;
    18) TMOE_ZSH_GREP_NAME='eecms' ;;
    19) TMOE_ZSH_GREP_NAME='emacs' ;;
    20)
        TMOE_ZSH_GREP_NAME='ember-cli'
        TMOE_ZSH_SETTINGS_MODEL='03'
        TMOE_IMPORTANT_TIPS=$(
            cat <<-EOF
    如需运行本插件，那么请在安装完nodejs和npm后执行以下命令
    ${GREEN}npm install${RESET} -g ${BLUE}ember-cli${RESET}
EOF
        )
        ;;
    21) TMOE_ZSH_GREP_NAME='emoji' ;;
    22) TMOE_ZSH_GREP_NAME='emoji-clock' ;;
    23) TMOE_ZSH_GREP_NAME='emotty' ;;
    24) TMOE_ZSH_GREP_NAME='encode64' ;;
    25) TMOE_ZSH_GREP_NAME='extract' ;;
    26) TMOE_ZSH_GREP_NAME='fabric' ;;
    27) TMOE_ZSH_GREP_NAME='fancy-ctrl-z' ;;
    28) TMOE_ZSH_GREP_NAME='fasd' ;;
    29) TMOE_ZSH_GREP_NAME='fastfile' ;;
    30) TMOE_ZSH_GREP_NAME='fbterm' ;;
    31) TMOE_ZSH_GREP_NAME='fd' ;;
    32) TMOE_ZSH_GREP_NAME='firewalld' ;;
    33) TMOE_ZSH_GREP_NAME='flutter' ;;
    34) TMOE_ZSH_GREP_NAME='forklift' ;;
    35) TMOE_ZSH_GREP_NAME='fossil' ;;
    36) TMOE_ZSH_GREP_NAME='frontend-search' ;;
    37) TMOE_ZSH_GREP_NAME='fzf' ;;
    38) TMOE_ZSH_GREP_NAME='gas' ;;
    39) TMOE_ZSH_GREP_NAME='gatsby' ;;
    40) TMOE_ZSH_GREP_NAME='gb' ;;
    41) TMOE_ZSH_GREP_NAME='gcloud' ;;
    42) TMOE_ZSH_GREP_NAME='geeknote' ;;
    43) TMOE_ZSH_GREP_NAME='gem' ;;
    44) TMOE_ZSH_GREP_NAME='git' ;;
    45) TMOE_ZSH_GREP_NAME='git-auto-fetch' ;;
    46) TMOE_ZSH_GREP_NAME='git-escape-magic' ;;
    47) TMOE_ZSH_GREP_NAME='git-extras' ;;
    48) TMOE_ZSH_GREP_NAME='gitfast' ;;
    49) TMOE_ZSH_GREP_NAME='git-flow' ;;
    50) TMOE_ZSH_GREP_NAME='git-flow-avh' ;;
    51) TMOE_ZSH_GREP_NAME='github' ;;
    52) TMOE_ZSH_GREP_NAME='git-hubflow' ;;
    53) TMOE_ZSH_GREP_NAME='gitignore' ;;
    54) TMOE_ZSH_GREP_NAME='git-prompt' ;;
    55) TMOE_ZSH_GREP_NAME='git-remote-branch' ;;
    56) TMOE_ZSH_GREP_NAME='glassfish' ;;
    57) TMOE_ZSH_GREP_NAME='globalias' ;;
    58) TMOE_ZSH_GREP_NAME='gnu-utils' ;;
    59) TMOE_ZSH_GREP_NAME='golang' ;;
    60) TMOE_ZSH_GREP_NAME='gpg-agent' ;;
    61) TMOE_ZSH_GREP_NAME='gradle' ;;
    62) TMOE_ZSH_GREP_NAME='grails' ;;
    63) TMOE_ZSH_GREP_NAME='grunt' ;;
    64) TMOE_ZSH_GREP_NAME='gulp' ;;
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
        "47" "mysql-macports:为macOS上使用[MacPorts]安装的[MySQL]添加常用的别名" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01) TMOE_ZSH_GREP_NAME='hanami' ;;
    02) TMOE_ZSH_GREP_NAME='helm' ;;
    03) TMOE_ZSH_GREP_NAME='heroku' ;;
    04) TMOE_ZSH_GREP_NAME='history' ;;
    05) TMOE_ZSH_GREP_NAME='history-substring-search' ;;
    06) TMOE_ZSH_GREP_NAME='hitokoto' ;;
    07) TMOE_ZSH_GREP_NAME='homestead' ;;
    08) TMOE_ZSH_GREP_NAME='httpie' ;;
    09) TMOE_ZSH_GREP_NAME='ionic' ;;
    10) TMOE_ZSH_GREP_NAME='iterm2' ;;
    11) TMOE_ZSH_GREP_NAME='jake-node' ;;
    12) TMOE_ZSH_GREP_NAME='jenv' ;;
    13) TMOE_ZSH_GREP_NAME='jfrog' ;;
    14) TMOE_ZSH_GREP_NAME='jhbuild' ;;
    15) TMOE_ZSH_GREP_NAME='jira' ;;
    16) TMOE_ZSH_GREP_NAME='jruby' ;;
    17) TMOE_ZSH_GREP_NAME='jsontools' ;;
    18) TMOE_ZSH_GREP_NAME='jump' ;;
    19) TMOE_ZSH_GREP_NAME='kate' ;;
    20) TMOE_ZSH_GREP_NAME='keychain' ;;
    21) TMOE_ZSH_GREP_NAME='kitchen' ;;
    22) TMOE_ZSH_GREP_NAME='knife' ;;
    23) TMOE_ZSH_GREP_NAME='knife_ssh' ;;
    24) TMOE_ZSH_GREP_NAME='kops' ;;
    25) TMOE_ZSH_GREP_NAME='kubectl' ;;
    26) TMOE_ZSH_GREP_NAME='kube-ps1' ;;
    27) TMOE_ZSH_GREP_NAME='laravel' ;;
    28) TMOE_ZSH_GREP_NAME='laravel4' ;;
    29) TMOE_ZSH_GREP_NAME='laravel5' ;;
    30) TMOE_ZSH_GREP_NAME='last-working-dir' ;;
    31) TMOE_ZSH_GREP_NAME='lein' ;;
    32) TMOE_ZSH_GREP_NAME='lighthouse' ;;
    33) TMOE_ZSH_GREP_NAME='lol' ;;
    34) TMOE_ZSH_GREP_NAME='lxd' ;;
    35) TMOE_ZSH_GREP_NAME='macports' ;;
    36) TMOE_ZSH_GREP_NAME='magic-enter' ;;
    37) TMOE_ZSH_GREP_NAME='man' ;;
    38) TMOE_ZSH_GREP_NAME='marked2' ;;
    39) TMOE_ZSH_GREP_NAME='mercurial' ;;
    40) TMOE_ZSH_GREP_NAME='meteor' ;;
    41) TMOE_ZSH_GREP_NAME='microk8s' ;;
    42) TMOE_ZSH_GREP_NAME='minikube' ;;
    43) TMOE_ZSH_GREP_NAME='mix' ;;
    44) TMOE_ZSH_GREP_NAME='mix-fast' ;;
    45) TMOE_ZSH_GREP_NAME='mosh' ;;
    46) TMOE_ZSH_GREP_NAME='mvn' ;;
    47) TMOE_ZSH_GREP_NAME='mysql-macports' ;;
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
        "02" "nanoc:为[Nanoc]命令添加了一些常用别名和自动补全功能" \
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
        "45" "rsync:为常用的[rsync]命令添加别名" \
        "46" "ruby:为[Ruby]的常用命令添加了别名" \
        "47" "rust:为Rust编程语言的编译器[rustc]添加了补全功能" \
        "48" "rustup:为[rustup](Rust编程语言的工具链安装程序)添加了补全功能" \
        "49" "rvm:为[Ruby Version Manager]添加了一些实用函数和补全功能" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01) TMOE_ZSH_GREP_NAME='n98-magerun' ;;
    02) TMOE_ZSH_GREP_NAME='nanoc' ;;
    03) TMOE_ZSH_GREP_NAME='ng' ;;
    04) TMOE_ZSH_GREP_NAME='nmap' ;;
    05) TMOE_ZSH_GREP_NAME='node' ;;
    06) TMOE_ZSH_GREP_NAME='nomad' ;;
    07) TMOE_ZSH_GREP_NAME='npm' ;;
    08) TMOE_ZSH_GREP_NAME='npx' ;;
    09) TMOE_ZSH_GREP_NAME='nvm' ;;
    10) TMOE_ZSH_GREP_NAME='oc' ;;
    11) TMOE_ZSH_GREP_NAME='osx' ;;
    12) TMOE_ZSH_GREP_NAME='otp' ;;
    13) TMOE_ZSH_GREP_NAME='pass' ;;
    14) TMOE_ZSH_GREP_NAME='paver' ;;
    15) TMOE_ZSH_GREP_NAME='pep8' ;;
    16) TMOE_ZSH_GREP_NAME='percol' ;;
    17) TMOE_ZSH_GREP_NAME='per-directory-history' ;;
    18) TMOE_ZSH_GREP_NAME='perl' ;;
    19) TMOE_ZSH_GREP_NAME='perms' ;;
    20) TMOE_ZSH_GREP_NAME='phing' ;;
    21) TMOE_ZSH_GREP_NAME='pip' ;;
    22) TMOE_ZSH_GREP_NAME='pipenv' ;;
    23) TMOE_ZSH_GREP_NAME='pj' ;;
    24) TMOE_ZSH_GREP_NAME='please' ;;
    25) TMOE_ZSH_GREP_NAME='pod' ;;
    26) TMOE_ZSH_GREP_NAME='postgres' ;;
    27) TMOE_ZSH_GREP_NAME='pow' ;;
    28) TMOE_ZSH_GREP_NAME='powder' ;;
    29) TMOE_ZSH_GREP_NAME='powify' ;;
    30) TMOE_ZSH_GREP_NAME='profiles' ;;
    31) TMOE_ZSH_GREP_NAME='pyenv' ;;
    32) TMOE_ZSH_GREP_NAME='pylint' ;;
    33) TMOE_ZSH_GREP_NAME='python' ;;
    34) TMOE_ZSH_GREP_NAME='rails' ;;
    35) TMOE_ZSH_GREP_NAME='rake' ;;
    36) TMOE_ZSH_GREP_NAME='rake-fast' ;;
    37) TMOE_ZSH_GREP_NAME='rand-quote' ;;
    38) TMOE_ZSH_GREP_NAME='rbenv' ;;
    39) TMOE_ZSH_GREP_NAME='react-native' ;;
    40) TMOE_ZSH_GREP_NAME='rebar' ;;
    41) TMOE_ZSH_GREP_NAME='redis-cli' ;;
    42) TMOE_ZSH_GREP_NAME='repo' ;;
    43) TMOE_ZSH_GREP_NAME='ripgrep' ;;
    44) TMOE_ZSH_GREP_NAME='ros' ;;
    45) TMOE_ZSH_GREP_NAME='rsync' ;;
    46) TMOE_ZSH_GREP_NAME='ruby' ;;
    47) TMOE_ZSH_GREP_NAME='rust' ;;
    48) TMOE_ZSH_GREP_NAME='rustup' ;;
    49) TMOE_ZSH_GREP_NAME='rvm' ;;
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
        "27" "symfony2:提供[Symfony 2]的补全以及常用Symfony命令的别名。" \
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
    01) TMOE_ZSH_GREP_NAME='safe-paste' ;;
    02) TMOE_ZSH_GREP_NAME='salt' ;;
    03) TMOE_ZSH_GREP_NAME='sbt' ;;
    04) TMOE_ZSH_GREP_NAME='scala' ;;
    05) TMOE_ZSH_GREP_NAME='scd' ;;
    06) TMOE_ZSH_GREP_NAME='screen' ;;
    07) TMOE_ZSH_GREP_NAME='scw' ;;
    08) TMOE_ZSH_GREP_NAME='sdk' ;;
    09) TMOE_ZSH_GREP_NAME='sfdx' ;;
    10) TMOE_ZSH_GREP_NAME='sfffe' ;;
    11) TMOE_ZSH_GREP_NAME='shell-proxy' ;;
    12) TMOE_ZSH_GREP_NAME='shrink-path' ;;
    13) TMOE_ZSH_GREP_NAME='singlechar' ;;
    14) TMOE_ZSH_GREP_NAME='spring' ;;
    15) TMOE_ZSH_GREP_NAME='sprunge' ;;
    16) TMOE_ZSH_GREP_NAME='ssh-agent' ;;
    17) TMOE_ZSH_GREP_NAME='stack' ;;
    18) TMOE_ZSH_GREP_NAME='sublime' ;;
    19) TMOE_ZSH_GREP_NAME='sudo' ;;
    20) TMOE_ZSH_GREP_NAME='supervisor' ;;
    21) TMOE_ZSH_GREP_NAME='suse' ;;
    22) TMOE_ZSH_GREP_NAME='svcat' ;;
    23) TMOE_ZSH_GREP_NAME='svn' ;;
    24) TMOE_ZSH_GREP_NAME='svn-fast-info' ;;
    25) TMOE_ZSH_GREP_NAME='swiftpm' ;;
    26) TMOE_ZSH_GREP_NAME='symfony' ;;
    27) TMOE_ZSH_GREP_NAME='symfony2' ;;
    28) TMOE_ZSH_GREP_NAME='systemadmin' ;;
    29) TMOE_ZSH_GREP_NAME='systemd' ;;
    30) TMOE_ZSH_GREP_NAME='taskwarrior' ;;
    31) TMOE_ZSH_GREP_NAME='terminitor' ;;
    32) TMOE_ZSH_GREP_NAME='terraform' ;;
    33) TMOE_ZSH_GREP_NAME='textastic' ;;
    34) TMOE_ZSH_GREP_NAME='textmate' ;;
    35) TMOE_ZSH_GREP_NAME='thefuck' ;;
    36) TMOE_ZSH_GREP_NAME='themes' ;;
    37) TMOE_ZSH_GREP_NAME='thor' ;;
    38) TMOE_ZSH_GREP_NAME='tig' ;;
    39) TMOE_ZSH_GREP_NAME='timer' ;;
    40) TMOE_ZSH_GREP_NAME='tmux' ;;
    41) TMOE_ZSH_GREP_NAME='tmux-cssh' ;;
    42) TMOE_ZSH_GREP_NAME='tmuxinator' ;;
    43) TMOE_ZSH_GREP_NAME='torrent' ;;
    44) TMOE_ZSH_GREP_NAME='transfer' ;;
    45) TMOE_ZSH_GREP_NAME='tugboat' ;;
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
        "20" "yum:为常用的[Yum]命令添加了有用的别名" \
        "21" "z:z命令可以跟踪您访问次数最多的目录,并允许您快速访问它们" \
        "22" "zeus:预加载您的Rails环境,有效地加快Rails启动速度" \
        "23" "zsh-interactive-cd:为cd命令添加了类似于fish的交互式TAB补全功能" \
        "24" "zsh-navigation-tools:一组工具,例如n-history(多词历史搜索器),n-cd(目录书签管理器),还有近似匹配,高级历史记录管理" \
        "25" "zsh_reload:定义了一个函数来重新加载zsh会话" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01) TMOE_ZSH_GREP_NAME='ubuntu' ;;
    02) TMOE_ZSH_GREP_NAME='ufw' ;;
    03) TMOE_ZSH_GREP_NAME='urltools' ;;
    04) TMOE_ZSH_GREP_NAME='vagrant' ;;
    05) TMOE_ZSH_GREP_NAME='vagrant-prompt' ;;
    06) TMOE_ZSH_GREP_NAME='vim-interaction' ;;
    07) TMOE_ZSH_GREP_NAME='vi-mode' ;;
    08) TMOE_ZSH_GREP_NAME='virtualenv' ;;
    09) TMOE_ZSH_GREP_NAME='virtualenvwrapper' ;;
    10) TMOE_ZSH_GREP_NAME='vscode' ;;
    11) TMOE_ZSH_GREP_NAME='vundle' ;;
    12) TMOE_ZSH_GREP_NAME='wakeonlan' ;;
    13) TMOE_ZSH_GREP_NAME='wd' ;;
    14) TMOE_ZSH_GREP_NAME='web-search' ;;
    15) TMOE_ZSH_GREP_NAME='wp-cli' ;;
    16) TMOE_ZSH_GREP_NAME='xcode' ;;
    17) TMOE_ZSH_GREP_NAME='yarn' ;;
    18) TMOE_ZSH_GREP_NAME='yii' ;;
    19) TMOE_ZSH_GREP_NAME='yii2' ;;
    20) TMOE_ZSH_GREP_NAME='yum' ;;
    21)
        TMOE_ZSH_GREP_NAME='z'
        TMOE_ZSH_SETTINGS_MODEL='02'
        ZSH_README_FILE_NAME_02='README'
        ;;
    22) TMOE_ZSH_GREP_NAME='zeus' ;;
    23) TMOE_ZSH_GREP_NAME='zsh-interactive-cd' ;;
    24)
        TMOE_ZSH_GREP_NAME='zsh-navigation-tools'
        TMOE_ZSH_SETTINGS_MODEL='02'
        ZSH_README_FILE_NAME_02='.config/znt/README.txt'
        ;;
    25) TMOE_ZSH_GREP_NAME='zsh_reload' ;;
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
    TMOE_OPTION=$(whiptail --title "list of plugins" --menu "Which plugin do you want to choose?" 0 50 0 \
        "00" "🌚 Return to previous menu 返回上级菜单" \
        "01" "fzf-tab:zsh超强补全插件" \
        "02" "zsh-syntax-highlighting:语法高亮" \
        "03" "zsh-autosuggestions:自动补全" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    00 | "") tmoe_zsh_plugin_main_menu ;;
    01)
        TMOE_ZSH_GREP_NAME='fzf-tab'
        ZSH_README_FILE_NAME='README_CN.md'
        ZSH_README_FILE_NAME_02='README.md lib/zsh-ls-colors/README.md'
        # TMOE_IMPORTANT_TIPS=$(
        #    cat <<-EOF
        #   若本插件加载后${RED}无法${RESET}正常运行，则请前往${GREEN}FAQ${RESET}处重置插件
        #EOF
        #       )
        ;;
    02)
        TMOE_ZSH_GREP_NAME='zsh-syntax-highlighting'
        ZSH_README_FILE_NAME_02='docs/highlighters/*md tests/README.md'
        ;;
    03)
        TMOE_ZSH_GREP_NAME='zsh-autosuggestions'
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
    ZSH_PLUGIN_DIR="${HOME}/.oh-my-zsh/plugins/${TMOE_ZSH_GREP_NAME}"
    CUSTOM_ZSH_PLUGIN_DIR="${HOME}/.oh-my-zsh/custom/plugins/${TMOE_ZSH_GREP_NAME}"

    if [ -e "${ZSH_PLUGIN_DIR}/${TMOE_ZSH_GREP_NAME}.plugin.zsh" ]; then
        ZSH_PLUGIN_FILE="${ZSH_PLUGIN_DIR}/${TMOE_ZSH_GREP_NAME}.plugin.zsh"
    elif [ -e "${ZSH_PLUGIN_DIR}/_${TMOE_ZSH_GREP_NAME}" ]; then
        ZSH_PLUGIN_FILE="${ZSH_PLUGIN_DIR}/_${TMOE_ZSH_GREP_NAME}"
    elif [ -e "${CUSTOM_ZSH_PLUGIN_DIR}/${TMOE_ZSH_GREP_NAME}.zsh" ]; then
        ZSH_PLUGIN_FILE="${CUSTOM_ZSH_PLUGIN_DIR}/${TMOE_ZSH_GREP_NAME}.zsh"
    elif [ -e "${CUSTOM_ZSH_PLUGIN_DIR}/${TMOE_ZSH_GREP_NAME}.plugin.zsh" ]; then
        ZSH_PLUGIN_FILE="${CUSTOM_ZSH_PLUGIN_DIR}/${TMOE_ZSH_GREP_NAME}.plugin.zsh"
    fi

    if [ -e "${CUSTOM_ZSH_PLUGIN_DIR}" ]; then
        ZSH_PLUGIN_DIR=${CUSTOM_ZSH_PLUGIN_DIR}
    fi
}
############
case_tmoe_zsh_settings_model() {
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
    if grep -q "plugins/${TMOE_ZSH_GREP_NAME}" "${TMOE_ZSH_FILE}"; then
        TMOE_ZSH_CONFIG_STATUS="检测到您已启用${TMOE_ZSH_GREP_NAME}插件\nYou have enabled this plugin."
        TMOE_ZSH_CONFIG_ENABLED='true'
        #OH_MY_ZSH_PLUGIN='false'
        TMOE_ZSH_CONFIG_LINE=$(cat ${TMOE_ZSH_FILE} | grep -n "plugins/${TMOE_ZSH_GREP_NAME}" | head -n 1 | awk '{print $1}' | cut -d ':' -f 1)
    elif grep -q "^plugins=.*${TMOE_ZSH_GREP_NAME}" "${TMOE_ZSH_FILE}"; then
        TMOE_ZSH_CONFIG_STATUS="检测到您已启用${TMOE_ZSH_GREP_NAME}插件\nYou have enabled this zsh plugin."
        TMOE_ZSH_CONFIG_ENABLED='yes'
        #OH_MY_ZSH_PLUGIN='true'
        TMOE_ZSH_CONFIG_LINE=$(cat ${TMOE_ZSH_FILE} | grep -n "^plugins=.*${TMOE_ZSH_GREP_NAME}" | head -n 1 | awk '{print $1}' | cut -d ':' -f 1)
    else
        TMOE_ZSH_CONFIG_STATUS="检测到您已禁用${TMOE_ZSH_GREP_NAME}插件\nYou have disabled this plugin."
        TMOE_ZSH_CONFIG_ENABLED='false'
    fi
}
######################
enable_zsh_plugin() {
    check_zsh_plugin_folder
    case "${TMOE_ZSH_CONFIG_ENABLED}" in
    true | yes)
        echo "您${YELLOW}已经启用过${RESETT}本插件了，不要${RED}重复启用${RESET}哦！"
        echo "若脚本检测${RED}出错${RESET}，则请${GREEN}手动修改${RESET}${BLUE}${TMOE_ZSH_FILE}${RESET}的第${TMOE_ZSH_CONFIG_LINE}行内容"
        echo "${YELLOW}Do not enable this plugin repeatedly.${RESET}"
        ;;
    false)
        sed -i "$ a\source ${ZSH_PLUGIN_FILE}" "${TMOE_ZSH_FILE}"
        ;;
    esac
    check_tmoe_zsh_config_value
    check_zsh_plugin_content
    echo -e ${TMOE_ZSH_CONFIG_STATUS}
}
############
check_zsh_plugin_content() {
    cat ${TMOE_ZSH_FILE} | sed -n ${TMOE_ZSH_CONFIG_LINE}p
}
##########
disable_zsh_plugin() {
    check_zsh_plugin_folder
    case "${TMOE_ZSH_CONFIG_ENABLED}" in
    true) sed -i "${TMOE_ZSH_CONFIG_LINE} d" "${TMOE_ZSH_FILE}" ;;
    yes)
        check_zsh_plugin_content
        NEW_TMOE_ZSH_CONFIG_LINE_CONTENT=$(cat ${TMOE_ZSH_FILE} | sed -n ${TMOE_ZSH_CONFIG_LINE}p | sed "s@${TMOE_ZSH_GREP_NAME} @@" | sed "s@ ${TMOE_ZSH_GREP_NAME})@)@")
        #space key!
        sed -i "${TMOE_ZSH_CONFIG_LINE} c ${NEW_TMOE_ZSH_CONFIG_LINE_CONTENT}" "${TMOE_ZSH_FILE}"
        check_zsh_plugin_content
        ;;
    false)
        echo "您${YELLOW}已禁用${RESETT}本插件，不要${RED}重复禁用${RESET}哦！"
        echo "若脚本检测${RED}出错${RESET}，则请${GREEN}手动编辑${RESET}${BLUE}${TMOE_ZSH_FILE}${RESET}"
        ;;
    esac
    check_tmoe_zsh_config_value
    echo -e ${TMOE_ZSH_CONFIG_STATUS}
}
###################
check_bat() {
    if [ $(command -v batcat) ]; then
        batcat ${ZSH_README_FILE_PATH}
    elif [ $(command -v bat) ]; then
        bat ${ZSH_README_FILE_PATH}
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
tmoe_zsh_settings_model_01() {
    #此处不要设置RETURN_TO_WHERE的变量
    check_tmoe_zsh_config_value
    RETURN_TO_MENU='tmoe_zsh_settings_model_01'
    TMOE_OPTION=$(whiptail --title "您想要对${TMOE_ZSH_GREP_NAME}小可爱做什么？" --menu "${TMOE_ZSH_CONFIG_STATUS}" 0 50 0 \
        "0" "🌚 Return to previous menu 返回上级菜单" \
        "1" "${TMOE_ZSH_OPTION_01}" \
        "2" "Enable 启用" \
        "3" "Disable 禁用" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    0 | "") ${RETURN_TO_WHERE} ;;
    1) cat_zsh_plugin_readme_01 ;;
    2) enable_zsh_plugin ;;
    3) disable_zsh_plugin ;;
    esac
    ##############################
    press_enter_to_return
    tmoe_zsh_settings_model_01
}
######################
tmoe_zsh_settings_model_02() {
    check_tmoe_zsh_config_value
    RETURN_TO_MENU='tmoe_zsh_settings_model_02'
    TMOE_OPTION=$(whiptail --title "您想要对${TMOE_ZSH_GREP_NAME}小可爱做什么？" --menu "${TMOE_ZSH_CONFIG_STATUS}" 0 50 0 \
        "0" "🌚 Return to previous menu 返回上级菜单" \
        "1" "${TMOE_ZSH_OPTION_01}" \
        "2" "Enable 启用" \
        "3" "Disable 禁用" \
        "4" "Extra note 额外说明" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    0 | "") ${RETURN_TO_WHERE} ;;
    1) cat_zsh_plugin_readme_01 ;;
    2) enable_zsh_plugin ;;
    3) disable_zsh_plugin ;;
    4) cat_zsh_plugin_readme_02 ;;
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
    if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins" ]; then
        mkdir -p ${HOME}/.oh-my-zsh/custom/plugins
    fi

    if [ ! -d "${ZSH_PLUGIN_GIT_FOLDER}/.git" ]; then
        rm -rfv ${ZSH_PLUGIN_GIT_FOLDER}
        git clone --depth=1 ${ZSH_PLUGIN_GIT_URL_01} "${ZSH_PLUGIN_GIT_FOLDER}" || git clone --depth=1 ${ZSH_PLUGIN_GIT_URL_02} "${ZSH_PLUGIN_GIT_FOLDER}"
        chmod 755 -R "${ZSH_PLUGIN_GIT_FOLDER}"
    else
        cd "${ZSH_PLUGIN_GIT_FOLDER}"
        git_pull_origin_master
    fi
}
#############
git_clone_fzf_tab() {
    if [ ! $(command -v fzf) ]; then
        apt update || sudo apt update
        apt install -y fzf || sudo apt install fzf || sudo pacman -Syu fzf || sudo dnf install fzf
    fi

    ZSH_PLUGIN_GIT_FOLDER="${HOME}/.oh-my-zsh/custom/plugins/fzf-tab"
    ZSH_PLUGIN_GIT_URL_01='https://github.com/Aloxaf/fzf-tab.git'
    ZSH_PLUGIN_GIT_URL_02='git://github.com/Aloxaf/fzf-tab.git'
    git_clone_zsh_plugin
}
###########
git_clone_zsh_syntax_highlighting() {
    ZSH_PLUGIN_GIT_FOLDER="${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    ZSH_PLUGIN_GIT_URL_01='https://github.com/zsh-users/zsh-syntax-highlighting.git'
    ZSH_PLUGIN_GIT_URL_02='git://github.com/zsh-users/zsh-syntax-highlighting'
    git_clone_zsh_plugin
}
################
git_clone_zsh_autosuggestions() {
    ZSH_PLUGIN_GIT_FOLDER="${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    ZSH_PLUGIN_GIT_URL_01='https://github.com/zsh-users/zsh-autosuggestions.git'
    ZSH_PLUGIN_GIT_URL_02='git://github.com/zsh-users/zsh-autosuggestions'
    git_clone_zsh_plugin
}
##########
tmoe_zsh_plugin_install_function() {
    case "${INSTALL_ZSH_PLUGIN}" in
    autoenv) pip_install_autoenv ;;
    fzf-tab) git_clone_fzf_tab ;;
    zsh-syntax-highlighting) git_clone_zsh_syntax_highlighting ;;
    zsh-autosuggestions) git_clone_zsh_autosuggestions ;;
    esac
}
#############
tmoe_zsh_plugin_remove_function() {
    case "${INSTALL_ZSH_PLUGIN}" in
    autoenv) pip uninstall autoenv || sudo pip uninstall autoenv || sudo pip3 uninstall autoenv ;;
    fzf-tab) remove_fzf_tab ;;
    zsh-syntax-highlighting) remove_zsh_syntax_highlighting ;;
    zsh-autosuggestions) remove_zsh_autosuggestions ;;
    esac
}
#########
tmoe_zsh_settings_model_03() {
    check_tmoe_zsh_config_value
    RETURN_TO_MENU='tmoe_zsh_settings_model_03'
    TMOE_OPTION=$(whiptail --title "您想要对${TMOE_ZSH_GREP_NAME}小可爱做什么？" --menu "${TMOE_ZSH_CONFIG_STATUS}" 0 50 0 \
        "0" "🌚 Return to previous menu 返回上级菜单" \
        "1" "${TMOE_ZSH_OPTION_01}" \
        "2" "Enable 启用" \
        "3" "Disable 禁用" \
        "4" "Extra note 额外说明" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    0 | "")
        INSTALL_ZSH_PLUGIN=''
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
    RETURN_TO_MENU='tmoe_zsh_settings_model_04'
    TMOE_OPTION=$(whiptail --title "您想要对${TMOE_ZSH_GREP_NAME}小可爱做什么？" --menu "${TMOE_ZSH_CONFIG_STATUS}" 0 50 0 \
        "0" "🌚 Return to previous menu 返回上级菜单" \
        "1" "${TMOE_ZSH_OPTION_01}" \
        "2" "Enable 启用" \
        "3" "Remove & disable 移除并禁用" \
        "4" "Extra note 额外说明" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    0 | "")
        INSTALL_ZSH_PLUGIN=''
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
        ${RED}rm -rfv${RESET} ${BLUE}${HOME}/.oh-my-zsh/custom/plugins/${TMOE_ZSH_GREP_NAME}${RESET}
        Do you want to ${RED}disable${RESET} it?
        您真的要${RED}禁用${RESET}${BLUE}${TMOE_ZSH_GREP_NAME}${RESET}插件么?
EOF
        do_you_want_to_continue_02
        rm -rfv ${HOME}/.oh-my-zsh/custom/plugins/${TMOE_ZSH_GREP_NAME}
        disable_zsh_plugin
        ;;
    4) view_extra_note_of_zsh_plugin ;;
    esac
    ##############################
    press_enter_to_return
    tmoe_zsh_settings_model_04
}
####################
####################
main "$@"
##已经废弃的插件：fedora,rbfu,vault,cloudapp,go,nyan
