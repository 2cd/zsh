#!/usr/bin/env bash
##################
zinit_uninstallation_menu() {
    RETURN_TO_WHERE='zinit_uninstallation_menu'
    TMOE_OPTION=$(whiptail --title "REMOVE ZSH" --menu "您想要移除哪个项目？\nWhich item do you want to remove?" 0 50 0 \
        "0" "🌚 Back to the main menu 返回主菜单" \
        "1" "zinit and omz" \
        "2" "fonts 字体" \
        "3" "tmoe-zsh 工具" \
        "4" "zsh and git " \
        "5" "Legacy residual files 旧版残留文件" \
        "6" ".zshrc 配置文件" \
        3>&1 1>&2 2>&3)
    ##############################
    case "${TMOE_OPTION}" in
    0 | "") tmoe_zsh_main_menu ;;
    1) remove_zinit ;;
    2) remove_termux_fonts ;;
    3) remove_tmoe_zsh ;;
    4) remove_git_and_zsh ;;
    5) remove_old_zsh_files ;;
    6) remove_zshrc ;;
    esac
    ##########
    press_enter_to_return
    zinit_uninstallation_menu
}
#################################
remove_zinit() {
    #echo "uninstall_oh_my_zsh 2>/dev/null || rm -rfv ${OMZ_DIR}"
    echo "${RED}rm -rv${RESET} ${BLUE}${ZINIT_DIR}${RESET}"
    do_you_want_to_continue
    rm -rv ${ZINIT_DIR}
}
#########
remove_termux_fonts() {
    echo "rm -rfv ${TERMUX_PATH}/fonts ${TERMUX_PATH}/font.ttf ${TMOE_ZSH_FONTS_PATH}"
    do_you_want_to_continue
    rm -rfv ${TERMUX_PATH}/fonts ${TMOE_ZSH_FONTS_PATH} ${TERMUX_PATH}/font.ttf 2>/dev/null
}
#########
remove_tmoe_zsh() {
    echo "${RED}rm -rf ${TMOE_ZSH_DIR} ${PREFIX}/bin/zsh-i ; sed -i '/alias zshtheme=/d' ${HOME}/.zshrc ${HOME}/.profile${RESET}"
    do_you_want_to_continue
    rm -rfv ${TMOE_ZSH_DIR} ${PREFIX}/bin/zsh-i
    sed -i '/alias zshtheme=/d' "${HOME}/.zshrc" "${HOME}/.profile" 2>/dev/null
    sed -i '/alias zshfont=/d' "${HOME}/.zshrc"
    sed -i '/alias zshcolor=/d' "${HOME}/.zshrc"
    echo "${YELLOW}删除完成，按回车键退出 Press Enter to exit.${RESET} "
    read
    exit 1
}
###########
remove_git_and_zsh() {
    DEPENDENCIES='git zsh whiptail newt xz dialog exa bat fzf'
    echo "${RED}${TMOE_REMOVAL_COMMAND} ${DEPENDENCIES}${RESET}"
    do_you_want_to_continue
    ${TMOE_REMOVAL_COMMAND} ${DEPENDENCIES} 2>/dev/null || sudo ${TMOE_REMOVAL_COMMAND} ${DEPENDENCIES}
    apt autoremove 2>/dev/null
    exit 1
}
##############
remove_old_zsh_files() {
    以下文件夹将被删除，是否确认？
    ls -lAh ${HOME}/.zsh-syntax-highlighting 2>/dev/null
    ls -lAh ${HOME}/.oh-my-zsh 2>/dev/null
    ls -lAh ${HOME}/termux-ohmyzsh 2>/dev/null
    ls -lh ${HOME}/theme 2>/dev/null
    echo "rm -rv ${HOME}/.zsh-syntax-highlighting ${HOME}/termux-ohmyzsh ${HOME}/theme ${HOME}/.oh-my-zsh"
    do_you_want_to_continue
    rm -rv ${HOME}/.zsh-syntax-highlighting ${HOME}/termux-ohmyzsh ${HOME}/theme ${HOME}/.oh-my-zsh
}
###########
remove_zshrc() {
    cat ${HOME}/.zshrc
    ls -lh ${HOME}/.zshrc
    do_you_want_to_continue
    rm -vf ${HOME}/.zshrc
    echo "${YELLOW}删除完成，建议您返回主菜单选择安装与配置Installation and configuration.${RESET} "
}
###########
zinit_uninstallation_menu
