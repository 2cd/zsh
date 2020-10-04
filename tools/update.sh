#!/usr/bin/env bash
################
upgrade_zsh_plugins_main() {
    check_tmoe_zsh_theme_completion_version
    case "$1" in
    -download)
        check_zsh_theme_completion
        download_tmoe_zsh
        ;;
    *)
        check_zsh_theme_completion
        zinit_ascii
        update_command_not_found
        git_pull_powerlevel_10k
        #upgrade zsh plugins and tool
        #git_pull_tmoe_zsh
        git_pull_oh_my_zsh
        git_pull_zinit
        neko_01
        git_clone_tmoe_zsh
        upgrade_tmoe_zsh_script
        #tmoe_zsh_main_menu
        ;;
    esac
}
##############
check_tmoe_zsh_theme_completion_version() {
    UPDATE_ZSH_THEME_COMPLETION=false
    ZSH_THEME_COMPLETION_VERSION_TXT="${TMOE_ZSH_TERMUX_PATH}/completion/version.txt"
    if [ ! -e "${ZSH_THEME_COMPLETION_VERSION_TXT}" ]; then
        UPDATE_ZSH_THEME_COMPLETION=true
    else
        THE_LATEST_ZSH_COMPLETION_VERSION=$(curl -sL ${TMOE_GIT_REPO}/raw/master/share/completion/version.txt)
        CURRENT_ZSH_THEME_COMPLETTION_VERSION="$(cat ${ZSH_THEME_COMPLETION_VERSION_TXT} | head -n 1)"
        if ((${CURRENT_ZSH_THEME_COMPLETTION_VERSION} < ${THE_LATEST_ZSH_COMPLETION_VERSION})); then
            UPDATE_ZSH_THEME_COMPLETION=true
        fi
    fi
}
###########
curl_zsh_i() {
    curl -Lv -o ${PREFIX}/bin/zsh-i ${ZSH_I_URL}
}
##########
chmod_plus_x_zsh_i() {
    chmod +x .zsh-i
    sudo mv -f .zsh-i ${PREFIX}/bin/zsh-i || su -c "mv -f .zsh-i ${PREFIX}/bin/zsh-i"
}
##########
update_zsh_theme_completion() {
    rm -rv ${ZINIT_DIR}/snippets/$(echo ${ZSH_THEME_COMPLETION_FILE} | sed 's@/_zshtheme@@' | sed 's@^/@@g ; 's@/@--@g'') ${ZINIT_DIR}/completions/_zshtheme 2>/dev/null
    if [ ! -e ${PREFIX}/bin/zshtheme ]; then
        sed -i '/alias zshtheme=/d' ${HOME}/.zshrc ${HOME}/.profile 2>/dev/null
        ln -svf ${TMOE_ZSH_TERMUX_PATH}/themes.sh ${PREFIX}/bin/zshtheme || sudo ln -svf ${TMOE_ZSH_TERMUX_PATH}/themes.sh ${PREFIX}/bin/zshtheme
    fi
}
#############
check_zsh_theme_completion() {
    ZSH_THEME_COMPLETION_FILE="${TMOE_ZSH_TERMUX_PATH}/completion/_zshtheme"
    if ! egrep -q '^[^#]*zinit.*completion/_zshtheme' ${HOME}/.zshrc; then
        #mkdir -p ${ZINIT_SNIPPETS_LOCAL}
        printf "%s\n" "zinit ice lucid wait="1" as"completion" && zinit snippet ${ZSH_THEME_COMPLETION_FILE}" >>${HOME}/.zshrc
        update_zsh_theme_completion
    fi
    case ${UPDATE_ZSH_THEME_COMPLETION} in
    true) update_zsh_theme_completion ;;
    esac
}
################
download_tmoe_zsh() {
    #bash -c "$(curl -L https://cdn.jsdelivr.net/gh/2moe/tmoe-zsh/zsh.sh)"
    case ${TMOE_GIT_REPO} in
    'https://github.com/2moe/tmoe-zsh')
        ZSH_I_URL='https://cdn.jsdelivr.net/gh/2moe/tmoe-zsh@2/zsh-i'
        ZSH_I_URL_02='https://cdn.jsdelivr.net/gh/2moe/tmoe-zsh/zsh.sh'
        ;;
    *)
        ZSH_I_URL="${TMOE_GIT_REPO}/raw/2/zsh-i"
        ZSH_I_URL_02="${TMOE_GIT_REPO}/raw/master/zsh.sh"
        ;;
    esac
    case "${LINUX_DISTRO}" in
    Android)
        curl_zsh_i
        termux-fix-shebang ${PREFIX}/bin/zsh-i
        chmod +x ${PREFIX}/bin/zsh-i
        ;;
    alpine)
        cd /tmp
        wget -O .zsh-i ${ZSH_I_URL}
        chmod_plus_x_zsh_i
        ;;
    *)
        cd /tmp
        curl -Lv -o .zsh-i ${ZSH_I_URL}
        chmod_plus_x_zsh_i
        ;;
    esac
}
############
upgrade_tmoe_zsh_script() {
    #download_tmoe_zsh
    [[ $(command -v zsh-i) ]] || download_tmoe_zsh
    sed -i '/alias zsh-i=/d' "${HOME}/.zshrc"
    if [ -e "${HOME}/.bashrc" ]; then
        sed -i '/alias zsh-i=/d' "${HOME}/.bashrc"
    fi
    printf "%s\n" "Update ${YELLOW}completed${RESET}, press ${GREEN}enter${RESET} to ${BLUE}return.${RESET}"
    printf "%s\n" "${YELLOW}更新完成，按回车键返回。${RESET}"
    read
    source ${PREFIX}/bin/zsh-i
}
##############
update_command_not_found() {
    if [ -e "/usr/lib/command-not-found" ]; then
        case "${LINUX_DISTRO}" in
        debian)
            case "${DEBIAN_DISTRO}" in
            ubuntu) ;;
            *)
                case $(id -u) in
                0)
                    apt-file update 2>/dev/null
                    update-command-not-found 2>/dev/null
                    ;;
                *) ;;
                    #非root不更新，避免输入sudo密码
                esac
                ;;
            esac
            ;;
        esac
    fi
}
##############
git_pull_powerlevel_10k() {
    POWER_LEVEL_DIR="${ZINIT_THEME_DIR}/powerlevel10k"
    if [ -e "${POWER_LEVEL_DIR}/.git" ]; then
        cd "${POWER_LEVEL_DIR}"
        tmoe_git_pull_origin_master
    fi
}
################
git_pull_zinit() {
    cd ${ZINIT_DIR}/bin
    tmoe_git_pull_origin_master
    git_pull_fast_syntax_highlighting
    git_pull_zsh_autosuggestions
}
#############
tmoe_git_pull_origin_master() {
    git reset --hard origin/master
    git pull --rebase --stat --depth=1 origin master --allow-unrelated-histories || git rebase --skip
    case "${?}" in
    0) ;;
    *)
        git fetch --depth=2
        git reset --hard
        git pull --rebase --stat --allow-unrelated-histories || git rebase --skip
        ;;
    esac
}
###########
git_pull_fast_syntax_highlighting() {
    if [ -e "${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR}/.git" ]; then
        cd ${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR}
        tmoe_git_pull_origin_master
    fi
}
###########
git_pull_zsh_autosuggestions() {
    if [ -e "${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR}/.git" ]; then
        cd ${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR}
        tmoe_git_pull_origin_master
    fi
}
#############
git_pull_oh_my_zsh() {
    cd ${OMZ_DIR}
    git reset --hard origin/master
    git pull --rebase --stat --depth=1 origin master --allow-unrelated-histories || git rebase --skip
    #printf "%s\n"  "若oh-my-zsh更新失败，则请手动输${BLUE}zsh ${OMZ_DIR}/tools/upgrade.sh${RESET}" && zsh "${OMZ_DIR}/tools/upgrade.sh"
}
###########
upgrade_zsh_plugins_main "$@"
