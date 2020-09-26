#!/usr/bin/env bash
#################################################
main() {
	terminal_color
	gnu_linux_env
	check_system
	case "$1" in
	up* | -u*)
		upgrade_tmoe_zsh_manager
		;;
	h | -h | --h | --help) get_tmoe_zsh_help_info ;;
	--tmoe_container_automatic_configure)
		TMOE_CONTAINER_AUTO_CONFIGURE='true'
		tmoe_zsh_installation
		;;
	-p | plugin) tmoe_zsh_plugin_manager ;;
	*)
		tmoe_zsh_main_menu
		;;
	esac
}
################
get_tmoe_zsh_help_info() {
	cat <<-'EOF'
		-u                                                                            --更新(update tmoe-zsh)
		-h                                                                            --get help info
		--tmoe_container_automatic_configure                                          --容器环境自动配置zsh
		-p                                                                            -- 插件管理器 plugins manager
	EOF
}
###########
terminal_color() {
	RED=$(printf '\033[31m')
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
	TMOE_CONTAINER_AUTO_CONFIGURE='false'
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
	TMOE_ZSH_TOOL_DIR="${TMOE_ZSH_GIT_DIR}/tools"
	PLUGIN_SCRIPT="${TMOE_ZSH_TOOL_DIR}/plugins.sh"
	RESTORE_SCRIPT="${TMOE_ZSH_TOOL_DIR}/restore.sh"
	TMOE_GIT_REPO='https://https://github.com/2moe/tmoe-zsh' #此处不包含.git
	ZINIT_DIR="${HOME}/.zinit"
	ZINIT_THEME_DIR="${ZINIT_DIR}/themes/_local"
	OMZ_DIR="${ZINIT_DIR}/omz"
	OMZ_THEME_DIR="${OMZ_DIR}/themes"
	CURRENT_DIR=$(pwd)
	source_tmoe_zsh_env
	if [ ! -e "${TMOE_ZSH_DIR}" ]; then
		mkdir -p ${TMOE_ZSH_DIR}
	fi
	case $(uname -o) in
	Android) LINUX_DISTRO='Android' ;;
	*)
		PREFIX='/usr/local'
		check_linux_distro
		;;
	esac
	check_release_version
}
##########
check_system() {
	#舊版（202009之前的版本）tmoe-zsh需要更新
	#if grep -q 'alias zsh-i=' ${HOME}/.zshrc 2>/dev/null; then
	#	upgrade_tmoe_zsh_manager
	#fi
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
	echo "${YELLOW}Do you want to continue?[Y/n]${RESET}"
	echo "Press ${GREEN}enter${RESET} to ${BLUE}continue${RESET},type ${YELLOW}n${RESET} to ${BLUE}return.${RESET}"
	echo "按${GREEN}回车键${RESET}${BLUE}继续${RESET}，输${YELLOW}n${RESET}${BLUE}返回${RESET}"
	read opt
	case $opt in
	y* | Y* | "") ;;
	n* | N*)
		echo "skipped."
		case_return_to_where
		;;
	*)
		echo "Invalid choice. skipped."
		case_return_to_where
		;;
	esac
}
################
press_enter_to_continue() {
	echo "Press ${GREEN}enter${RESET} to ${BLUE}continue.${RESET}"
	echo "按${GREEN}回车键${RESET}${BLUE}继续${RESET}"
	read
}
#################
press_enter_to_return() {
	echo "Press ${GREEN}enter${RESET} to ${BLUE}return.${RESET}"
	echo "按${GREEN}回车键${RESET}${BLUE}返回${RESET}"
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
	echo "本工具已不再支持OpenWRT和Entware"
	LINUX_DISTRO='openwrt'
	TMOE_UPDATE_COMMAND='opkg update'
	TMOE_REMOVAL_COMMAND='opkg remove'
	cd /tmp
	if [ ! -e "router-zsh.bash" ]; then
		wget --no-check-certificate -qO "router-zsh.bash" ${TMOE_GIT_REPO}/raw/master/zsh.sh
	fi
	chmod +x 'router-zsh.bash'
	#bash -c "$(cat 'router-zsh.bash' |sed 's@/usr/bin@/opt/bin@g' |sed 's@-e /bin@-e /opt/bin@g' |sed 's@whiptail@dialog@g')"
	sed -i 's@/usr/bin@/opt/bin@g' 'router-zsh.bash'
	sed -i 's@-e /bin@-e /opt/bin@g' 'router-zsh.bash'
	sed -i 's@whiptail@dialog@g' 'router-zsh.bash'
	sed -i 's@wget --no-check-certificate -qO "router-zsh.bash"@#&@' 'router-zsh.bash'
	sed -i 's@bash router-zsh.bash@#&@' 'router-zsh.bash'
	source router-zsh.bash
}
############
check_linux_distro() {
	TMOE_UPDATE_COMMAND=''
	if grep -Eq 'debian|ubuntu|deepin|uos' "/etc/os-release" 2>/dev/null; then
		LINUX_DISTRO='debian'
		TMOE_UPDATE_COMMAND='apt update'
		TMOE_INSTALLATON_COMMAND='apt install -y'
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
		TMOE_INSTALLATON_COMMAND='apk add'
		TMOE_REMOVAL_COMMAND='apk del'

	elif grep -Eq "Arch|Manjaro" '/etc/os-release' 2>/dev/null || grep -Eq "Arch|Manjaro" '/etc/issue' 2>/dev/null; then
		LINUX_DISTRO='arch'
		TMOE_REMOVAL_COMMAND='pacman -Rsc'
		TMOE_INSTALLATON_COMMAND='pacman -Syu --noconfirm'

	elif grep -Eqi "Fedora|CentOS|Red Hat|redhat" "/etc/os-release" 2>/dev/null; then
		LINUX_DISTRO='redhat'
		TMOE_UPDATE_COMMAND='dnf update'
		TMOE_INSTALLATON_COMMAND='dnf install -y --skip-broken'
		TMOE_REMOVAL_COMMAND='dnf remove -y'
		if [ "$(cat /etc/os-release | grep 'ID=' | head -n 1 | cut -d '"' -f 2)" = "centos" ]; then
			REDHAT_DISTRO='centos'
		elif grep -q 'Fedora' "/etc/os-release"; then
			REDHAT_DISTRO='fedora'
		fi

	elif grep -Eq "gentoo|funtoo" '/etc/os-release' 2>/dev/null; then
		LINUX_DISTRO='gentoo'
		TMOE_INSTALLATON_COMMAND='emerge -avk'
		TMOE_REMOVAL_COMMAND='emerge -C'

	elif grep -qi 'suse' '/etc/os-release' 2>/dev/null; then
		LINUX_DISTRO='suse'
		TMOE_INSTALLATON_COMMAND='zypper in -y'
		TMOE_REMOVAL_COMMAND='zypper rm'

	elif [ "$(cat /etc/issue | cut -c 1-4)" = "Void" ]; then
		LINUX_DISTRO='void'
		export LANG='en_US.UTF-8'
		TMOE_INSTALLATON_COMMAND='xbps-install -S -y'
		TMOE_REMOVAL_COMMAND='xbps-remove -R'

	elif grep -Eq "Slackware" '/etc/os-release' 2>/dev/null; then
		LINUX_DISTRO='slackware'
	fi
}
#################
check_root() {
	if [ "$(id -u)" != "0" ]; then
		if [ $(command -v curl) ]; then
			sudo -E bash -c "$(curl -LfsS ${TMOE_GIT_REPO}/raw/master/zsh.sh)" ||
				su -c "$(curl -LfsS ${TMOE_GIT_REPO}/raw/master/zsh.sh)"
		else
			sudo -E bash -c "$(wget -qO- ${TMOE_GIT_REPO}/raw/master/zsh.sh)" ||
				su -c "$(wget -qO- ${TMOE_GIT_REPO}/raw/master/zsh.sh)"
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
	0)
		${TMOE_INSTALLATON_COMMAND} ${DEPENDENCIES}
		;;
	*)
		if [ $(command -v sudo) ]; then
			sudo ${TMOE_INSTALLATON_COMMAND} ${DEPENDENCIES}
		else
			su -c "${TMOE_INSTALLATON_COMMAND} ${DEPENDENCIES}"
		fi
		;;
	esac
}
###############
install_dependencies_02() {
	case $(id -u) in
	0)
		apt update
		apt install -y ${DEPENDENCIES} || apt install -y ${DEPENDENCIES_02}
		;;
	*)
		if [ $(command -v sudo) ]; then
			sudo apt update
			sudo apt install -y ${DEPENDENCIES} || sudo apt install -y ${DEPENDENCIES_02}
		else
			su -c "apt update"
			su -c "apt install -y ${DEPENDENCIES} || apt install -y ${DEPENDENCIES_02}"
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
	echo "正在${YELLOW}安装${RESET}相关${GREEN}软件包${RESET}及其${BLUE}依赖...${RESET}"
	echo "${GREEN}${TMOE_INSTALLATON_COMMAND}${BLUE}${DEPENDENCIES}${RESET}"
	echo "如需${BOLD}${RED}卸载${RESET}${RESET}，请${YELLOW}手动${RESET}输${RED}${TMOE_REMOVAL_COMMAND}${RESET}${BLUE}${DEPENDENCIES}${RESET}"
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
		alpine | arch | redhat | void | gentoo | suse | slackware)
			install_dependencies_01
			;;
		*)
			echo "不支持您当前的发行版，您可以前往git仓库地址提交issue,并附上${BLUE}cat /etc/os-release${RESET}的截图。"
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
	TMOE_INSTALLATON_COMMAND='apt install -y'
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
	git pull origin master --allow-unrelated-histories
	case "${?}" in
	0) ;;
	*)
		git fetch --depth=2
		git reset --hard
		git pull --allow-unrelated-histories
		;;
	esac
}
###########
tmoe_zsh_main_menu() {
	#20 50 7
	RETURN_TO_WHERE='tmoe_zsh_main_menu'
	TMOE_OPTION=$(whiptail --title "TMOE-ZSH running on ${OSRELEASE}(202009)" --backtitle "Please select installation for initial installation." --menu "输zsh-i启动本工具,type zsh-i to start this tool.\nPlease use the enter and arrow keys to operate." 0 50 0 \
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
		echo "检测到TMOE配置插件不存在，您需要克隆本项目才能继续使用。"
		echo "Do you want to git clone this repo to ${BLUE}${TMOE_ZSH_GIT_DIR}${RESET}"
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
		echo "${GREEN}${TMOE_INSTALLATON_COMMAND}${RESET} ${BLUE}bat${RESET}"
		${TMOE_INSTALLATON_COMMAND} bat || sudo ${TMOE_INSTALLATON_COMMAND} bat
		echo "If you want to remove it,then type ${RED}${TMOE_REMOVAL_COMMAND}${RESET} ${BLUE}bat${RESET}"
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
