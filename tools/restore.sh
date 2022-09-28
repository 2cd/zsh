#!/usr/bin/env bash
##############################################################
main() {
    terminal_color
    case "$1" in
    *) restore_menu ;;
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
    printf "%s\n" "Press ${GREEN}enter${RESET} to ${BLUE}return.${RESET}"
    printf "%s\n" "按${GREEN}回车键${RESET}${BLUE}返回${RESET}"
    read
}
#####################
press_enter_to_continue() {
    printf "%s\n" "Press ${GREEN}enter${RESET} to ${BLUE}continue.${RESET}"
    printf "%s\n" "按${GREEN}回车键${RESET}${BLUE}继续${RESET}"
    read
}
################
do_you_want_to_continue() {
    printf "%s\n" "${YELLOW}Do you want to continue?[Y/n]${RESET}"
    printf "%s\n" "Press ${GREEN}enter${RESET} to ${BLUE}continue${RESET},type ${YELLOW}n${RESET} to ${BLUE}return.${RESET}"
    printf "%s\n" "按${GREEN}回车键${RESET}${BLUE}继续${RESET}，输${YELLOW}n${RESET}${BLUE}返回${RESET}"
    read opt
    case $opt in
    y* | Y* | "") ;;

    n* | N*)
        printf "%s\n" "skipped."
        ${RETURN_TO_WHERE}
        ;;
    *)
        printf "%s\n" "Invalid choice. skipped."
        ${RETURN_TO_WHERE}
        #beta_features
        ;;
    esac
}
#########################
restore_zsh_with_normal_mode() {
    if ("${TUI_BIN:-dialog}" --title "RESTORE FILE" --yes-button '最新latest' --no-button 'select manually' --yesno "您是想要还原最新文件,还是手动选择备份文件\nDo you want to restore the latest file or select the file manually?" 9 50); then
        check_dir
        cd ${START_DIR}
        RESTORE=$(ls -lth ./tmoe-zsh*tar* | grep ^- | head -n 1 | awk -F ' ' '$0=$NF')
        restore_the_latest_backup_file
    else
        BACKUP_FILE_NAME="tmoe-zsh*tar*"
        where_is_start_dir
    fi
}
#########
select_zsh_backup_path_manually() {
    BACKUP_FILE_NAME="*zsh*tar*"
    file_directory_selection
}
##########
restore_zsh_with_compatibility_mode() {
    BACKUP_FILE_NAME="*zsh*tar*"
    COMPATIBILITY_MODE=true
    file_directory_selection
}
##########
restore_menu() {
    COMPATIBILITY_MODE='fasle'
    RETURN_TO_WHERE='restore_menu'
    OPTION=$("${TUI_BIN:-dialog}" --title "Restore zsh" --menu "你想要把zsh小可爱恢复到之前的备份状态么？" 0 55 0 \
        "1" "normal mode常规模式" \
        "2" "select path manually手动选择路径" \
        "3" "Compatibility mode兼容模式" \
        "0" "Back to the main menu 返回主菜单" \
        3>&1 1>&2 2>&3)
    ###########################################################################
    case ${OPTION} in
    0 | "") exit 0 ;;
    1) restore_zsh_with_normal_mode ;;
    2) select_zsh_backup_path_manually ;;
    3) restore_zsh_with_compatibility_mode ;;
    esac
    ############
}
############
uncompress_other_format_file() {
    pwd
    printf "%s\n" "即将为您解压..."
    if [ ! "$(command -v pv)" ] || [ "${COMPATIBILITY_MODE}" = 'true' ]; then
        printf "%s\n" "${GREEN} tar -Ppxvf ${RESTORE} ${RESET}"
        tar -Ppxvf ${RESTORE}
    else
        printf "%s\n" "${GREEN} pv ${RESTORE} | tar -Ppx ${RESET}"
        pv ${RESTORE} | tar -Ppx
    fi
}
##############
uncompress_tar_xz_file() {
    pwd
    printf '%s\n' 'tar.xz'
    printf "%s\n" "即将为您解压..."
    if [ ! "$(command -v pv)" ] || [ "${COMPATIBILITY_MODE}" = 'true' ]; then
        printf "%s\n" "${GREEN} tar -PpJxvf ${RESTORE} ${RESET}"
        tar -PpJxvf ${RESTORE}
    else
        printf "%s\n" "${GREEN} pv ${RESTORE} | tar -PpJx ${RESET}"
        pv ${RESTORE} | tar -PpJx
    fi
}
######################
uncompress_tar_gz_file() {
    pwd
    printf '%s\n' 'tar.gz'
    printf "%s\n" "即将为您解压..."
    if [ ! "$(command -v pv)" ] || [ "${COMPATIBILITY_MODE}" = 'true' ]; then
        printf "%s\n" "${GREEN} tar -Ppzxvf ${RESTORE} ${RESET}"
        tar -Ppzxvf ${RESTORE}
    else
        printf "%s\n" "${GREEN} pv ${RESTORE} | tar -Ppzx ${RESET}"
        pv ${RESTORE} | tar -Ppzx
    fi
}
#####################
uncompress_tar_file() {
    case "${RESTORE:0-6:6}" in
    tar.xz)
        uncompress_tar_xz_file
        ;;
    tar.gz)
        uncompress_tar_gz_file
        ;;
    *)
        uncompress_other_format_file
        ;;
    esac
    press_enter_to_return
    restore_menu
}
################
select_file_manually() {
    count=0
    printf '%s\n' '您可以在此列表中选择需要恢复的压缩包'
    for restore_file in "${START_DIR}"/${BACKUP_FILE_NAME}; do
        restore_file_name[count]=$(echo $restore_file | awk -F'/' '{print $NF}')
        echo -e "($count) ${restore_file_name[count]}"
        count=$(($count + 1))
    done
    count=$(($count - 1))

    while true; do
        read -p '请输入选项数字,并按回车键。Please type the option number and press Enter:' number
        if [[ -z "$number" ]]; then
            break
        elif ! [[ $number =~ ^[0-9]+$ ]]; then
            printf "%s\n" "Please enter the right number!"
            printf '%s\n' '请输入正确的数字编号！'
        elif (($number >= 0 && $number <= $count)); then
            eval RESTORE=${restore_file_name[number]}
            # cp -fr "${START_DIR}/$choice" "$DIR/restore_file.properties"
            do_you_want_to_continue
            uncompress_tar_file
            break
        else
            printf "%s\n" "Please enter the right number!"
            printf '%s\n' '请输入正确的数字编号！'
        fi
    done
    press_enter_to_return
    restore_menu
}
###############################################
check_dir() {
    START_DIR="${HOME}/sd/Download/backup/zsh"
    for i in /sdcard /sd ${HOME}/sd /media/sd; do
        if [[ -d "${i}" ]]; then
            START_DIR=${i}/Download/backup/zsh
            break
        fi
    done
}
###########
where_is_start_dir() {
    check_dir
    cd ${START_DIR}
    select_file_manually
}
###############
file_directory_selection() {
    if ("${TUI_BIN:-dialog}" --title "FILE PATH" --yes-button '自动auto' --no-button '手动manually' --yesno "您想要手动指定文件目录还是自动选择?\nDo you want to automatically select the file directory?" 9 50); then
        where_is_start_dir
    else
        manually_select_the_file_directory
        select_file_manually
    fi
}
###################
manually_select_the_file_directory() {
    TARGET_BACKUP_FILE_PATH=$("${TUI_BIN:-dialog}" --inputbox "请输入文件路径(精确到目录名称)，例如/sdcard/Download/backup\n Please enter the file path." 10 50 --title "FILEPATH" 3>&1 1>&2 2>&3)
    START_DIR="$(echo ${TARGET_BACKUP_FILE_PATH} | head -n 1 | cut -d ' ' -f 1)"
    echo ${START_DIR}
    if [ -z ${START_DIR} ]; then
        printf "%s\n" "文件目录不能为空"
        press_enter_to_return
        restore_menu
    else
        cd ${START_DIR}
    fi
}
###############
restore_the_latest_backup_file() {
    if [ -z "${RESTORE}" ]; then
        printf "%s\n" "${RED}未检测${RESTORE}到${BLUE}备份文件${RESTORE},请${GREEN}手动选择${RESTORE}"
        press_enter_to_continue
        BACKUP_FILE_NAME=*
        manually_select_the_file_directory
        select_file_manually
    else
        ls -lh ${RESTORE}
        do_you_want_to_continue
        uncompress_tar_file
    fi
    press_enter_to_return
    restore_menu
}
####################
main "$@"
