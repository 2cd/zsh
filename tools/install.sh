#!/usr/bin/env bash
#################
git_clone_termux_font_files() {
    [[ ! -e ${TMOE_ZSH_FONTS_PATH} ]] || rm -rvf ${TMOE_ZSH_FONTS_PATH}
    git clone https://gitee.com/ak2/termux-fonts.git --depth=1 "${TMOE_ZSH_FONTS_PATH}"
    cd ${TMOE_ZSH_FONTS_PATH}
    tar -Jxvf fonts.tar.xz
}
###################
android_git_clone_fonts() {
    mkdir -pv "${TERMUX_PATH}"
    if [ ! -d "${TMOE_ZSH_FONTS_PATH}/fonts/SourceCodePro" ]; then
        git_clone_termux_font_files
    fi
    chsh -s zsh
}
###########################################
modify_termux_color_and_font() {
    if [ ! -e "${TERMUX_KEYBOARD_FILE}" ]; then
        if (whiptail --title "termux.properties" --yes-button "yes" --no-button "no" --yesno "Your termux.properties is empty,do you want to creat it? It will modify the keyboard layout.\n是否需要创建termux.properties？这将会修改小键盘布局。" 10 50); then
            cp -f ${TMOE_ZSH_TERMUX_PATH}/termux.properties ${TERMUX_KEYBOARD_FILE}
        fi
    else
        cp -f ${TERMUX_KEYBOARD_FILE} "${TERMUX_KEYBOARD_BACKUP_FILE}"
    fi
    if [ ! -e "${TMOE_ZSH_TERMUX_PATH}/colors.properties" ]; then
        cp -f ${TMOE_ZSH_TERMUX_PATH}/colors.properties ${TERMUX_PATH}/colors.properties
    fi
}
###############
do_you_want_to_backup_zsh_folder() {
    unset P10K_STYLE
    if [[ ${TMOE_CONTAINER_AUTO_CONFIGURE} != true && ! -s ${HOME}/.p10k.zsh ]]; then
        which_p10k_style_do_you_prefer
    else
        P10K_STYLE=round
    fi
    cp "${HOME}/.zshrc" "${HOME}/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)" 2>/dev/null
    case "${LINUX_DISTRO}" in
    Android)
        check_termux_dependencies
        android_git_clone_fonts
        git_clone_tmoe_zsh
        modify_termux_color_and_font
        ;;
    *)
        check_gnu_linux_dependencies
        gnu_linux_chsh_zsh
        git_clone_tmoe_zsh
        ;;
    esac
    onekey_configure_tmoe_zsh
}
################################
which_p10k_style_do_you_prefer() {
    if (whiptail --title "p10k style" --yes-button "round" --no-button "sharp" --yesno "The default theme is powerlevel 10k.\nWhich p10k style do you prefer?" 8 50); then
        P10K_STYLE=round
    else
        P10K_STYLE=sharp
    fi
}
gnu_linux_chsh_zsh() {
    if [ $(command -v chsh) ]; then
        [[ "$(cat /etc/passwd | grep "${HOME}" | grep zsh)" ]] || chsh -s $(command -v zsh) || sudo chsh -s $(command -v zsh)
    fi
}
######################
add_zsh_alias() {
    #外面双引号，里面单引号。
    case ${LINUX_DISTRO} in
    Android)
        sed -i '/alias zshcolor=/d' "${HOME}/.zshrc"
        sed -i "$ a\alias zshcolor='bash ${TMOE_ZSH_TERMUX_PATH}/colors.sh'" "${HOME}/.zshrc"
        sed -i '/alias zshfont=/d' "${HOME}/.zshrc"
        sed -i "$ a\alias zshfont='bash ${TMOE_ZSH_TERMUX_PATH}/fonts.sh'" "${HOME}/.zshrc"
        ;;
    esac
    #sed -i '/alias zshtheme=/d' "${HOME}/.zshrc"
    #sed -i "$ a\alias zshtheme='bash ${TMOE_ZSH_TERMUX_PATH}/themes.sh'" "${HOME}/.zshrc"
    #if [ -e "${HOME}/.profile" ]; then
    #    sed -i '/alias zshtheme=/d' "${HOME}/.profile"
    #    sed -i "$ a\alias zshtheme='bash ${TMOE_ZSH_TERMUX_PATH}/themes.sh'" "${HOME}/.profile"
    #fi
    sed -i '/alias zsh-i=/d' "${HOME}/.zshrc"
    if [ -e "${HOME}/.bashrc" ]; then
        sed -i '/alias zsh-i=/d' "${HOME}/.bashrc"
    fi
    #if [ ! -e "${PREFIX}/bin/zsh-i" ]; then
    source ${TMOE_ZSH_TOOL_DIR}/update.sh -download
    #fi
    if ! egrep -q '^[^#]*alias t=tmoe' "${HOME}/.zshrc"; then
        sed -i '$ a\[[ ! $(command -v tmoe) ]] || alias t=tmoe' "${HOME}/.zshrc"
    fi
}
###########
check_zsh_dir_permissions() {
    ZSH_PATH=''
    for i in ${ZINIT_DIR} ${HOME}/.zshrc ${TMOE_ZSH_GIT_DIR}; do
        CURRENT_USER_ZSH_FILE_PERMISSION=$(ls -l ${i} | tail -n 1 | awk -F ' ' '{print $3}')
        case ${CURRENT_USER_ZSH_FILE_PERMISSION} in
        "${CURRENT_USER_NAME}") ;;
        *) ZSH_PATH="${ZSH_PATH} ${i}" ;;
        esac
    done
    unset i
    case ${ZSH_PATH} in
    "") ;;
    *) fix_zsh_folder_permissions ;;
    esac
}
#############
git_clone_zinit_and_omz() {
    #git clone oh-my-zsh
    mkdir -pv ${ZINIT_DIR}
    cd ${ZINIT_DIR}
    if [ ! -e "bin/.git" ]; then
        rm -rv bin 2>/dev/null
        git clone --depth=1 https://github.com/zdharma/zinit.git ${ZINIT_DIR}/bin || git clone --depth=1 git://github.com/zdharma/zinit ${ZINIT_DIR}/bin
    fi

    if [ ! -e "omz/.git" ]; then
        rm -rv omz 2>/dev/null
        git clone https://github.com/ohmyzsh/ohmyzsh.git "${OMZ_DIR}" --depth 1 || git clone --depth=1 git://github.com/ohmyzsh/ohmyzsh "${OMZ_DIR}"
    fi
    neko_01
    zinit_ascii
    if [ -f "${HOME}/.zshrc" ]; then
        if ! egrep -q '^[^#]*zinit ice lucid wait' "${HOME}/.zshrc" || ! egrep -q '^[^#]*source.*zinit.zsh' "${HOME}/.zshrc"; then
            sed -i 's@^@#&@g' "${HOME}/.zshrc"
            sed -i "1r ${TMOE_ZSH_GIT_DIR}/config/zshrc.zsh" "${HOME}/.zshrc"
        fi
    else
        cp ${TMOE_ZSH_GIT_DIR}/config/zshrc.zsh "${HOME}/.zshrc"
        #cp "${OMZ_DIR}/templates/zshrc.zsh-template" "${HOME}/.zshrc" || wget -O "${HOME}/.zshrc" 'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template'
    fi
    case ${LINUX_DISTRO} in
    Android) ;;
    *) check_zsh_dir_permissions ;;
    esac
}
##########
configure_tmoe_zsh_p10k_theme() {
    DEFAULT_ZSH_THEME_FILE_DIR="${ZINIT_THEME_DIR}/${DEFAULT_ZSH_THEME_FILE_NAME}"
    if [ ! -e "${DEFAULT_ZSH_THEME_FILE_DIR}/${DEFAULT_ZSH_THEME_FILE_NAME}.zsh-theme" ]; then
        mkdir -pv ${DEFAULT_ZSH_THEME_FILE_DIR}
        ln -sv ${OMZ_THEME_DIR}/${DEFAULT_ZSH_THEME_FILE_NAME}.zsh-theme ${DEFAULT_ZSH_THEME_FILE_DIR}
    fi
}
##########
configure_tmoe_zsh_default_theme() {
    DEFAULT_ZSH_THEME_FILE_NAME="xiong-chiamiov-plus"
    DEFAULT_ZSH_THEME_FILE_DIR="${ZINIT_THEME_DIR}/${DEFAULT_ZSH_THEME_FILE_NAME}"
    if [ ! -e "${DEFAULT_ZSH_THEME_FILE_DIR}/${DEFAULT_ZSH_THEME_FILE_NAME}.zsh-theme" ]; then
        mkdir -pv ${DEFAULT_ZSH_THEME_FILE_DIR}
        ln -sv ${OMZ_THEME_DIR}/${DEFAULT_ZSH_THEME_FILE_NAME}.zsh-theme ${DEFAULT_ZSH_THEME_FILE_DIR}
    fi
}
##########
case_tmoe_zsh_default_theme() {
    P10K_CONFIG_FILE="${HOME}/.p10k.zsh"
    case ${P10K_STYLE} in
    round | sharp)
        cp -f ${TMOE_ZSH_CONFIG_DIR}/p10k/.p10k-${P10K_STYLE}.zsh ${P10K_CONFIG_FILE}
        chmod a+x -v ${P10K_CONFIG_FILE}
        ;;
    esac
    unset NON_EXEC_ZSH
    case ${LINUX_DISTRO} in
    Android) NON_EXEC_ZSH=true ;;
    esac
    ONKEY_INSTALLATION=true
    case "${TMOE_CONTAINER_AUTO_CONFIGURE}" in
    true)
        case ${LINUX_DISTRO} in
        openwrt) configure_tmoe_zsh_default_theme ;;
        *) source ${TMOE_ZSH_TERMUX_PATH}/themes.sh -p10k ;;
        esac
        ;;
    *)
        configure_tmoe_zsh_default_theme
        source ${TMOE_ZSH_TERMUX_PATH}/themes.sh -p10k
        ;;
    esac
    unset ONKEY_INSTALLATION
}
#########
link_omz_plugin_to_zinit() {
    #create zsh plugins目录
    mkdir -pv "${ZINIT_DIR}/plugins"
    cd "${ZINIT_DIR}/plugins"

    cd ${OMZ_DIR}/plugins
    for i in $(ls ${PWD}); do
        if [ -d "${i}" ] && [ ! -e "${ZINIT_DIR}/plugins/_local---${i}" ]; then
            ln -sv ${PWD}/${i} ${ZINIT_DIR}/plugins/_local---${i}
        fi
    done
    unset i
}
###########
add_zinit_plugin_command_not_found() {
    sed -i 's@^.*/command-not-found@#&@g' "${HOME}/.zshrc"
    cat >>${HOME}/.zshrc <<-'EOF'
[[ -e /usr/lib/command-not-found ]] && zinit ice lucid wait="0" pick"command-not-found.plugin.zsh" && zinit light _local/command-not-found #用于显示未找到的命令来源于哪个软件包  This plugin uses the command-not-found package for zsh to provide suggested packages to be installed if a command cannot be found.
EOF
}
############
configure_command_not_found() {
    #COMMAND_NOT_FOUND_PLUGIN_DIR="${ZINIT_DIR}/plugins/_local---command-not-found"
    if [ -e "/usr/lib/command-not-found" ]; then
        case "${LINUX_DISTRO}" in
        debian)
            if ! egrep -q '^[^#]*zinit.*/command-not-found' "${HOME}/.zshrc"; then
                add_zinit_plugin_command_not_found
            fi
            cat <<-ENDOFPLUGININFO
    正在更新${BOLD}${BLUE}command-not-found${RESET}${RESET}数据库...
    Updating command-not-found database...
