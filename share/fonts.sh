#!/usr/bin/env bash
tmoe_font_main() {
	terminal_color
	tmoe_termux_font_env
	CATCAT_COLOR='false'
	case "$1" in
	h | -h | help | --help | --get-help-info)
		CATCAT_COLOR='true'
		get_tmoe_font_help_info
		;;
	-n | --no-color)
		get_tmoe_font_help_info
		;;
	-num | --number | "")
		get_tmoe_font_help_info
		choose_termux_font
		;;
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
##############
tmoe_termux_font_env() {
	FONTS_DIR=${HOME}/.config/tmoe-zsh/fonts/fonts
	TERMUX_PATH="${HOME}/.termux"
	COUNT=0
	case $(uname -o) in
	Android) ;;
	*)
		get_tmoe_font_help_info
		echo "${RED}Sorry${RESET}！此功能暂未适配GNU/Linux"
		echo "The function of changing fonts is only suitable for termux."
		exit 1
		;;
	esac
}
########
get_tmoe_font_help_info() {
	CATCAT=''
	for i in /bin/lolcat /usr/games/lolcat; do
		[[ ! -f ${i} ]] || CATCAT="${i}"
	done
	unset i
	case ${CATCAT} in
	"") CATCAT='cat' ;;
	esac
	case ${CATCAT_COLOR} in
	false) CATCAT='cat' ;;
	esac
	cat <<-ENDOFTMOEZSHHELP01
		  ${BOLD}${YELLOW}COMMAND${RESET}${RESET}: ${GREEN}zshfont${RESET} 
		  ${BOLD}${YELLOW}命令${RESET}${RESET}: ${GREEN}zshfont${RESET}
		  ${BOLD}${YELLOW}Description${RESET}${RESET}: ${BLUE}This command can change the termux font${RESET}.
		  ${BOLD}${YELLOW}描述${RESET}${RESET}: ${BLUE}此命令能修改终端字体${RESET}。
		  --------------
		  ${YELLOW}-h${RESET}      --help 
		  get-help-info 获取帮助信息
		  --------------
		  ${YELLOW}-num${RESET}    --number list. This is the default mode.
		  If the parameter is empty, it will enter this mode.
		  It is interactive, you need to type ${GREEN}zshfont${RESET} or ${GREEN}zshfont -num${RESET} to start this mode first, and then type the option number,finally press ${YELLOW}Enter${RESET} key.
		  序号列表模式。若参数为空，则将进入此模式。
		  此模式为交互式操作，您可以先输${GREEN}zshfont${RESET}启动,接着输入数字序号。
		  --------------
		  ${BOLD}${YELLOW}此脚本不包含手动模式${RESET}${RESET}
		  以下绝大多数字体支持powerline，少部分字体支持powerlevel 10k的特殊字符。
		  例如：Iosevka，MesloLGS-NF-Bold,MesloLGS-NF-Bold-Italic,MesloLGS-NF-Italic和MesloLGS-NF-Regular。
		  --------------
	ENDOFTMOEZSHHELP01
}
######
choose_termux_font() {
	echo -e "The default font is Iosevka.\nYou can choose another one from list below."
	echo "您可以在${BLUE}此列表${RESET}中选择终端${YELLOW}字体${RESET}。"
	for TERMUX_FONT in ${FONTS_DIR}/*/{*.ttf,*.otf}; do
		TERMUX_FONT_FILE[COUNT]=${TERMUX_FONT}
		echo "[${COUNT}] $(echo ${TERMUX_FONT_FILE[COUNT]} | awk -F '/' '{print $NF}')"
		COUNT=$((${COUNT} + 1))
	done
	COUNT=$((${COUNT} - 1))

	while true; do
		read -p '请输入选项数字,并按回车键。Please type the option number and press Enter:' FONT_NUMBER

		if [[ -z "${FONT_NUMBER}" ]]; then
			break
		elif ! [[ ${FONT_NUMBER} =~ ^[0-9]+$ ]]; then
			echo "Please type the right number."
		elif ((${FONT_NUMBER} >= 0 && ${FONT_NUMBER} <= ${COUNT})); then
			#eval CHOICE=${TERMUX_FONT_FILE[FONT_NUMBER]}
			#cp -pfvr "${CHOICE}" "${TERMUX_PATH}/font.ttf"
			cp -fr "${TERMUX_FONT_FILE[FONT_NUMBER]}" "${TERMUX_PATH}/font.ttf"
			break
		else
			echo "Please type the right number."
		fi
	done
	#echo "您可以输 ${YELLOW}zshfont${RESET}来更改${BLUE}字体${RESET}, you can type ${GREEN}zshfont${RESET} to change the ${BLUE}font${RESET}."
	cat <<-ENDOFTMOEZSHHELP03
		  输${YELLOW}zshfont -h${RESET}来获取${BLUE}终端字体帮助信息${RESET}。
		  You can type ${GREEN}zshfont -h${RESET} to get the ${BLUE}terminal font help info${RESET}.
	ENDOFTMOEZSHHELP03
	termux-reload-settings
}
##############
tmoe_font_main "$@"
