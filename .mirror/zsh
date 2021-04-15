#!/usr/bin/env bash
#################################################
main() {
	terminal_color
	gnu_linux_env
	check_system
	case "$1" in
	u | up | -u)
		upgrade_tmoe_zsh_manager
		;;
	h | -h | --h | --help) get_tmoe_zsh_help_info ;;
	--tmoe_container_auto_configure | --tmoe_container_automatic_configure | --auto)
		TMOE_CONTAINER_AUTO_CONFIGURE=true
		tmoe_zsh_installation
		;;
	p | -p | plugin) tmoe_zsh_plugin_manager ;;
	*)
		tmoe_zsh_main_menu
		;;
	esac
}
################
get_tmoe_zsh_help_info() {
	cat <<-'EOF'
		u                                                                            --更新(update tmoe-zsh)
		h                                                                            --get help info
		--auto                                                                       --容器环境自动配置zsh
		p                                                                            -- 插件管理器 plugins manager
	EOF
}
###########
terminal_color() {
	RED=$(printf '\033[31m')
	PURPLE=$(printf '\033[0;35m')
	GREEN=$(printf '\033[32m')
	YELLOW=$(printf '\033[33m')
	BLUE=$(printf '\033[34m')
	BOLD=$(printf '\033[1m')
	RESET=$(printf '\033[m')

	RB_RED=$(printf '\033[38;5;196m')
	RB_ORANGE=$(printf '\033[38;5;202m')
	RB_YELLOW=$(printf '\033[38;5;226m')
	RB_GREEN=$(printf '\033[38;5;082m')
	RB_BLUE=$(printf '\033[38;5;021m')
	RB_INDIGO=$(printf '\033[38;5;093m')
	RB_VIOLET=$(printf '\033[38;5;163m')
}
########
source_tmoe_zsh_env() {
	if [ -e "${TMOE_ZSH_TOOL_DIR}/environment" ]; then
		source ${TMOE_ZSH_TOOL_DIR}/environment
	fi
}
##########
gnu_linux_env() {
	TMOE_CONTAINER_AUTO_CONFIGURE=false
	if [ -z "${TMPDIR}" ]; then
		TMPDIR='/tmp'
	fi
	TERMUX_PATH="${HOME}/.termux"
	TERMUX_KEYBOARD_FILE="${TERMUX_PATH}/termux.properties"
	TERMUX_KEYBOARD_BACKUP_FILE="${TMPDIR}/termux.properties.bak"
	TERMUX_COLOR_FILE="${TERMUX_PATH}/colors.properties"
	TMOE_ZSH_DIR="${HOME}/.config/tmoe-zsh"
	TMOE_ZSH_FONTS_PATH="${TMOE_ZSH_DIR}/fonts"
	TMOE_ZSH_GIT_DIR="${TMOE_ZSH_DIR}/git"
	TMOE_ZSH_TERMUX_PATH="${TMOE_ZSH_DIR}/git/share"
	TMOE_ZSH_CONFIG_DIR="${TMOE_ZSH_TERMUX_PATH}/config"
	TMOE_ZSH_TOOL_DIR="${TMOE_ZSH_GIT_DIR}/tools"
	PLUGIN_SCRIPT="${TMOE_ZSH_TOOL_DIR}/plugins.sh"
	RESTORE_SCRIPT="${TMOE_ZSH_TOOL_DIR}/restore.sh"
	TMOE_GIT_REPO='https://gitee.com/mo2/zsh' #此处不包含.git
	ZINIT_DIR="${HOME}/.zinit"
	ZINIT_THEME_DIR="${ZINIT_DIR}/themes/_local"
	ZINIT_SNIPPETS_LOCAL="${ZINIT_DIR}/snippets/_local"
	OMZ_DIR="${ZINIT_DIR}/omz"
	OMZ_THEME_DIR="${OMZ_DIR}/themes"
	CURRENT_DIR=$(pwd)
	source_tmoe_zsh_env
	if [ ! -e "${TMOE_ZSH_DIR}" ]; then
		mkdir -pv ${TMOE_ZSH_DIR}
	fi
	case $(uname -o) in
	Android) LINUX_DISTRO='Android' ;;
	*)
		PREFIX='/usr/local'
		[[ -d ${PREFIX} ]] || PREFIX='/usr'
		check_linux_distro
		;;
	esac
	check_release_version
}
##########
check_system() {
	if [ -e "${TMOE_ZSH_GIT_DIR}/.termux/themes.sh" ]; then
		cat <<-EOF
			You are using ${RED}old version${RESET}.
			You need to delete the old version first and then reinstall it.
			由于新版改动过大，故不兼容旧版。请删除旧版本！！！
			rm -rv ${TMOE_ZSH_GIT_DIR} $(command -v zsh-i)
		EOF
		do_you_want_to_continue
		case $(command -v zsh-i) in
		"") rm -rv ${TMOE_ZSH_GIT_DIR} ;;
		*) rm -rv ${TMOE_ZSH_GIT_DIR} $(command -v zsh-i) || sudo rm -v $(command -v zsh-i) ;;
		esac
	fi
	case "${LINUX_DISTRO}" in
	Android) #check_termux_dependencies
		check_termux_git_and_dialog ;;
	*) #check_gnu_linux_dependencies
		check_gnu_linux_git_and_whiptail ;;
	esac
}
###############################
case_return_to_where() {
	case ${RETURN_TO_WHERE} in
	"") tmoe_zsh_main_menu ;;
	*) ${RETURN_TO_WHERE} ;;
	esac
}
########################
do_you_want_to_continue() {
	printf "%s\n" "${YELLOW}Do you want to continue?[Y/n]${RESET}"
	printf "%s\n" "Press ${GREEN}enter${RESET} to ${BLUE}continue${RESET},type ${YELLOW}n${RESET} to ${BLUE}return.${RESET}"
	printf "%s\n" "按${GREEN}回车键${RESET}${BLUE}继续${RESET}，输${YELLOW}n${RESET}${BLUE}返回${RESET}"
	read opt
	case $opt in
	y* | Y* | "") ;;
	n* | N*)
		printf "%s\n" "skipped."
		case_return_to_where
		;;
	*)
		printf "%s\n" "Invalid choice. skipped."
		case_return_to_where
		;;
	esac
}
################
press_enter_to_continue() {
	printf "%s\n" "Press ${GREEN}enter${RESET} to ${BLUE}continue.${RESET}"
	printf "%s\n" "按${GREEN}回车键${RESET}${BLUE}继续${RESET}"
	read
}
#################
press_enter_to_return() {
	printf "%s\n" "Press ${GREEN}enter${RESET} to ${BLUE}return.${RESET}"
	printf "%s\n" "按${GREEN}回车键${RESET}${BLUE}返回${RESET}"
	read
}
##################
check_release_version() {
	case "${LINUX_DISTRO}" in
	Android) OSRELEASE="Android" ;;
	*)
		if grep -q 'NAME=' /etc/os-release; then
			OSRELEASE=$(cat /etc/os-release | grep -v 'PRETTY' | grep 'NAME=' | head -n 1 | cut -d '=' -f 2 | cut -d '"' -f 2)
		elif grep -q 'ID=' /etc/os-release; then
			OSRELEASE=$(cat /etc/os-release | grep -v 'VERSION' | grep 'ID=' | head -n 1 | cut -d '=' -f 2)
		else
			OSRELEASE=LINUX
		fi
		;;
	esac
}
#####################
openwrt_router_zsh_command() {
	printf "%s\n" "本工具已不再支持OpenWRT和Entware"
	LINUX_DISTRO='openwrt'
	TMOE_UPDATE_COMMAND='opkg update'
	TMOE_REMOVAL_COMMAND='opkg remove'
}
############
check_linux_distro() {
	TMOE_UPDATE_COMMAND=''
	if grep -Eq 'debian|ubuntu|deepin|uos\.com' "/etc/os-release" 2>/dev/null || [[ $(command -v apt-cache) && $(command -v dpkg) ]]; then
		LINUX_DISTRO='debian'
		TMOE_UPDATE_COMMAND='apt update'
		TMOE_INSTALLATION_COMMAND='eatmydata apt install -y'
		TMOE_REMOVAL_COMMAND='apt purge -y'
		if grep -q 'ubuntu' /etc/os-release; then
			DEBIAN_DISTRO='ubuntu'
		elif [ "$(cat /etc/issue | cut -c 1-4)" = "Kali" ]; then
			DEBIAN_DISTRO='kali'
		fi

	elif grep -Eq "opkg|entware" '/opt/etc/opkg.conf' 2>/dev/null || grep -q 'openwrt' "/etc/os-release"; then
		openwrt_router_zsh_command

	elif grep -q "Alpine" '/etc/issue' || grep -q "Alpine" '/etc/os-release' 2>/dev/null; then
		LINUX_DISTRO='alpine'
		TMOE_INSTALLATION_COMMAND='apk add'
		TMOE_REMOVAL_COMMAND='apk del'

	elif grep -Eq "Arch|Manjaro" '/etc/os-release' 2>/dev/null || grep -Eq "Arch|Manjaro" '/etc/issue' 2>/dev/null; then
		LINUX_DISTRO='arch'
		TMOE_REMOVAL_COMMAND='pacman -Rsc'
		TMOE_INSTALLATION_COMMAND='pacman -Syu --noconfirm'

	elif grep -Eqi "Fedora|CentOS|Red Hat|redhat" "/etc/os-release" 2>/dev/null; then
		LINUX_DISTRO='redhat'
		if [ $(command -v dnf) ]; then
			TMOE_UPDATE_COMMAND='dnf update'
			TMOE_INSTALLATION_COMMAND='dnf install -y --skip-broken'
			TMOE_REMOVAL_COMMAND='dnf remove -y'
		else
			TMOE_UPDATE_COMMAND='yum update'
			TMOE_INSTALLATION_COMMAND='yum install -y --skip-broken'
			TMOE_REMOVAL_COMMAND='yum remove -y'
		fi
		if [ "$(cat /etc/os-release | grep 'ID=' | head -n 1 | cut -d '"' -f 2)" = "centos" ]; then
			REDHAT_DISTRO='centos'
		elif grep -q 'Fedora' "/etc/os-release"; then
			REDHAT_DISTRO='fedora'
		fi

	elif grep -Eq "gentoo|funtoo" '/etc/os-release' 2>/dev/null; then
		LINUX_DISTRO='gentoo'
		TMOE_INSTALLATION_COMMAND='emerge -avk'
		TMOE_REMOVAL_COMMAND='emerge -C'

	elif grep -qi 'suse' '/etc/os-release' 2>/dev/null; then
		LINUX_DISTRO='suse'
		TMOE_INSTALLATION_COMMAND='zypper in -y'
		TMOE_REMOVAL_COMMAND='zypper rm'

	elif [ "$(cat /etc/issue | cut -c 1-4)" = "Void" ]; then
		LINUX_DISTRO='void'
		export LANG='en_US.UTF-8'
		TMOE_INSTALLATION_COMMAND='xbps-install -S -y'
		TMOE_REMOVAL_COMMAND='xbps-remove -R'

	elif grep -q "Slackware" '/etc/os-release' 2>/dev/null; then
		LINUX_DISTRO='slackware'
		TMOE_UPDATE_COMMAND='slackpkg update'
		TMOE_INSTALLATION_COMMAND='slackpkg install'
		TMOE_REMOVAL_COMMAND='slackpkg remove'

	elif grep -q 'Solus' '/etc/os-release'; then
		LINUX_DISTRO='solus'
		TMOE_INSTALLATION_COMMAND='eopkg install -y'
		TMOE_REMOVAL_COMMAND='eopkg remove -y'
	fi
}
#################
check_root() {
	if [ "$(id -u)" != "0" ]; then
		if [ $(command -v curl) ]; then
			sudo -E bash -c "$(curl -LfsS https://cdn.jsdelivr.net/gh/2moe/tmoe-zsh@master/.mirror/zsh)" ||
				su -c "$(curl -LfsS https://cdn.jsdelivr.net/gh/2moe/tmoe-zsh@master/.mirror/zsh)"
		else
			sudo -E bash -c "$(wget -qO- https://cdn.jsdelivr.net/gh/2moe/tmoe-zsh@master/.mirror/zsh)" ||
				su -c "$(wget -qO- https://cdn.jsdelivr.net/gh/2moe/tmoe-zsh@master/.mirror/zsh)"
		fi
		exit 0
	fi
}
###########
install_dependencies_01() {
	case "${LINUX_DISTRO}" in
	debian) ${TMOE_UPDATE_COMMAND} ;;
	alpine) apk_update_source_index ;;
	esac
	######
	case $(id -u) in
	0) ${TMOE_INSTALLATION_COMMAND} ${DEPENDENCIES} ;;
	*)
		if [ $(command -v sudo) ]; then
			sudo ${TMOE_INSTALLATION_COMMAND} ${DEPENDENCIES} || sudo ${TMOE_INSTALLATION_COMMAND} ${DEPENDENCIES} || su -c "${TMOE_INSTALLATION_COMMAND} ${DEPENDENCIES}"
		else
			su -c "${TMOE_INSTALLATION_COMMAND} ${DEPENDENCIES}" || su -c "${TMOE_INSTALLATION_COMMAND} ${DEPENDENCIES}" || su -c "${TMOE_INSTALLATION_COMMAND} ${DEPENDENCIES}"
		fi
		;;
	esac
}
###############
install_dependencies_02() {
	case $(id -u) in
	0)
		eatmydata apt update || apt update
		eatmydata apt install -y ${DEPENDENCIES} || apt-get install -y ${DEPENDENCIES} || eatmydata apt install -y ${DEPENDENCIES_02} || apt-get install -y ${DEPENDENCIES_02}
		;;
	*)
		if [ $(command -v sudo) ]; then
			sudo eatmydata apt update || su -c "apt update"
			sudo eatmydata apt install -y ${DEPENDENCIES} || sudo apt install -y ${DEPENDENCIES} || sudo apt install -y ${DEPENDENCIES_02} || su -c "apt install -y ${DEPENDENCIES_02}"
		else
			su -c "apt update"
			su -c "apt install -y ${DEPENDENCIES} || apt install -y ${DEPENDENCIES_02}" || apt-get install -y "${DEPENDENCIES_02}"
		fi
		;;
	esac
}
###############
apk_update_source_index() {
	case $(id -u) in
	0) apk update ;;
	*)
		if [ $(command -v sudo) ]; then
			sudo apk update
		else
			su -c "apk update"
		fi
		;;
	esac
}
###########
installing_dependencies() {
	printf "%s\n" "Tmoe-zsh will ${YELLOW}install${RESET} relevant ${BLUE}dependencies${RESET} for you."
	printf "%s\n" "正在${YELLOW}安装${RESET}相关${GREEN}软件包${RESET}及其${BLUE}依赖...${RESET}"
	printf "%s\n" "${GREEN}${TMOE_INSTALLATION_COMMAND}${BLUE}${DEPENDENCIES}${RESET}"
	printf "%s\n" "If you want to ${BOLD}${RED}remove it${RESET}${RESET}，please ${YELLOW}manually type ${PURPLE}${TMOE_REMOVAL_COMMAND} ${BLUE}${DEPENDENCIES}${RESET}"
}
###########
check_gnu_linux_git_and_whiptail() {
	DEPENDENCIES=""
	if [ ! $(command -v bash) ]; then
		DEPENDENCIES="${DEPENDENCIES} bash"
	fi
	#gentoo:app-shells/bash
	###########
	if [ ! $(command -v git) ]; then
		case "${LINUX_DISTRO}" in
		openwrt) DEPENDENCIES="${DEPENDENCIES} git git-http" ;;
		gentoo) DEPENDENCIES="${DEPENDENCIES} dev-vcs/git" ;;
		*) DEPENDENCIES="${DEPENDENCIES} git" ;;
		esac
	fi
	###########
	#termux distro-proot中的whiptail为dialog而非whiptail
	if [ "$(command -v whiptail)" = "/data/data/com.termux/files/usr/bin/whiptail" ] || [ ! $(command -v whiptail) ]; then
		case "${LINUX_DISTRO}" in
		debian) DEPENDENCIES="${DEPENDENCIES} whiptail" ;;
		arch) DEPENDENCIES="${DEPENDENCIES} libnewt" ;;
		gentoo) DEPENDENCIES="${DEPENDENCIES} dev-libs/newt" ;;
		openwrt) DEPENDENCIES="${DEPENDENCIES} whiptail dialog" ;;
		*) DEPENDENCIES="${DEPENDENCIES} newt" ;;
		esac
	fi
	case "${LINUX_DISTRO}" in
	debian)
		if [ ! $(command -v eatmydata) ]; then
			printf "%s\n" "apt install -y eatmydata"
			apt update
			apt install -y eatmydata
			#DEPENDENCIES="${DEPENDENCIES} eatmydata"
		fi
		;;
	esac
	#########
	if [ ! -z "${DEPENDENCIES}" ]; then
		installing_dependencies
		case "${LINUX_DISTRO}" in
		debian)
			DEPENDENCIES_02='git whiptail'
			install_dependencies_02
			;;
		openwrt)
			opkg update
			install_dependencies_01 || opkg install ${DEPENDENCIES}
			;;
		alpine | arch | redhat | void | gentoo | suse | slackware | solus)
			install_dependencies_01
			;;
		*)
			printf "%s\n" "${RED}不支持${RESET}您当前的发行版，您可以前往${YELLOW}https://github.com/2moe/tmoe-zsh${RESET}提交issue,并附上${BLUE}cat /etc/os-release${RESET}的截图。"
			press_enter_to_continue
			check_root
			apt update
			apt install -y bash git whiptail || port install ${DEPENDENCIES} || guix package -i ${DEPENDENCIES} || pkg install ${DEPENDENCIES} || pkg_add ${DEPENDENCIES} || pkgutil -i ${DEPENDENCIES}
			;;
		esac
	fi
}
####################################################
check_termux_git_and_dialog() {
	TMOE_UPDATE_COMMAND='apt update'
	TMOE_INSTALLATION_COMMAND='apt install -y'
	TMOE_REMOVAL_COMMAND='apt purge -y'
	if [ ! -h "/data/data/com.termux/files/home/storage/shared" ]; then
		termux-setup-storage
	fi
	DEPENDENCIES=""

	if [ ! -e ${PREFIX}/bin/git ]; then
		DEPENDENCIES="${DEPENDENCIES} git"
	fi

	if [ ! -e ${PREFIX}/bin/whiptail ]; then
		DEPENDENCIES="${DEPENDENCIES} dialog"
	fi

	if [ ! -z "${DEPENDENCIES}" ]; then
		installing_dependencies
		apt update
		apt install -y ${DEPENDENCIES}
	fi
}
###############################################
git_clone_tmoe_zsh() {
	if [ ! -e "${TMOE_ZSH_GIT_DIR}/.git" ]; then
		rm -rvf ${TMOE_ZSH_GIT_DIR} 2>/dev/null
		git clone --depth=1 ${TMOE_GIT_REPO} ${TMOE_ZSH_GIT_DIR}
		source_tmoe_zsh_env
	else
		git_pull_tmoe_zsh
	fi
}
######################################################
git_pull_tmoe_zsh() {
	cd ${TMOE_ZSH_GIT_DIR}
	git reset --hard origin/master
	git pull --rebase --stat origin master --allow-unrelated-histories || git rebase --skip
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
tmoe_zsh_main_menu() {
	#20 50 7
	RETURN_TO_WHERE='tmoe_zsh_main_menu'
	# --backtitle "You can select installation for initial installation."
	TMOE_OPTION=$(whiptail --title "TMOE-ZSH running on ${OSRELEASE}(202102)" --menu "输zsh-i启动本工具,type zsh-i to start this tool.\nPlease use the enter and arrow keys to operate." 0 50 0 \
		"1" "🍭 Installation and configuration 安装与配置" \
		"2" "🌸 Itemized configuration 分项配置" \
		"3" "🍀 Plugins 插件管理" \
		"4" "🏫 FAQ 常见问题" \
		"5" "💔 Remove zsh 移除" \
		"6" "🍹 Backup zsh 备份" \
		"7" "🔯 Restore 恢复/还原" \
		"8" "🍧 Update 更新" \
		"0" "🌚 Exit 退出" \
		3>&1 1>&2 2>&3)
	#############
	case ${TMOE_OPTION} in
	0 | "") exit 0 ;;
	1) tmoe_zsh_installation ;;
	2) tmoe_zsh_itemized_configuration ;;
	3) tmoe_zsh_plugin_manager ;;
	4) tmoe_zsh_faq ;;
	5) tmoe_zsh_uninstallation_menu ;;
	6) tmoe_zsh_backup_menu ;;
	7) tmoe_zsh_restore_menu ;;
	8) upgrade_tmoe_zsh_manager ;;
	esac
	###############
	press_enter_to_return
	tmoe_zsh_main_menu
}
######################
check_tmoe_zsh_plugin_script() {
	if [ ! -e "${TMOE_ZSH_TOOL_DIR}/environment" ]; then
		printf "%s\n" "检测到TMOE配置插件不存在，您需要克隆本项目才能继续使用。"
		printf "%s\n" "Do you want to git clone this repo to ${BLUE}${TMOE_ZSH_GIT_DIR}${RESET}"
		do_you_want_to_continue
		tmoe_zsh_installation
	fi
}
##################
tmoe_zsh_installation() {
	git_clone_tmoe_zsh
	source ${TMOE_ZSH_TOOL_DIR}/install.sh
}
#################
upgrade_tmoe_zsh_manager() {
	check_tmoe_zsh_plugin_script
	source ${TMOE_ZSH_TOOL_DIR}/update.sh
}
###########
tmoe_zsh_itemized_configuration() {
	check_tmoe_zsh_plugin_script
	source ${TMOE_ZSH_TOOL_DIR}/itemized_configuration
}
###############
tmoe_zsh_faq() {
	source ${TMOE_ZSH_TOOL_DIR}/faq
}
##############
tmoe_zsh_uninstallation_menu() {
	source ${TMOE_ZSH_TOOL_DIR}/remove.sh
}
#############
tmoe_zsh_restore_menu() {
	check_tmoe_zsh_plugin_script
	bash ${RESTORE_SCRIPT}
	tmoe_zsh_main_menu
}
###########
tmoe_zsh_backup_menu() {
	check_tmoe_zsh_plugin_script
	source ${TMOE_ZSH_TOOL_DIR}/backup
}
##############
tmoe_install_batcat() {
	if [ ! $(command -v batcat) ] && [ ! $(command -v bat) ] && [ ! -e "${TMOE_ZSH_DIR}/not_install_bat" ]; then
		${TMOE_UPDATE_COMMAND} || sudo ${TMOE_UPDATE_COMMAND}
		printf "%s\n" "${GREEN}${TMOE_INSTALLATION_COMMAND}${RESET} ${BLUE}bat${RESET}"
		${TMOE_INSTALLATION_COMMAND} bat || sudo ${TMOE_INSTALLATION_COMMAND} bat
		printf "%s\n" "If you want to remove it,then type ${RED}${TMOE_REMOVAL_COMMAND}${RESET} ${BLUE}bat${RESET}"
	fi
	if [ ! $(command -v batcat) ] && [ ! $(command -v bat) ]; then
		touch "${TMOE_ZSH_DIR}/not_install_bat"
	fi
}
###########
tmoe_zsh_plugin_manager() {
	tmoe_install_batcat
	check_tmoe_zsh_plugin_script
	bash ${PLUGIN_SCRIPT}
	tmoe_zsh_main_menu
}
##################################################################################
main "$@"
###########################################