ENDOFPLUGININFO
            case "${DEBIAN_DISTRO}" in
            ubuntu) ;;
            *)
                case $(id -u) in
                0)
                    apt-file update 2>/dev/null
                    update-command-not-found 2>/dev/null
                    ;;
                *)
                    sudo apt-file update 2>/dev/null
                    sudo update-command-not-found 2>/dev/null
                    ;;
                esac
                ;;
            esac
            ;;
        esac
    fi
}
############
add_zinit_plugin_fzf_tab() {
    sed -i 's@^.*/fzf-tab@#&@g' "${HOME}/.zshrc"
    cat >>${HOME}/.zshrc <<-'EOF'
[[ $(command -v fzf) ]] && zinit ice lucid pick"fzf-tab.zsh" && zinit light _local/fzf-tab  #aloxaf:fzf-tab 是一个能够极大提升 zsh 补全体验的插件。它通过 hook zsh 补全系统的底层函数 compadd 来截获补全列表，从而实现了在补全命令行参数、变量、目录栈和文件时都能使用 fzf 进行选择的功能。Replace zsh's default completion selection menu with fzf! 
EOF
}
############
git_clone_fzf_tab() {
    printf '%s\n' '正在克隆fzf-tab自动补全插件...'
    printf "%s\n" "${YELLOW}github.com/Aloxaf/fzf-tab${RESET}"
    printf "%s\n" "${BLUE}#aloxaf:fzf-tab 是一个能够极大提升 zsh 补全体验的插件。它通过 hook zsh 补全系统的底层函数 compadd 来截获补全列表，从而实现了在补全命令行参数、变量、目录栈和文件时都能使用 fzf 进行选择的功能。Replace zsh’s default completion selection menu with fzf! ${RESET}"
    git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git "${FZF_TAB_PLUGIN_DIR}" || git clone --depth=1 git://github.com/Aloxaf/fzf-tab.git "${FZF_TAB_PLUGIN_DIR}"
    chmod 755 -R "${FZF_TAB_PLUGIN_DIR}"
    if ! egrep -q '^[^#]*zinit.*/fzf-tab' "${HOME}/.zshrc"; then
        add_zinit_plugin_fzf_tab
    fi
}
############
fzf_tab_extra_opt() {
    case "${ENABLE_FZF_TAB_EXTRA_OPT}" in
    true) sed -i 's@ALOXAF_FZF_TAB_EXTRA=.*@ALOXAF_FZF_TAB_EXTRA=true@' ${HOME}/.zshrc ;;
    esac
}
################
configure_fzf_tab_ls_colors() {
    FZF_TAB_ZSH_SCRIPT="${FZF_TAB_PLUGIN_DIR}/fzf-tab.zsh"
    if ! grep -q 'LS_COLORS' ${FZF_TAB_ZSH_SCRIPT}; then
        FZF_TAB_LS_COLOR_LINE=$(cat ${FZF_TAB_ZSH_SCRIPT} | grep -n 'completion.*list-colors' | head -n 1 | awk '{print $1}' | cut -d ':' -f 1)
        [[ -z ${FZF_TAB_LS_COLOR_LINE} ]] || sed -i "${FZF_TAB_LS_COLOR_LINE} i\    zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}" ${FZF_TAB_ZSH_SCRIPT}
    fi
}
#################
configure_zinit_plugin_fzf_tab() {
    FZF_TAB_PLUGIN_DIR="${ZINIT_DIR}/plugins/_local---fzf-tab"
    ENABLE_FZF_TAB_EXTRA_OPT='true'
    if grep -Eq 'buster|stretch|jessie|Bionic Beaver|Xenial|Cosmic|Disco' "/etc/os-release" 2>/dev/null; then
        ENABLE_FZF_TAB_EXTRA_OPT='false'
    fi
    case ${TMOE_PROOT} in
    true) ENABLE_FZF_TAB_EXTRA_OPT='false' ;;
    esac
    case ${TMOE_CHROOT} in
    true | false) ENABLE_FZF_TAB_EXTRA_OPT='false' ;;
    esac

    case "${LINUX_DISTRO}" in
    Android | debian | arch) ;;
    *) ENABLE_FZF_TAB_EXTRA_OPT='false' ;;
    esac

    case "${TMOE_CONTAINER_AUTO_CONFIGURE}" in
    true) ENABLE_FZF_TAB_EXTRA_OPT='false' ;;
    esac

    if [ $(command -v fzf) ]; then
        if [ ! -d "${FZF_TAB_PLUGIN_DIR}/.git" ]; then
            git_clone_fzf_tab
            fzf_tab_extra_opt
        fi
        configure_fzf_tab_ls_colors
    fi
}
############
add_zinit_plugin_fast_syntax_highlighting() {
    sed -i 's@^.*/fast-syntax-highlighting@#&@g' "${HOME}/.zshrc"
    cat >>${HOME}/.zshrc <<-'EOF'
zinit ice wait lucid pick"fast-syntax-highlighting.plugin.zsh" atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" && zinit light _local/fast-syntax-highlighting    #语法高亮插件，速度比zsh-syntax-highlighting更快。(Short name F-Sy-H). Syntax-highlighting for Zshell – fine granularity, number of features, 40 work hours themes
EOF
}
#########
git_clone_fast_syntax_highlighting() {
    if [ ! -d "${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR}/.git" ]; then
        cat <<-ENDOFPLUGININFO
    正在克隆zsh语法高亮插件${BOLD}${BLUE}fast-syntax-highlighting${RESET}${RESET}...
    ${YELLOW}github.com/zdharma/fast-syntax-highlighting${RESET}
    ${BLUE}fast_syntax_highlighting语法高亮插件，速度比zsh-syntax-highlighting更快。${RESET}
    ${GREEN}(Short name F-Sy-H). Syntax-highlighting for Zshell – fine granularity, number of features, 40 work hours themes${RESET}
ENDOFPLUGININFO
        #sed -i '/fast-syntax-highlighting.zsh/d' "${HOME}/.zshrc"
        git clone --depth=1 https://github.com/zdharma/fast-syntax-highlighting.git ${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR} || git clone --depth=1 git://github.com/zdharma/fast-syntax-highlighting ${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR}
        chmod 755 -R "${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR}"
    fi

    if ! egrep -q '^[^#]*zinit.*/fast-syntax-highlighting' "${HOME}/.zshrc"; then
        add_zinit_plugin_fast_syntax_highlighting
    fi
}
###########
add_zinit_plugin_zsh_autosuggestions() {
    sed -i 's@^.*/zsh-autosuggestions@#&@g' "${HOME}/.zshrc"
    #zinit ice pick"zsh-autosuggestions.zsh"
    cat >>${HOME}/.zshrc <<-'EOF'
zinit ice wait lucid pick"zsh-autosuggestions.zsh" atload'_zsh_autosuggest_start' && zinit light _local/zsh-autosuggestions #自动建议插件 It suggests commands as you type based on history and completions.
EOF
}
##################
git_clone_zsh_autosuggestions() {
    if [ ! -d "${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR}/.git" ]; then
        cat <<-ENDOFPLUGININFO
    正在克隆自动建议插件${BOLD}${BLUE}zsh-autosuggestions${RESET}${RESET}...
    ${YELLOW}github.com/zsh-users/zsh-autosuggestions${RESET}
    ${GREEN}It suggests commands as you type based on history and completions.${RESET}
ENDOFPLUGININFO
        #sed -i '/zsh-autosuggestions.zsh/d' "${HOME}/.zshrc"
        git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR} || git clone --depth=1 git://github.com/zsh-users/zsh-autosuggestions ${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR}
        chmod 755 -R "${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR}"
    fi
    if ! egrep -q '^[^#]*zinit.*/zsh-autosuggestions' "${HOME}/.zshrc"; then
        add_zinit_plugin_zsh_autosuggestions
    fi
}
#################
tips_of_tmoe_zsh_01() {
    printf "%s\n" "您已安装${BOLD}zsh${RESET},之后可以单独输${YELLOW}zshtheme -h${RESET}来获取${BLUE}切换主题${RESET}的帮助信息,输 ${YELLOW}zsh-i${RESET}进入zsh插件${BLUE}管理工具${RESET}。"
    printf "%s\n" "You have installed ${BOLD}zsh${RESET},type ${GREEN}zshtheme -h${RESET} to get ${BLUE}theme${RESET} help info,type ${GREEN}zsh-i${RESET} to start ${BLUE}tmoe-zsh tool${RESET}."

    case "${LINUX_DISTRO}" in
    Android)
        printf "%s\n" "输${YELLOW}zshcolor${RESET} 来更改${BLUE}配色${RESET}，输 ${YELLOW}zshfont${RESET}来更改${BLUE}字体${RESET}"
        printf "%s\n" "You can also type ${GREEN}zshcolor${RESET} to change the ${BLUE}color${RESET}, type ${GREEN}zshfont${RESET} to change the ${BLUE}font${RESET}"
        ;;
    esac
    case ${TMOE_INSTALLATION_COMMAND} in
    "") TEMP_INSTALLATION_COMMAND='apt install' ;;
    *) TEMP_INSTALLATION_COMMAND=${TMOE_INSTALLATION_COMMAND} ;;
    esac
    cat <<-ENDOFTMOEZSHHELPINFO
    ------------
    ${BOLD}${YELLOW}插件名称PLUGIN NAME${RESET}${RESET}:${BOLD}${BLUE}z${RESET}${RESET}
    ${BOLD}${YELLOW}命令COMMAND${RESET}${RESET}:${BOLD}${BLUE}z${RESET}${RESET}
    ${BOLD}${YELLOW}Description${RESET}${RESET}:记录访问目录，输z获取,输$(z 目录名称)快速跳转  
    若您曾访问过~/sd/Download，则您可以输${YELLOW}z Down${RESET}或${YELLOW}z load${RESET}来快速跳转，访问列表可以输 ${YELLOW}z${RESET}获取。
    This plugin defines the [z command](https://github.com/rupa/z) that tracks your most visited directories and allows you to access them with very few keystrokes.
    Just type ${GREEN}z${RESET}
    ------------
    ${BOLD}${YELLOW}插件名称PLUGIN NAME${RESET}${RESET}:${BOLD}${BLUE}colored-man-pages${RESET}${RESET}
    ${BOLD}${YELLOW}命令COMMAND${RESET}${RESET}:${BOLD}${BLUE}man${RESET}${RESET} 
    ${BOLD}${YELLOW}Description${RESET}${RESET}: ${BLUE}man手册彩色输出 This plugin adds colors to man pages.${RESET}.
    输入${GREEN}man 软件包或命令名称${RESET}获取该软件包的文档。
    用法示例：${GREEN}man ssh${RESET}高亮显示ssh-client的文档（用户手册）。
    ${GREEN}man bash${RESET}获取bash的用户手册。
    ------------
    ${BOLD}${YELLOW}应用名称 APP NAME${RESET}${RESET}:${BOLD}${BLUE}bat${RESET}${RESET}
    ${BOLD}${YELLOW}命令COMMAND${RESET}${RESET}:${BOLD}${BLUE}bat${RESET}${RESET}
    alias lcat=/bin/cat
    alias cat='bat -p'
    bat是cat的替代品，支持多语言语法高亮。
    用法示例：${GREEN}bat -l zsh /etc/os-release${RESET}
    输入${GREEN}bat -L${RESET}获取支持的语言
    ${GREEN}lcat${RESET}命令为原版cat
    ------------
    ${BOLD}${YELLOW}应用名称 APP NAME${RESET}${RESET}:${BOLD}${BLUE}exa${RESET}${RESET}
    ${BOLD}${YELLOW}命令COMMAND${RESET}${RESET}:${BOLD}${BLUE}exa${RESET}${RESET}
    alias lls=ls
    alias l="exa -lbah"
    若您的系统满足依赖条件，则ls将alias为exa.
    exa是一款优秀的ls替代品,拥有更好的文件展示体验,输出结果更快,使用rust编写。
    Exa is a modern version of ls. 
    输入${GREEN}l${RESET},将显示当前目录的文件列表。
    输入${GREEN}lst${RESET},将展示类似于tree的树状列表。
    输入${GREEN}lls${RESET},使用原版ls
    You can type ${GREEN}l${RESET} to list current file list.
    -----------
    ${BOLD}${YELLOW}插件名称PLUGIN NAME${RESET}${RESET}:${BOLD}${BLUE}extract${RESET}${RESET}
    ${BOLD}${YELLOW}命令COMMAND${RESET}${RESET}:${BOLD}${BLUE}x${RESET}${RESET}
    ${BOLD}${YELLOW}Description${RESET}${RESET}: ${BLUE}This plugin defines a function called "extract" that extracts the archive file you pass it, and it supports a wide variety of archive filetypes${RESET}.
    例如某文件名为233.tar.xz，则您无需输${YELLOW}tar -Jxf 233.tar.xz${RESET}，只需输${YELLOW}x 233.tar.xz${RESET}。
    同理，若另一文件为233.7z，则您只需输入${YELLOW}x 233.7z${RESET}即可解压。
    注意：您在解压前必须先安装相关依赖，例如：zip需要unzip，7z需要p7zip，zst需要zstd, 安装方法类似于${TEMP_INSTALLATION_COMMAND} zstd
    You can type ${GREEN}x 233.tar.zst${RESET} to extract ${BLUE}233.tar.zst${RESET}
    -----------
    ${BOLD}${YELLOW}插件名称PLUGIN NAME${RESET}${RESET}:${BOLD}${BLUE}sudo${RESET}${RESET}
    ${BOLD}${YELLOW}Description${RESET}${RESET}: ${BLUE}按两下ESC键,可以在当前命令前加上sudo前缀${RESET}.
    Easily prefix your current or previous commands with ${GREEN}sudo${RESET} by pressing ${YELLOW}ESC${RESET} twice
    ------------
    ${BOLD}${YELLOW}Other${RESET}${RESET}
    ${BOLD}${YELLOW}补全插件${RESET}${RESET}:输入已知命令或函数的部分字符后，按下${BOLD}${BLUE}TAB键⇄${RESET}${RESET}
    用法示例：输入${GREEN}zsht${RESET}后，按下${BLUE}⇄${RESET}补全为${GREEN}zshtheme${RESET},按下空格，再按下${BLUE}TAB键${RESET}
    ${BOLD}${YELLOW}Description${RESET}${RESET}:You can press ${BOLD}${BLUE}TAB KEY ⇄ ${RESET}${RESET} to use auto completion plugin.
    For example,type ${GREEN}git${RESET},and press space key, and press ${BLUE}⇄${RESET}
    ------------
    ${BOLD}${YELLOW}插件名称PLUGIN NAME${RESET}${RESET}:${BOLD}${BLUE}zsh-autosuggestions${RESET}${RESET}
    ${BOLD}${YELLOW}历史记录插件用法${RESET}${RESET}:输入曾输过的命令，按方向键上${BOLD}${YELLOW}↑${RESET}或右${BOLD}${YELLOW}→${RESET}进行补全。
    ${BOLD}${YELLOW}Description${RESET}${RESET}:It suggests commands as you type based on history and completions.
    Just type arrow key ${BOLD}${YELLOW}↑${RESET} or ${BOLD}${YELLOW}→${RESET}
    ------------
    Plugins such as extract, git, fast-syntax-highlighting, fzf-tab, zshtheme and z have been configured for you. Enjoy the fun of zsh!
ENDOFTMOEZSHHELPINFO
}
######################
onekey_configure_tmoe_zsh() {
    git_clone_zinit_and_omz
    link_omz_plugin_to_zinit
    case_tmoe_zsh_default_theme
    case "${LINUX_DISTRO}" in
    Android) ;;
    *) configure_command_not_found ;;
    esac
    #################
    add_zsh_alias
    #################
    configure_zinit_plugin_fzf_tab
    git_clone_fast_syntax_highlighting
    git_clone_zsh_autosuggestions
    #######################
    if [ "${LINUX_DISTRO}" != "Android" ] && [ ${HOME} != "/root" ]; then
        sudo -E chown -Rv ${CURRENT_USER_NAME}:${CURRENT_USER_GROUP} ${HOME}/.zinit ${HOME}/.zsh_history ${HOME}/.z ${TMOE_ZSH_DIR}
    fi
    #配置完成后的提示内容。
    tips_of_tmoe_zsh_01
    ####################
    case "${TMOE_CONTAINER_AUTO_CONFIGURE}" in
    true)
        sleep 2
        exit 0
        ;;
    *)
        press_enter_to_continue
        change_zsh_theme_and_termux_color
        ;;
    esac
}
###########################################
change_zsh_theme_and_termux_color() {
    cd ${CURRENT_DIR}
    printf '%s\n' ''
    printf "%s\n" "Choose your theme now~"
    #printf '%s\n'  '请选择您的主题'
    #mkdir -pv "${ZINIT_DIR}/themes/_local"
    source ${TMOE_ZSH_TERMUX_PATH}/themes.sh
    case "${LINUX_DISTRO}" in
    Android)
        printf "%s\n" "Choose your color scheme now~"
        #printf '%s\n'  '请选择您的配色'
        bash ${TMOE_ZSH_TERMUX_PATH}/colors.sh
        printf '%s\n' ''
        printf "%s\n" "Choose your font now~"
        #printf '%s\n'  '请选择您的字体'
        bash ${TMOE_ZSH_TERMUX_PATH}/fonts.sh
        ;;
    esac
}
##################
do_you_want_to_backup_zsh_folder
