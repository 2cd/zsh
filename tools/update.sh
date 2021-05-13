#!/usr/bin/env bash
################
upgrade_zsh_plugins_main() {
    check_tmoe_zsh_theme_completion_version
    case "$1" in
    -download)
        check_zsh_theme_completion
        check_zsh_i
        termux_fix_shebang_zshtheme
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
        termux_fix_shebang_zshtheme
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
        case ${THE_LATEST_ZSH_COMPLETION_VERSION} in
        "") UPDATE_ZSH_THEME_COMPLETION=true ;;
        *)
            if ((${CURRENT_ZSH_THEME_COMPLETTION_VERSION} < ${THE_LATEST_ZSH_COMPLETION_VERSION})); then
                UPDATE_ZSH_THEME_COMPLETION=true
            fi
            ;;
        esac
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
    rm -rvf ${ZINIT_DIR}/snippets/$(echo ${ZSH_THEME_COMPLETION_FILE} | sed 's@/_zshtheme@@' | sed 's@^/@@g ; 's@/@--@g'') ${ZINIT_DIR}/completions/_zshtheme
    if [ ! -e ${HOME}/.local/bin/zshtheme ]; then
        # if [ -x ${PREFIX}/bin/zshtheme ]; then
        #     rm -fv ${PREFIX}/bin/zshtheme || sudo rm -fv ${PREFIX}/bin/zshtheme
        # fi
        if [[ ! -d ${HOME}/.local/bin ]]; then
            mkdir -pv ${HOME}/.local/bin
        fi
        if [[ -e ${HOME}/.zshrc ]]; then
            if grep -q 'alias zshtheme=' ${HOME}/.zshrc; then
                sed -i '/alias zshtheme=/d' ${HOME}/.zshrc ${HOME}/.profile 2>/dev/null
            fi
        fi
        ln -svf ${TMOE_ZSH_TERMUX_PATH}/themes.sh ${HOME}/.local/bin/zshtheme
    fi
}
#############
termux_fix_shebang_zshtheme() {
    if [[ $(uname -o) = Android && $(command -v termux-fix-shebang) ]]; then
        termux-fix-shebang $(command -v zshtheme)
    fi
}
check_zsh_theme_completion() {
    ZSH_THEME_COMPLETION_FILE="${TMOE_ZSH_TERMUX_PATH}/completion/_zshtheme"
    if ! egrep -q '^[^#]*zinit.*completion/_zshtheme' ${HOME}/.zshrc; then
        #mkdir -pv ${ZINIT_SNIPPETS_LOCAL}
        printf "%s\n" "zinit ice lucid wait="1" as"completion" && zinit snippet ${ZSH_THEME_COMPLETION_FILE}" >>${HOME}/.zshrc
        update_zsh_theme_completion
    fi
    case ${UPDATE_ZSH_THEME_COMPLETION} in
    true) update_zsh_theme_completion ;;
    esac
}
################
check_zsh_i() {
    if [[ ! -e ${HOME}/.local/bin/zsh-i ]]; then
        mkdir -pv ${HOME}/.local/bin
        ln -svf ${HOME}/.config/tmoe-zsh/git/zsh.sh ${HOME}/.local/bin/zsh-i
    fi
    [[ ! $(command -v termux-fix-shebang) ]] || termux-fix-shebang ${HOME}/.local/bin/zsh-i
}
upgrade_tmoe_zsh_script() {
    check_zsh_i
    sed -i '/alias zsh-i=/d' "${HOME}/.zshrc"
    if [ -e "${HOME}/.bashrc" ]; then
        sed -i '/alias zsh-i=/d' "${HOME}/.bashrc"
    fi
    printf "%s\n" "Update ${YELLOW}completed${RESET}, press ${GREEN}enter${RESET} to ${BLUE}return.${RESET}"
    printf "%s\n" "${YELLOW}更新完成，按回车键返回。${RESET}"
    read
    source ${HOME}/.local/bin/zsh-i
    # source ${PREFIX}/bin/zsh-i
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
    #printf "%s\n" "若oh-my-zsh更新失败，则请手动输${BLUE}zsh ${OMZ_DIR}/tools/upgrade.sh${RESET}" && zsh "${OMZ_DIR}/tools/upgrade.sh"
}
###########
upgrade_zsh_plugins_main "$@"
