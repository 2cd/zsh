#!/usr/bin/env bash
#################################################
main() {
	terminal_color
	gnu_linux_env
	case "$1" in
	up* | -u*)
		upgrade_tmoe_zsh_manager
		;;
	h | -h | --help) get_tmoe_zsh_help_info ;;
	*)
		check_system
		;;
	esac
}
################
get_tmoe_zsh_help_info() {
	cat <<-'EOF'
		-u  --更新(update tmoe-zsh)
		-h  --get help info
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
gnu_linux_env() {
	if [ -z "${TMPDIR}" ]; then
		TMPDIR='/tmp'
	fi
	TERMUX_PATH="${HOME}/.termux"
	TERMUX_KEYBOARD_FILE="${TERMUX_PATH}/termux.properties"
	TERMUX_KEYBOARD_BACKUP_FILE="${TMPDIR}/termux.properties.bak"
	TERMUX_COLOR_FILE="${TERMUX_PATH}/colors.properties"
	TMOE_ZSH_PATH="${HOME}/.config/tmoe-zsh"
	TMOE_ZSH_FONTS_PATH="${TMOE_ZSH_PATH}/fonts"
	TMOE_ZSH_GIT_PATH="${TMOE_ZSH_PATH}/git"
	TMOE_ZSH_TERMUX_PATH="${TMOE_ZSH_PATH}/git/.termux"
	PLUGIN_SCRIPT="${TMOE_ZSH_GIT_PATH}/tools/plugins.sh"
	RESTORE_SCRIPT="${TMOE_ZSH_GIT_PATH}/tools/restore.sh"
	TMOE_GIT_REPO='https://gitee.com/mo2/zsh'
	cur=$(pwd)

	if [ ! -e "${TMOE_ZSH_PATH}" ]; then
		mkdir -p ${TMOE_ZSH_PATH}
	fi

	if [ "$(uname -o)" = "Android" ]; then
		LINUX_DISTRO='Android'
	else
		PREFIX='/usr/local'
		check_current_user_name_and_group
		check_linux_distro
	fi
}
##########
check_system() {
	if grep -q 'alias zsh-i=' ${HOME}/.zshrc; then
		upgrade_tmoe_zsh_manager
	fi

	if [ "${LINUX_DISTRO}" = "Android" ]; then
		check_termux_depencies
	else
		check_gnu_linux_depencies
	fi
}
###############################
do_you_want_to_continue() {
	echo "${YELLOW}Do you want to continue?[Y/n]${RESET}"
	echo "Press ${GREEN}enter${RESET} to ${BLUE}continue${RESET},type ${YELLOW}n${RESET} to ${BLUE}return.${RESET}"
	echo "按${GREEN}回车键${RESET}${BLUE}继续${RESET}，输${YELLOW}n${RESET}${BLUE}返回${RESET}"
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
check_linux_distro() {
	if grep -Eq 'debian|ubuntu' "/etc/os-release"; then
		LINUX_DISTRO='debian'
		PACKAGES_UPDATE_COMMAND='apt update'
		PACKAGES_INSTALL_COMMAND='apt install -y'
		PACKAGES_REMOVE_COMMAND='apt purge -y'
		if grep -q 'ubuntu' /etc/os-release; then
			DEBIAN_DISTRO='ubuntu'
		elif [ "$(cat /etc/issue | cut -c 1-4)" = "Kali" ]; then
			DEBIAN_DISTRO='kali'
		fi

	elif grep -Eq "opkg|entware" '/opt/etc/opkg.conf' 2>/dev/null || grep -q 'openwrt' "/etc/os-release"; then
		LINUX_DISTRO='openwrt'
		PACKAGES_UPDATE_COMMAND='opkg update'
		PACKAGES_REMOVE_COMMAND='opkg remove'
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

	elif grep -q "Alpine" '/etc/issue' || grep -q "Alpine" '/etc/os-release'; then
		LINUX_DISTRO='alpine'
		PACKAGES_INSTALL_COMMAND='apk add'
		PACKAGES_REMOVE_COMMAND='apk del'

	elif grep -Eq "Arch|Manjaro" '/etc/os-release' || grep -Eq "Arch|Manjaro" '/etc/issue'; then
		LINUX_DISTRO='arch'
		PACKAGES_REMOVE_COMMAND='pacman -Rsc'
		PACKAGES_INSTALL_COMMAND='pacman -Syu --noconfirm'

	elif grep -Eqi "Fedora|CentOS|Red Hat|redhat" "/etc/os-release"; then
		LINUX_DISTRO='redhat'
		PACKAGES_UPDATE_COMMAND='dnf update'
		PACKAGES_INSTALL_COMMAND='dnf install -y --skip-broken'
		PACKAGES_REMOVE_COMMAND='dnf remove -y'
		if [ "$(cat /etc/os-release | grep 'ID=' | head -n 1 | cut -d '"' -f 2)" = "centos" ]; then
			REDHAT_DISTRO='centos'
		elif grep -q 'Fedora' "/etc/os-release"; then
			REDHAT_DISTRO='fedora'
		fi

	elif grep -Eq "gentoo|funtoo" '/etc/os-release'; then
		LINUX_DISTRO='gentoo'
		PACKAGES_INSTALL_COMMAND='emerge -vk'
		PACKAGES_REMOVE_COMMAND='emerge -C'

	elif grep -qi 'suse' '/etc/os-release'; then
		LINUX_DISTRO='suse'
		PACKAGES_INSTALL_COMMAND='zypper in -y'
		PACKAGES_REMOVE_COMMAND='zypper rm'

	elif [ "$(cat /etc/issue | cut -c 1-4)" = "Void" ]; then
		LINUX_DISTRO='void'
		PACKAGES_INSTALL_COMMAND='xbps-install -S -y'
		PACKAGES_REMOVE_COMMAND='xbps-remove -R'

	elif grep -Eq "Slackware" '/etc/os-release'; then
		LINUX_DISTRO='slackware'
	fi
}
#################
check_current_user_name_and_group() {
	CURRENT_USER_NAME=$(cat /etc/passwd | grep "${HOME}" | awk -F ':' '{print $1}')
	CURRENT_USER_GROUP=$(cat /etc/passwd | grep "${HOME}" | awk -F ':' '{print $5}' | cut -d ',' -f 1)
	if [ -z "${CURRENT_USER_GROUP}" ]; then
		CURRENT_USER_GROUP=${CURRENT_USER_NAME}
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
check_gnu_linux_depencies() {
	DEPENDENCIES=""
	if [ ! -e /bin/bash ]; then
		DEPENDENCIES="${DEPENDENCIES} bash"
	fi

	if [ ! -e "/usr/lib/command-not-found" ]; then
		if [ "${LINUX_DISTRO}" = "debian" ]; then
			DEPENDENCIES="${DEPENDENCIES} command-not-found"
		fi
	fi

	if [ ! $(command -v cmp) ]; then
		if [ "${LINUX_DISTRO}" = "arch" ]; then
			DEPENDENCIES="${DEPENDENCIES} diffutils"
		fi
	fi
	###########################################
	if [ ! $(command -v fzf) ]; then
		if [ "${LINUX_DISTRO}" = "debian" ] || [ "${LINUX_DISTRO}" = "alpine" ] || [ "${REDHAT_DISTRO}" = "fedora" ] || [ "${LINUX_DISTRO}" = "arch" ]; then
			DEPENDENCIES="${DEPENDENCIES} fzf"
		fi
	fi

	if [ ! $(command -v git) ]; then
		if [ "${LINUX_DISTRO}" = "openwrt" ]; then
			DEPENDENCIES="${DEPENDENCIES} git git-http"
		elif [ "${LINUX_DISTRO}" = "gentoo" ]; then
			DEPENDENCIES="${DEPENDENCIES} dev-vcs/git"
		else
			DEPENDENCIES="${DEPENDENCIES} git"
		fi
	fi
	####################################
	if [ ! $(command -v pv) ]; then
		if [ "${LINUX_DISTRO}" = "gentoo" ]; then
			DEPENDENCIES="${DEPENDENCIES} sys-apps/pv"
		elif [ "${LINUX_DISTRO}" = 'redhat' ]; then
			if [ "${REDHAT_DISTRO}" = 'fedora' ]; then
				DEPENDENCIES="${DEPENDENCIES} pv"
			fi
		else
			DEPENDENCIES="${DEPENDENCIES} pv"
		fi
	fi

	if [ ! $(command -v tar) ]; then
		if [ "${LINUX_DISTRO}" = "gentoo" ]; then
			DEPENDENCIES="${DEPENDENCIES} app-arch/tar"
		else
			DEPENDENCIES="${DEPENDENCIES} tar"
		fi
	fi
	############################
	if [ ! $(command -v whiptail) ]; then
		if [ "${LINUX_DISTRO}" = "debian" ]; then
			DEPENDENCIES="${DEPENDENCIES} whiptail"
		elif [ "${LINUX_DISTRO}" = "arch" ]; then
			DEPENDENCIES="${DEPENDENCIES} libnewt"
		elif [ "${LINUX_DISTRO}" = "openwrt" ]; then
			DEPENDENCIES="${DEPENDENCIES} dialog"
		elif [ "${LINUX_DISTRO}" = "gentoo" ]; then
			DEPENDENCIES="${DEPENDENCIES} dev-libs/newt"
		else
			DEPENDENCIES="${DEPENDENCIES} newt"
		fi
	fi

	if [ ! $(command -v wget) ]; then
		if [ "${LINUX_DISTRO}" = "gentoo" ]; then
			DEPENDENCIES="${DEPENDENCIES} net-misc/wget"
		else
			DEPENDENCIES="${DEPENDENCIES} wget"
		fi
	fi
	###########################
	if [ ! $(command -v xz) ]; then
		if [ "${LINUX_DISTRO}" = "debian" ]; then
			DEPENDENCIES="${DEPENDENCIES} xz-utils"
		elif [ "${LINUX_DISTRO}" = "gentoo" ]; then
			DEPENDENCIES="${DEPENDENCIES} app-arch/xz-utils"
		else
			DEPENDENCIES="${DEPENDENCIES} xz"
		fi
	fi

	if [ ! $(command -v zsh) ]; then
		if [ "${LINUX_DISTRO}" = "alpine" ]; then
			DEPENDENCIES="${DEPENDENCIES} zsh zsh-vcs"
		elif [ "${LINUX_DISTRO}" = "gentoo" ]; then
			DEPENDENCIES="${DEPENDENCIES} app-shells/zsh"
		else
			DEPENDENCIES="${DEPENDENCIES} zsh"
		fi
	fi
	#############################
	if [ ! -z "${DEPENDENCIES}" ] && [ ! -e ${TMOE_ZSH_PATH}/non_fzf ]; then
		echo "正在${YELLOW}安装${RESET}相关${GREEN}软件包${RESET}及其${BLUE}依赖...${RESET}"
		echo "${GREEN}${PACKAGES_INSTALL_COMMAND}${BLUE}${DEPENDENCIES}${RESET}"
		echo "如需${BOLD}${RED}卸载${RESET}${RESET}，请${YELLOW}手动${RESET}输${RED}${PACKAGES_REMOVE_COMMAND}${RESET}${BLUE}${DEPENDENCIES}${RESET}"

		if [ "${LINUX_DISTRO}" = "debian" ]; then
			apt update || sudo apt update || su -c "apt update"
			DEPENDENCIES_02='command-not-found zsh git pv wget xz-utils tar whiptail'
			apt install -y ${DEPENDENCIES} || sudo apt install -y ${DEPENDENCIES} || sudo apt install -y ${DEPENDENCIES_02} || su -c "apt install -y ${DEPENDENCIES_02}"
			if [ ! $(command -v fzf) ]; then
				echo '' >${TMOE_ZSH_PATH}/non_fzf
			fi
		elif
			[ "${LINUX_DISTRO}" = "alpine" ]
		then
			apk add ${DEPENDENCIES} || sudo apk add ${DEPENDENCIES} || su -c "apk add ${DEPENDENCIES}"
			#apk add -q xz newt tar zsh git wget bash zsh-vcs pv

		elif [ "${LINUX_DISTRO}" = "arch" ]; then
			pacman -Syu --noconfirm ${DEPENDENCIES} || sudo pacman -Syu --noconfirm ${DEPENDENCIES}

		elif [ "${LINUX_DISTRO}" = "redhat" ]; then
			dnf install -y --skip-broken ${DEPENDENCIES} || yum install -y --skip-broken ${DEPENDENCIES} || sudo dnf install -y --skip-broken ${DEPENDENCIES} || sudo yum install -y --skip-broken ${DEPENDENCIES}
			#dnf install -y zsh git pv wget xz tar newt || yum install -y zsh git pv wget xz tar newt

		elif [ "${LINUX_DISTRO}" = "openwrt" ]; then
			#opkg update
			check_root
			opkg install ${DEPENDENCIES} || opkg install whiptail

		elif [ "${LINUX_DISTRO}" = "void" ]; then
			check_root
			xbps-install -S
			xbps-install -y ${DEPENDENCIES}

		elif [ "${LINUX_DISTRO}" = "gentoo" ]; then
			check_root
			emerge -av ${DEPENDENCIES}

		elif [ "${LINUX_DISTRO}" = "suse" ]; then
			check_root
			zypper in -y ${DEPENDENCIES}

		elif [ "${LINUX_DISTRO}" = "slackware" ]; then
			check_root
			slackpkg install ${DEPENDENCIES}

		else
			check_root
			apt update
			apt install -y zsh git pv wget xz-utils tar whiptail command-not-found || port install ${DEPENDENCIES} || guix package -i ${DEPENDENCIES} || pkg install ${DEPENDENCIES} || pkg_add ${DEPENDENCIES} || pkgutil -i ${DEPENDENCIES}
		fi
	fi
	#git_clone_tmoe_zsh
	tmoe_zsh_main_menu
}
####################################################
check_termux_depencies() {
	PACKAGES_UPDATE_COMMAND='apt update'
	PACKAGES_INSTALL_COMMAND='apt install -y'
	PACKAGES_REMOVE_COMMAND='apt purge -y'
	if [ ! -h "/data/data/com.termux/files/home/storage/shared" ]; then
		termux-setup-storage
	fi
	DEPENDENCIES=""

	if [ ! -e $PREFIX/bin/zsh ]; then
		DEPENDENCIES="${DEPENDENCIES} zsh"
	fi

	if [ ! -e $PREFIX/bin/git ]; then
		DEPENDENCIES="${DEPENDENCIES} git"
	fi

	if [ ! -e $PREFIX/bin/wget ]; then
		DEPENDENCIES="${DEPENDENCIES} wget"
	fi

	if [ ! -e $PREFIX/bin/pv ]; then
		DEPENDENCIES="${DEPENDENCIES} pv"
	fi

	if [ ! -e $PREFIX/bin/xz ]; then
		DEPENDENCIES="${DEPENDENCIES} xz-utils"
	fi

	if [ ! -e $PREFIX/bin/tar ]; then
		DEPENDENCIES="${DEPENDENCIES} tar"
	fi

	if [ ! -e $PREFIX/bin/whiptail ]; then
		DEPENDENCIES="${DEPENDENCIES} dialog"
	fi

	if [ ! -e $PREFIX/bin/fzf ]; then
		DEPENDENCIES="${DEPENDENCIES} fzf"
	fi

	if [ ! -z "$DEPENDENCIES" ]; then
		echo "正在安装相关依赖..."
		apt update
		apt install -y ${DEPENDENCIES}
	fi
	#android_git_clone_fonts
	tmoe_zsh_main_menu
}
###############################################
git_clone_termux_font_files() {
	#rm -rf "${TERMUX_PATH}/.ZSHPOWERLINEFONTS" 2>/dev/null
	git clone https://gitee.com/ak2/termux-fonts.git --depth=1 "${TMOE_ZSH_FONTS_PATH}"
	cd ${TMOE_ZSH_FONTS_PATH}
	tar -Jxvf fonts.tar.xz
	#rm -rf "${TERMUX_PATH}/fonts" 2>/dev/null
	#mv "${TERMUX_PATH}/.ZSHPOWERLINEFONTS/fonts" "${TERMUX_PATH}"
	#rm -rf "${TERMUX_PATH}/.ZSHPOWERLINEFONTS"
}
###################
android_git_clone_fonts() {
	#TMOE_ZSH_FONTS_PATH="${TMOE_ZSH_PATH}/fonts"
	mkdir -p "${TERMUX_PATH}"
	if [ ! -d "${TMOE_ZSH_FONTS_PATH}/fonts" ]; then
		git_clone_termux_font_files
	fi
	chsh -s zsh
	git_clone_tmoe_zsh
}
###########################################
fix_zsh_folder_permissions() {
	chmod 755 -R ${ZSH_PATH}
	if [ "${LINUX_DISTRO}" != "Android" ] && [ ${HOME} != "/root" ]; then
		echo "正在将${ZSH_PATH}的权限修改为${CURRENT_USER_NAME}用户和${CURRENT_USER_GROUP}用户组"
		sudo -E chown -R ${CURRENT_USER_NAME}:${CURRENT_USER_GROUP} ${ZSH_PATH}
	fi
}
################
git_clone_tmoe_zsh() {
	#tmoe-zsh旧版迁移新版，必须要先删掉旧仓库文件夹。
	#if ! grep -q 'mo2/zsh.git' "${TMOE_ZSH_GIT_PATH}/.git/config" 2>/dev/null; then
	#	rm -rf "${TMOE_ZSH_GIT_PATH}"
	#fi
	if [ ! -e "${TMOE_ZSH_GIT_PATH}/.git" ]; then
		git clone --depth=1 ${TMOE_GIT_REPO} ${TMOE_ZSH_GIT_PATH}
		#ZSH_PATH="${TMOE_ZSH_GIT_PATH}"
		#fix_zsh_folder_permissions
		#rm -f ${HOME}/theme 2>/dev/null
	else
		git_pull_tmoe_zsh
	fi
	#tmoe_zsh_main_menu
}
######################################################
tmoe_zsh_main_menu() {
	cd ${cur}
	#20 50 7
	RETURN_TO_WHERE='tmoe_zsh_main_menu'
	TMOE_OPTION=$(whiptail --title "TMOE-ZSH manager running on Linux.(20200815)" --backtitle "Please select install&configure for initial installation." --menu "输zsh-i启动本工具,type zsh-i to start this tool.\nPlease use the enter and arrow keys to operate.\n请使用方向键和回车键进行操作,初次安装请选择安装与配置" 0 50 0 \
		"1" "🍭 install&configure 安装与配置" \
		"2" "🌸 Itemized configuration 分项配置" \
		"3" "🍀 Plugins 插件管理" \
		"4" "🏫 FAQ 常见问题" \
		"5" "💔 Remove zsh 移除" \
		"6" "🍹 Backup zsh 备份" \
		"7" "🔯 Restore 还原" \
		"8" "🍧 Update 更新" \
		"0" "🌚 Exit 退出" \
		3>&1 1>&2 2>&3)
	#############
	case ${TMOE_OPTION} in
	0 | "") exit 0 ;;
	1) do_you_want_to_backup_zsh_folder ;;
	2) ItemizedConfiguration ;;
	3) tmoe_zsh_plugin_manager ;;
	4) tmoe_zsh_faq ;;
	5) REMOVEZSH ;;
	6) BACKUPZSH ;;
	7) RESTOREZSH ;;
	8) UPDATEPLUGINS ;;
	esac
	###############
	press_enter_to_return
	tmoe_zsh_main_menu
}
##################################################
remove_plugin_command_not_found() {
	cat <<-EOF
		Do you want to remove command-not-found plugin ?
		${RED}apt purge${RESET} ${BLUE}command-not-found${RESET}
	EOF
	do_you_want_to_continue
	sudo apt purge command-not-found || apt purge command-not-found
}
#########
reset_fzf_tab() {
	cat <<-EOF
		Do you want to reset fzf-tab plugin ?
	EOF
	do_you_want_to_continue
	git_clone_fzf_tab
	#sudo apt purge command-not-found || apt purge command-not-found
}
#########
tmoe_zsh_faq() {
	RETURN_TO_WHERE='tmoe_zsh_faq'
	#20 50 7
	TMOE_OPTION=$(whiptail --title "FAQ(よくある質問)" \
		--menu "您有哪些疑问？\nWhat questions do you have?" 0 50 0 \
		"1" "command-not-found插件配置失败" \
		"2" "fzf-tab插件加载异常" \
		"3" "Fix permissions修复文件权限" \
		"4" "Conf does not take effect配置文件未生效" \
		"0" "🌚 Back to the main menu 返回主菜单" \
		3>&1 1>&2 2>&3)
	#############
	case ${TMOE_OPTION} in
	0 | "") tmoe_zsh_main_menu ;;
	1) remove_plugin_command_not_found ;;
	2) reset_fzf_tab ;;
	3)
		ZSH_PATH="${HOME}/.oh-my-zsh ${HOME}/.zshrc ${TMOE_ZSH_GIT_PATH}"
		fix_zsh_folder_permissions
		echo "若无法修复，则请手动执行${GREEN}compaudit | xargs chmod g-w,o-w${RESET}"
		if [ "${LINUX_DISTRO}" != "Android" ] && [ ${HOME} != "/root" ]; then
			echo "您亦可将${HOME}目录的权限修改为${CURRENT_USER_NAME}用户和${CURRENT_USER_GROUP}用户组"
			echo "${RED}sudo chown -R ${CURRENT_USER_NAME}:${CURRENT_USER_GROUP} ${HOME}${RESET}"
		fi
		;;
	4)
		echo "请手动执行${GREEN}. ~/.zshrc${RESET}或者是${GREEN}source ${HOME}/.zshrc${RESET}"
		echo "Please try running ${GREEN}source ~/.zshrc${RESET}"
		#source ${HOME}/.zshrc
		;;
	esac
	###############
	press_enter_to_return
	tmoe_zsh_faq
}
###########
ItemizedConfiguration() {
	RETURN_TO_WHERE='ItemizedConfiguration'
	TMOE_OPTION=$(whiptail --title "Itemized Configuration" --menu "您想要配置哪个项目?zsh主题全平台通用,Termux配色和字体仅适用Android Termux,xfce4终端配色仅适用于linux。You can use zsh theme on all platforms,but termux colors and fonts are only available for Android." 17 50 5 \
		"1" "Termux配色 color schemes" \
		"2" "Termux字体 fonts" \
		"3" "zsh主题 themes" \
		"4" "xfce4终端配色 xfce4-terminal color schemes" \
		"5" "Set zsh as the default(默认) shell" \
		"6" "edit .zshrc手动编辑配置" \
		"0" "🌚 Back to the main menu 返回主菜单" \
		3>&1 1>&2 2>&3)
	###########
	case "${TMOE_OPTION}" in
	0 | "") tmoe_zsh_main_menu ;;
	1)
		if [ "${LINUX_DISTRO}" = "Android" ]; then
			bash ${TMOE_ZSH_TERMUX_PATH}/colors.sh
		else
			echo '非常抱歉，此功能只支持安卓'
			echo "Sorry, this feature only supports Android"
			press_enter_to_return
			ItemizedConfiguration
		fi
		;;
	2)
		if [ "${LINUX_DISTRO}" = "Android" ]; then
			bash ${TMOE_ZSH_TERMUX_PATH}/fonts.sh
		else
			echo '非常抱歉，此功能只支持安卓'
			echo "Sorry, this feature only supports Android"
			press_enter_to_return
			ItemizedConfiguration
		fi
		;;
	3) bash ${TMOE_ZSH_TERMUX_PATH}/themes.sh ;;
	4) XFCE4TERMINALCOLOR ;;
	5) DEFAULTSHELL ;;
	6) nano ${HOME}/.zshrc || vim ${HOME}/.zshrc || vi ${HOME}/.zshrc ;;
	esac
	##############################
	press_enter_to_return
	${RETURN_TO_WHERE}
}
############################
XFCE4TERMINALCOLOR() {
	if [ "${LINUX_DISTRO}" = "Android" ]; then
		echo '非常抱歉，此功能不支持安卓'
		press_enter_to_return
		ItemizedConfiguration
	fi
	if [ ! -d "/usr/share/xfce4/terminal" ]; then
		echo "检测到xfce终端目录不存在，您当前可能没有安装xfce终端"
		do_you_want_to_continue
		#echo 'Press Ctrl+C to cancel.'
		#press_enter_to_continue
		mkdir -p /usr/share/xfce4/terminal
		${PACKAGES_INSTALL_COMMAND} xfce4-terminal || sudo ${PACKAGES_INSTALL_COMMAND} xfce4-terminal
	fi

	cd /usr/share/xfce4/terminal
	echo "正在配置xfce4终端配色..."
	wget -qO "colorschemes.tar.xz" 'https://gitee.com/mo2/xfce-themes/raw/terminal/colorschemes.tar.xz'
	tar -Jxvf "colorschemes.tar.xz"
	DEPENDENCIES=""
	if [ ! -e /usr/bin/mkfontscale ]; then
		DEPENDENCIES="${DEPENDENCIES} xfonts-utils"
	fi

	if [ ! -e /usr/bin/fc-cache ]; then
		DEPENDENCIES="${DEPENDENCIES} fontconfig"
	fi
	if [ ! -z "$DEPENDENCIES" ]; then
		echo "正在安装相关依赖..."
		#apt update
		#apt install -y ${DEPENDENCIES}
		${PACKAGES_UPDATE_COMMAND} || sudo ${PACKAGES_UPDATE_COMMAND}
		${PACKAGES_INSTALL_COMMAND} ${DEPENDENCIES} || sudo ${PACKAGES_INSTALL_COMMAND} ${DEPENDENCIES}
	fi
	if [ ! -f '/usr/share/fonts/Iosevka.ttf' ]; then
		echo '正在刷新字体缓存...'
		mkdir -p /usr/share/fonts/
		cd /tmp
		if [ -e "font.ttf" ]; then
			mv -f font.ttf '/usr/share/fonts/Iosevka.ttf'
		else
			wget -qO 'Iosevka.tar.xz' 'https://gitee.com/mo2/Termux-zsh/raw/p10k/Iosevka.tar.xz'
			tar -xvf 'Iosevka.tar.xz'
			rm -f 'Iosevka.tar.xz'
			mv -f font.ttf '/usr/share/fonts/Iosevka.ttf'
		fi
		cd /usr/share/fonts/
		mkfontscale
		mkfontdir
		fc-cache
	fi
}
########################################################
remove_oh_my_zsh() {
	echo "uninstall_oh_my_zsh 2>/dev/null || rm -rf ${HOME}/.oh-my-zsh"
	do_you_want_to_continue
	uninstall_oh_my_zsh 2>/dev/null || rm -rf ${HOME}/.oh-my-zsh
}
#########
remove_termux_fonts() {
	echo "rm -rf ${TERMUX_PATH}/fonts"
	do_you_want_to_continue
	rm -rfv ${TERMUX_PATH}/fonts
}
#########
remove_tmoe_zsh() {
	echo "${RED}rm -rf ${TMOE_ZSH_PATH} ${PREFIX}/bin/zsh-i ; sed -i '/alias zshtheme=/d' ${HOME}/.zshrc ${HOME}/.profile${RESET}"
	do_you_want_to_continue
	rm -rfv ${TMOE_ZSH_PATH} ${PREFIX}/bin/zsh-i
	sed -i '/alias zshtheme=/d' "${HOME}/.zshrc" "${HOME}/.profile"
	sed -i '/alias zshfont=/d' "${HOME}/.zshrc"
	sed -i '/alias zshcolor=/d' "${HOME}/.zshrc"
	echo "${YELLOW}删除完成，按回车键退出 Press Enter to exit.${RESET} "
	read
	exit 1
}
###########
remove_git_and_zsh() {
	DEPENDENCIES='git zsh whiptail newt xz dialog'
	echo "${RED}${PACKAGES_REMOVE_COMMAND} ${DEPENDENCIES}${RESET}"
	do_you_want_to_continue
	${PACKAGES_REMOVE_COMMAND} ${DEPENDENCIES} 2>/dev/null || sudo ${PACKAGES_REMOVE_COMMAND} ${DEPENDENCIES}
	apt autoremove 2>/dev/null
	exit 1
}
##############
remove_old_zsh_files() {
	cat <<-EOF
		以下文件夹将被删除，是否确认？
		ls -lAh ${HOME}/.zsh-syntax-highlighting
		ls -lAh ${HOME}/termux-ohmyzsh
		ls -lh ${HOME}/theme
	EOF
	do_you_want_to_continue
	rm -rf ${HOME}/.zsh-syntax-highlighting ${HOME}/termux-ohmyzsh ${HOME}/theme
}
###########
remove_zshrc() {
	cat ${HOME}/.zshrc
	ls -lh ${HOME}/.zshrc
	#echo "${YELLOW}按回车键确认删除，Ctrl+C取消。${RESET} "
	#echo "Press Enter to confirm the deletion, press Ctrl + C to cancel."
	#read
	do_you_want_to_continue
	rm -f ${HOME}/.zshrc
	echo "${YELLOW}删除完成，建议您返回主菜单使用一键配置，按回车键返回 Press Enter to return.${RESET} "
}
###########
REMOVEZSH() {
	RETURN_TO_WHERE='REMOVEZSH'
	TMOE_OPTION=$(whiptail --title "REMOVE ZSH" --menu "您想要移除哪个项目？\nWhich item do you want to remove?" 0 50 0 \
		"0" "🌚 Back to the main menu 返回主菜单" \
		"1" "oh-my-zsh" \
		"2" "fonts 字体" \
		"3" "tmoe-zsh 工具" \
		"4" "zsh and git " \
		"5" "Legacy residual files 旧版残留文件" \
		"6" ".zshrc 配置文件" \
		3>&1 1>&2 2>&3)
	##############################
	case "${TMOE_OPTION}" in
	0 | "") tmoe_zsh_main_menu ;;
	1) remove_oh_my_zsh ;;
	2) remove_termux_fonts ;;
	3) remove_tmoe_zsh ;;
	4) remove_git_and_zsh ;;
	5) remove_old_zsh_files ;;
	6) remove_zshrc ;;
	esac
	##########
	press_enter_to_return
	REMOVEZSH
}
#################################
do_you_want_to_backup_zsh_folder() {
	cp "${HOME}/.zshrc" "${HOME}/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)" 2>/dev/null
	case "${LINUX_DISTRO}" in
	Android)
		android_git_clone_fonts
		if [ -f ${TERMUX_KEYBOARD_FILE} ]; then
			cp -f ${TERMUX_KEYBOARD_FILE} "${TERMUX_KEYBOARD_BACKUP_FILE}"
		fi
		modify_termux_color_and_font
		;;
	*)
		git_clone_tmoe_zsh
		chsh -s $(command -v zsh) || sudo chsh -s $(command -v zsh)
		onekey_configure_tmoe_zsh
		;;
	esac
}
################################
where_is_start_dir() {
	if [ -d "/sdcard" ]; then
		START_DIR='/sdcard/Download/backup'
	elif [ -d "${HOME}/sd" ]; then
		START_DIR="${HOME}/sd/Download/backup"
	else
		START_DIR="${HOME}/backup"
	fi
}
############
BACKUPZSH() {
	where_is_start_dir
	BACKUP_FOLDER="${START_DIR}"
	if [ ! -d ${BACKUP_FOLDER} ]; then
		mkdir -p ${BACKUP_FOLDER} || sudo mkdir -p ${BACKUP_FOLDER}
		cd ${BACKUP_FOLDER}
	else
		cd ${BACKUP_FOLDER}
	fi
	ls -lth ./zsh*.tar.* 2>/dev/null && echo '您之前所备份的(部分)文件如上所示'

	echo "${YELLOW}按回车键选择压缩类型 Press enter to select compression type${RESET} "
	do_you_want_to_continue
	if [ -z "${TMPDIR}" ]; then
		TMPDIR=/tmp
	fi
	BACKUP_TIME_FILE="${TMPDIR}/backuptime.tmp"

	if [ -e "${BACKUP_TIME_FILE}" ]; then
		rm -fv ${BACKUP_TIME_FILE} || sudo rm -fv ${BACKUP_TIME_FILE}
	fi

	echo $(date +%Y-%m-%d_%H-%M) >${BACKUP_TIME_FILE}
	TMPtime=zsh_$(cat ${BACKUP_TIME_FILE})

	ZSH_BACKUP_FILES="${HOME}/.zshrc ${HOME}/.zsh_history ${HOME}/.oh-my-zsh"

	if [ -e "${HOME}/.z" ]; then
		ZSH_BACKUP_FILES="${ZSH_BACKUP_FILES} ${HOME}/.z"
	fi

	if [ -e "${TMOE_ZSH_GIT_PATH}" ]; then
		ZSH_BACKUP_FILES="${ZSH_BACKUP_FILES} ${TMOE_ZSH_GIT_PATH}"
	fi

	if [ -e "${TERMUX_PATH}" ]; then
		ZSH_BACKUP_FILES="${ZSH_BACKUP_FILES} ${TERMUX_PATH}"
	fi

	if [ -e "${HOME}/.p10k.zsh" ]; then
		ZSH_BACKUP_FILES="${ZSH_BACKUP_FILES} ${HOME}/.p10k.zsh"
	fi

	if (whiptail --title "Select compression type 选择压缩类型 " --yes-button "tar.xz" --no-button "tar.gz" --yesno "Which do yo like better? \n tar.xz压缩率高，但速度慢。tar.xz has a higher compression ration, but is slower.\n tar.gz速度快,但压缩率低。tar.gz compresses faster, but with a lower compression ratio.\n 压缩过程中，进度条倒着跑是正常现象。" 12 60); then

		echo "您选择了tar.xz,即将为您备份至${BACKUP_FOLDER}/${TMPtime}.tar.xz"
		echo "${YELLOW}按回车键开始备份,按Ctrl+C取消。Press Enter to start the backup.${RESET} "
		read
		#tar -PJpcf - ${HOME}/.z ${HOME}/.zshrc ${TERMUX_PATH} ${HOME}/.zsh_history ${HOME}/.oh-my-zsh ${TMOE_ZSH_GIT_PATH} | (pv -n >${TMPtime}.tar.xz) 2>&1 | whiptail --gauge "Compressing into tar.xz" 10 70
		cd ${HOME}
		if [ $(command -v pv) ]; then
			tar -PJpcf - ${ZSH_BACKUP_FILES} | (pv -p --timer --rate --bytes >${TMPtime}.tar.xz)
		else
			tar -PpJcvf ${TMPtime}.tar.xz ${ZSH_BACKUP_FILES}
		fi
		mv -f ${TMPtime}.tar.xz ${BACKUP_FOLDER} || sudo mv -f ${TMPtime}.tar.xz ${BACKUP_FOLDER}
		#xz -z -T0 -e -9 -f -v ${TMPtime}.tar
		echo "Don't worry too much, it is normal for some directories to backup without permission."
		echo "部分目录无权限备份是正常现象。"
		rm -f ${BACKUP_TIME_FILE}
		pwd
		ls -lth ${BACKUP_FOLDER}/zsh*tar.xz | grep ^- | head -n 1
		echo "${YELLOW}备份完成,按回车键返回。${RESET} "
		echo "Press enter to return."
		read
		tmoe_zsh_main_menu

	else
		echo "您选择了tar.gz,即将为您备份至${BACKUP_FOLDER}/${TMPtime}.tar.gz"
		echo "${YELLOW}按回车键开始备份,按Ctrl+C取消。Press Enter to start the backup.${RESET} "
		read

		#tar -Ppczf - ${HOME}/.z ${HOME}/.zshrc ${TERMUX_PATH} ${HOME}/.zsh_history ${HOME}/.oh-my-zsh ${TMOE_ZSH_GIT_PATH} | (pv -n >${TMPtime}.tar.gz) 2>&1 | whiptail --gauge "Compressing into tar.gz \n正在压缩成tar.gz" 10 70
		#tar -Ppczf - ${HOME}/.z ${HOME}/.zshrc ${TERMUX_PATH} ${HOME}/.zsh_history ${HOME}/.oh-my-zsh ${TMOE_ZSH_GIT_PATH} | (pv -p --timer --rate --bytes >${TMPtime}.tar.gz)
		cd ${HOME}
		if [ $(command -v pv) ]; then
			tar -Ppczf - ${ZSH_BACKUP_FILES} | (pv -p --timer --rate --bytes >${TMPtime}.tar.gz)
		else
			tar -Ppzcvf ${TMPtime}.tar.gz ${ZSH_BACKUP_FILES}
		fi
		mv -f ${TMPtime}.tar.gz ${BACKUP_FOLDER} || sudo mv -f ${TMPtime}.tar.gz ${BACKUP_FOLDER}
		echo "Don't worry too much, it is normal for some directories to backup without permission."
		echo "部分目录无权限备份是正常现象。"
		rm -f ${BACKUP_TIME_FILE}
		#  whiptail --gauge "正在备份,可能需要几分钟的时间请稍后.........." 6 60 0
		pwd
		ls -lth ${BACKUP_FOLDER}/zsh*tar.gz | grep ^- | head -n 1
		echo 'gzip压缩至60%完成是正常现象。'
		echo "${YELLOW}备份完成,按回车键返回。${RESET} "
		echo "Press enter to return."
		read
		tmoe_zsh_main_menu
	fi
}
##############
git_pull_tmoe_zsh() {
	cd ${TMOE_ZSH_GIT_PATH}
	git fetch --depth=2
	git reset --hard origin/master
	git pull origin master --allow-unrelated-histories
}
###########
tmoe_zsh_plugin_manager() {
	if [ ! $(command -v batcat) ] && [ ! -e "${TMOE_ZSH_PATH}/do_not_install_bat" ]; then
		${PACKAGES_UPDATE_COMMAND} || sudo ${PACKAGES_UPDATE_COMMAND}
		echo "${GREEN}${PACKAGES_INSTALL_COMMAND}${RESET} ${BLUE}bat${RESET}"
		${PACKAGES_INSTALL_COMMAND} bat || sudo ${PACKAGES_INSTALL_COMMAND} bat
		echo "If you want to remove it,then type ${RED}${PACKAGES_REMOVE_COMMAND}${RESET} ${BLUE}bat${RESET}"
		touch "${TMOE_ZSH_PATH}/do_not_install_bat"
	fi
	if [ ! -e "${PLUGIN_SCRIPT}" ]; then
		git_pull_tmoe_zsh
	fi
	bash ${PLUGIN_SCRIPT}
}
############
RESTOREZSH() {
	if [ ! -e "${RESTORE_SCRIPT}" ]; then
		git_pull_tmoe_zsh
	fi
	bash ${RESTORE_SCRIPT}
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
download_tmoe_zsh() {
	ZSH_I_URL="${TMOE_GIT_REPO}/raw/master/zsh.sh"
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
upgrade_tmoe_zsh_manager() {
	download_tmoe_zsh
	sed -i '/alias zsh-i=/d' "${HOME}/.zshrc"
	if [ -e "${HOME}/.bashrc" ]; then
		sed -i '/alias zsh-i=/d' "${HOME}/.bashrc"
	fi
	echo "Update ${YELLOW}completed${RESET}, press ${GREEN}enter${RESET} to ${BLUE}return.${RESET}"
	echo "${YELLOW}更新完成，按回车键返回。${RESET}"
	read
	source ${PREFIX}/bin/zsh-i
}
##############
update_command_not_found() {
	if [ -e "/usr/lib/command-not-found" ]; then
		if [ "${LINUX_DISTRO}" = "debian" ]; then
			grep -q 'command-not-found' "${HOME}/.zshrc" 2>/dev/null || sed -i "$ a\source ${HOME}/.oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh" "${HOME}/.zshrc"
			if ! grep -qi 'Ubuntu' '/etc/os-release'; then
				apt-file update 2>/dev/null || sudo apt-file update
				update-command-not-found 2>/dev/null || sudo update-command-not-found 2>/dev/null
			fi
			#apt update  2>/dev/null
			apt upgrade -y zsh git 2>/dev/null || sudo apt upgrade -y zsh git 2>/dev/null
		fi
	fi
}
##############
git_pull_powerlevel_10k() {
	if [ -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
		cd "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
		git reset --hard origin/master
		git pull --depth=1 origin master --allow-unrelated-histories
	fi
}
################
git_pull_oh_my_zsh() {
	cd ${HOME}/.oh-my-zsh
	#git fetch --all
	#git reset --hard origin/master
	git pull --depth=1 origin master --allow-unrelated-histories || echo '若oh-my-zsh更新失败，则请手动输upgrade_oh_my_zsh' && zsh "${HOME}/.oh-my-zsh/tools/upgrade.sh"
	cd "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
	#git fetch --all
	git reset --hard origin/master
	git pull --depth=1 origin master --allow-unrelated-histories
	cd "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
	#git fetch --all
	git reset --hard origin/master
	git pull --depth=1 origin master --allow-unrelated-histories
}
###########
UPDATEPLUGINS() {
	update_command_not_found
	neko_01
	git_pull_powerlevel_10k
	#upgrade zsh plugins and tool
	#git_pull_tmoe_zsh
	git_clone_tmoe_zsh
	git_pull_oh_my_zsh
	upgrade_tmoe_zsh_manager
	#tmoe_zsh_main_menu
}
##############
android_default_shell() {
	if (whiptail --title "android_default_shell" --yes-button 'Yes' --no-button 'no' --yesno 'Android在配置本工具时，已经将zsh设置为默认shell了，您也可以在终端下输chsh -s bash或chsh -s zsh来切换默认shell 。您是否需要将默认shell设置为zsh?' 12 50); then
		chsh -s zsh
	else
		tmoe_zsh_main_menu
	fi
}
##########
gnu_linux_default_shell() {
	if (whiptail --title "gnu_linux_default_shell" --yes-button 'Yes' --no-button 'no' --yesno 'Linux在设置时需要输密码,若需手动配置，请输chsh -s $(command -v zsh)或chsh -s /bin/zsh,您是否需要将默认shell设置为zsh?' 10 50); then
		chsh -s $(command -v zsh) || sudo chsh -s $(command -v zsh)
	else
		tmoe_zsh_main_menu
	fi
}
#############################################################
DEFAULTSHELL() {
	if [ "${LINUX_DISTRO}" = "Android" ]; then
		android_default_shell
	else
		gnu_linux_default_shell
	fi
	echo "${YELLOW}已将默认shell切换为zsh,按回车键返回。Press enter to return.${RESET}"
	read
	tmoe_zsh_main_menu
}
#####################################################
modify_termux_color_and_font() {
	if [ ! -e "${TERMUX_KEYBOARD_FILE}" ]; then
		cp -f ${TMOE_ZSH_TERMUX_PATH}/termux.properties ${TERMUX_KEYBOARD_FILE}
	fi
	if [ ! -e "${TMOE_ZSH_TERMUX_PATH}/colors.properties" ]; then
		cp -f ${TMOE_ZSH_TERMUX_PATH}/colors.properties ${TERMUX_PATH}/colors.properties
	fi
	#if [ ! -e "${TMOE_ZSH_TERMUX_PATH}/font.ttf" ]; then
	#	cp -f ${TMOE_ZSH_TERMUX_PATH}/colors.properties ${TERMUX_PATH}/colors.properties
	#fi

	#TERMUX_KEYBOARD_FILE="${TERMUX_PATH}/termux.properties"

	#${TERMUX_PATH}
	#if [ -f ${TERMUX_KEYBOARD_BACKUP_FILE} ]; then
	#	mv -f "${TERMUX_KEYBOARD_BACKUP_FILE}" ${TERMUX_KEYBOARD_FILE}
	#fi
	onekey_configure_tmoe_zsh
}
##################################################################################
neko_01() {
	printf "$BLUE"
	cat <<-'EndOFneko'
		               .::::..                
		    ::::rrr7QQJi::i:iirijQBBBQB.      
		    BBQBBBQBP. ......:::..1BBBB       
		    .BuPBBBX  .........r.  vBQL  :Y.  
		     rd:iQQ  ..........7L   MB    rr  
		      7biLX .::.:....:.:q.  ri    .   
		       JX1: .r:.r....i.r::...:.  gi5  
		       ..vr .7: 7:. :ii:  v.:iv :BQg  
		       : r:  7r:i7i::ri:DBr..2S       
		    i.:r:. .i:XBBK...  :BP ::jr   .7. 
		    r  i....ir r7.         r.J:   u.  
		   :..X: .. .v:           .:.Ji       
		  i. ..i .. .u:.     .   77: si   1Q  
		 ::.. .r .. :P7.r7r..:iLQQJ: rv   ..  
		7  iK::r  . ii7r LJLrL1r7DPi iJ     r 
		  .  ::.:   .  ri 5DZDBg7JR7.:r:   i. 
		 .Pi r..r7:     i.:XBRJBY:uU.ii:.  .  
		 QB rJ.:rvDE: .. ri uv . iir.7j r7.   
		iBg ::.7251QZ. . :.      irr:Iu: r.   
		 QB  .:5.71Si..........  .sr7ivi:U    
		 7BJ .7: i2. ........:..  sJ7Lvr7s    
		  jBBdD. :. ........:r... YB  Bi      
		     :7j1.                 :  :       

	EndOFneko
	printf "$RESET"
}
############
git_clone_oh_my_zsh() {
	#git clone oh-my-zsh
	if [ ! -d "${HOME}/.oh-my-zsh" ]; then
		git clone https://github.com/ohmyzsh/ohmyzsh.git "${HOME}/.oh-my-zsh" --depth 1 || git clone --depth=1 git://github.com/ohmyzsh/ohmyzsh "${HOME}/.oh-my-zsh"
		ZSH_PATH="${HOME}/.oh-my-zsh"
		fix_zsh_folder_permissions
		#else
		#   cd "${HOME}/.oh-my-zsh" && git pull --depth=1
	fi
	#新版不再覆盖zsh配置
	printf '%s         %s__      %s           %s        %s       %s     %s__   %s\n' ${RB_RED} ${RB_ORANGE} ${RB_YELLOW} ${RB_GREEN} ${RB_BLUE} ${RB_INDIGO} ${RB_VIOLET} ${RB_RESET}
	printf '%s  ____  %s/ /_    %s ____ ___  %s__  __  %s ____  %s_____%s/ /_  %s\n' ${RB_RED} ${RB_ORANGE} ${RB_YELLOW} ${RB_GREEN} ${RB_BLUE} ${RB_INDIGO} ${RB_VIOLET} ${RB_RESET}
	printf '%s / __ \%s/ __ \  %s / __ `__ \%s/ / / / %s /_  / %s/ ___/%s __ \ %s\n' ${RB_RED} ${RB_ORANGE} ${RB_YELLOW} ${RB_GREEN} ${RB_BLUE} ${RB_INDIGO} ${RB_VIOLET} ${RB_RESET}
	printf '%s/ /_/ /%s / / / %s / / / / / /%s /_/ / %s   / /_%s(__  )%s / / / %s\n' ${RB_RED} ${RB_ORANGE} ${RB_YELLOW} ${RB_GREEN} ${RB_BLUE} ${RB_INDIGO} ${RB_VIOLET} ${RB_RESET}
	printf '%s\____/%s_/ /_/ %s /_/ /_/ /_/%s\__, / %s   /___/%s____/%s_/ /_/  %s\n' ${RB_RED} ${RB_ORANGE} ${RB_YELLOW} ${RB_GREEN} ${RB_BLUE} ${RB_INDIGO} ${RB_VIOLET} ${RB_RESET}
	printf '%s    %s        %s           %s /____/ %s       %s     %s          %s\n' ${RB_RED} ${RB_ORANGE} ${RB_YELLOW} ${RB_GREEN} ${RB_BLUE} ${RB_INDIGO} ${RB_VIOLET} ${RB_RESET}
	neko_01

	if [ ! -f "${HOME}/.zshrc" ]; then
		cp "${HOME}/.oh-my-zsh/templates/zshrc.zsh-template" "${HOME}/.zshrc" || wget -O "${HOME}/.zshrc" 'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template'
		chmod 755 "${HOME}/.zshrc"
	fi
}
##########
configure_command_not_found() {
	if [ -e "/usr/lib/command-not-found" ]; then
		if [ "${LINUX_DISTRO}" = "debian" ]; then
			grep -q 'command-not-found' "${HOME}/.zshrc" 2>/dev/null || sed -i "$ a\source ${HOME}/.oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh" "${HOME}/.zshrc"
			if ! grep -qi 'Ubuntu' '/etc/os-release'; then
				apt-file update 2>/dev/null
				update-command-not-found 2>/dev/null
			fi
		fi
	fi
}
############
add_zsh_alias() {
	#外面双引号，里面单引号。
	#添加alias
	#TMOE_ZSH_TERMUX_PATH
	#grep -q 'alias zshcolor=' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zshcolor='bash ${TERMUX_PATH}/colors.sh'" "${HOME}/.zshrc"
	sed -i '/alias zshcolor=/d' "${HOME}/.zshrc"
	sed -i "$ a\alias zshcolor='bash ${TMOE_ZSH_TERMUX_PATH}/colors.sh'" "${HOME}/.zshrc"

	#echo -e "\nalias zshcolor='${TERMUX_PATH}/colors.sh'" >>"${HOME}/.zshrc"
	#grep -q 'alias zshfont=' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zshfont='bash ${TERMUX_PATH}/fonts.sh'" "${HOME}/.zshrc"
	sed -i '/alias zshfont=/d' "${HOME}/.zshrc"
	sed -i "$ a\alias zshfont='bash ${TMOE_ZSH_TERMUX_PATH}/fonts.sh'" "${HOME}/.zshrc"

	#grep -q 'alias zshtheme=' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zshtheme='bash ${TERMUX_PATH}/themes.sh'" "${HOME}/.zshrc"
	sed -i '/alias zshtheme=/d' "${HOME}/.zshrc"
	sed -i "$ a\alias zshtheme='bash ${TMOE_ZSH_TERMUX_PATH}/themes.sh'" "${HOME}/.zshrc"
	if [ -e "${HOME}/.profile" ]; then
		sed -i '/alias zshtheme=/d' "${HOME}/.profile"
		sed -i "$ a\alias zshtheme='bash ${TMOE_ZSH_TERMUX_PATH}/themes.sh'" "${HOME}/.profile"
	fi
	#grep -q 'alias zsh-i=' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zsh-i='bash ${TMOE_ZSH_GIT_PATH}/update.sh'" "${HOME}/.zshrc"
	#grep -q 'alias zsh-i=' "${HOME}/.bashrc" >/dev/null 2>&1 || sed -i "$ a\alias zsh-i='bash ${TMOE_ZSH_GIT_PATH}/update.sh'" "${HOME}/.bashrc"
	sed -i '/alias zsh-i=/d' "${HOME}/.zshrc"
	if [ -e "${HOME}/.bashrc" ]; then
		sed -i '/alias zsh-i=/d' "${HOME}/.bashrc"
	fi
	if [ ! -e "${PREFIX}/bin/zsh-i" ]; then
		download_tmoe_zsh
	fi
}
###########
git_clone_fzf_tab() {
	rm -rfv ${HOME}/.oh-my-zsh/custom/plugins/fzf-tab
	sed -i '/fzf-tab.zsh/d' "${HOME}/.zshrc"
	git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git "${HOME}/.oh-my-zsh/custom/plugins/fzf-tab" || git clone --depth=1 git://github.com/Aloxaf/fzf-tab.git "${HOME}/.oh-my-zsh/custom/plugins/fzf-tab"
	chmod 755 -R "${HOME}/.oh-my-zsh/custom/plugins/fzf-tab"
	grep -q 'custom/plugins/fzf-tab/fzf-tab.zsh' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\source ${HOME}/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.zsh" "${HOME}/.zshrc"
}
############
onekey_configure_tmoe_zsh() {
	git_clone_oh_my_zsh
	if [ "${LINUX_DISTRO}" != "Android" ]; then
		configure_command_not_found
	fi
	#重置主题
	sed -i '/^ZSH_THEME/d' "${HOME}/.zshrc"
	sed -i '1 i\ZSH_THEME="agnoster"' "${HOME}/.zshrc"
	##############################################
	add_zsh_alias
	######################################
	#create zsh plugins目录
	if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins" ]; then
		mkdir -p "${HOME}/.oh-my-zsh/custom/plugins"
	fi
	#git clone 语法插件
	if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
		echo '正在克隆zsh语法高亮插件...'
		sed -i '/zsh-syntax-highlighting.zsh/d' "${HOME}/.zshrc"
		git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting || git clone --depth=1 git://github.com/zsh-users/zsh-syntax-highlighting ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

		chmod 755 -R "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
		# else
		# cd "${HOME}/.zsh-syntax-highlighting" &&git pull --depth=1
	fi
	grep "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\source ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "${HOME}/.zshrc"

	###############################################
	if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
		echo '正在克隆zsh自动补全插件...'
		sed -i '/zsh-autosuggestions.zsh/d' "${HOME}/.zshrc"
		git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions || git clone --depth=1 git://github.com/zsh-users/zsh-autosuggestions ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestionszsh-autosuggestions
		chmod 755 -R "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
		# else
		# cd "${HOME}/.oh-my-zsh/custom/plugins" &&git pull --depth=1
	fi
	grep -q '/zsh-autosuggestions/zsh-autosuggestions.zsh' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\source ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" "${HOME}/.zshrc"
	sed -i 's/plugins=(git)/plugins=(git z extract)/g' "${HOME}/.zshrc"
	####################################################
	ENABLE_FZF_TAB_EXTRA_OPT='true'
	if grep -Eq 'buster|stretch|jessie|Bionic Beaver|Xenial|Cosmic|Disco' "/etc/os-release" 2>/dev/null; then
		ENABLE_FZF_TAB_EXTRA_OPT='false'
	fi
	if [ "${LINUX_DISTRO}" != "debian" ] && [ "${LINUX_DISTRO}" != "Android" ]; then
		ENABLE_FZF_TAB_EXTRA_OPT='false'
	fi

	if [ "${LINUX_DISTRO}" = "debian" ] || [ "${LINUX_DISTRO}" = "alpine" ] || [ "${LINUX_DISTRO}" = "redhat" ] || [ "${LINUX_DISTRO}" = "arch" ] || [ "${LINUX_DISTRO}" = "Android" ]; then
		if [ $(command -v fzf) ]; then
			if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/fzf-tab/.git" ]; then
				git_clone_fzf_tab
				if [ "${ENABLE_FZF_TAB_EXTRA_OPT}" = 'true' ]; then
					if ! grep -q 'extract=' "${HOME}/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.zsh"; then
						cat >>"${HOME}/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.zsh" <<-'EndOFfzfTab'
							    #额外步骤
								    local extract="
								# 提取当前选择的内容
								in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
								# 获取当前补全状态的上下文
								local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
								"
								    zstyle ':fzf-tab:complete:*:*' extra-opts --preview=$extract'ls -A1 --color=always ${~ctxt[hpre]}$in 2>/dev/null'
						EndOFfzfTab
					fi
				fi
			fi
		fi
	fi

	###############################################
	#切换zsh为默认shell，并且设定临时alias
	#alias zshcolor="bash ${TERMUX_PATH}/colors.sh"
	#alias zshfont="bash ${TERMUX_PATH}/fonts.sh"
	#alias zshtheme="bash ${TERMUX_PATH}/themes.sh"
	#alias zsh-i="bash ${TMOE_ZSH_GIT_PATH}/zsh.sh"
	#echo -e "oh-my-zsh install complete!\nChoose your color scheme now~"
	####################################################
	#cd ${HOME}/.oh-my-zsh/themes || mkdir -p ${HOME}/.oh-my-zsh/themes && cd ${HOME}/.oh-my-zsh/themes
	#配置完成后的提示内容。
	echo "您已安装${BOLD}zsh${RESET},之后可以单独输${YELLOW}zshtheme${RESET}来更改${BLUE}主题${RESET},${YELLOW}zshcolor${RESET} 来更改${BLUE}配色${RESET}，输 ${YELLOW}zshfont${RESET}来更改${BLUE}字体${RESET},输 ${YELLOW}zsh-i${RESET}进入zsh插件${BLUE}管理工具${RESET}。"
	echo "You have installed ${BOLD}zsh${RESET}, you can type ${GREEN}zshcolor${RESET} to change the ${BLUE}color${RESET}, type ${GREEN}zshfont${RESET} to change the ${BLUE}font${RESET}, type ${GREEN}zshtheme${RESET} to change the ${BLUE}theme${RESET},type ${GREEN}zsh-i${RESET} to start ${BLUE}tmoe-zsh tool${RESET}."
	echo "当前已为您加载了z插件，若您曾访问过/sdcard/Download，则您可以输${YELLOW}z Down${RESET}或${YELLOW}z load${RESET}来快速跳转，访问列表可以输 ${YELLOW}z ${RESET}获取。"
	echo "还为您加载了解压插件extract，例如某文件名为233.tar.xz，则您无需输${YELLOW}tar -Jxf 233.tar.xz${RESET}，只需输${YELLOW}x 233.tar.xz${RESET}。同理，若另一文件为233.7z，则您只需输入${YELLOW}x 233.7z${RESET}即可解压。"
	echo '注意：您在解压前必须先安装相关依赖，例如：zip需要unzip，7z需要p7zip，安装方法类似于apt install -y unzip'
	echo 'Plugins such as syntax highlighting, extract, and z have been configured for you. Enjoy the fun of zsh!'
	##############################################################
	cd ${cur}
	if [ "${LINUX_DISTRO}" = "Android" ]; then
		echo "Choose your color scheme now~"
		#echo '请选择您的配色'
		bash ${TMOE_ZSH_TERMUX_PATH}/colors.sh
		echo ''
		echo "Choose your font now~"
		#echo '请选择您的字体'
		bash ${TMOE_ZSH_TERMUX_PATH}/fonts.sh
	fi
	echo ''
	echo "Choose your theme now~"
	#echo '请选择您的主题'
	bash ${TMOE_ZSH_TERMUX_PATH}/themes.sh
}
###########################################
main "$@"
###########################################
