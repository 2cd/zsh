#!/data/data/com.termux/files/usr/bin/bash

#################################################
CHECKSYSTEM() {
	RED=$(printf '\033[31m')
	GREEN=$(printf '\033[32m')
	YELLOW=$(printf '\033[33m')
	BLUE=$(printf '\033[34m')
	BOLD=$(printf '\033[1m')
	RESET=$(printf '\033[m')

	if [ "$(uname -o)" = "Android" ]; then
		LINUX_DISTRO='Android'
		ANDROIDTERMUX
	else
		GNU_LINUX_DEPENDENCIES
	fi
}
###############################
GNU_LINUX_DEPENDENCIES() {

	if [ ${HOME} != '/root' ]; then
		CURRENT_USER_NAME=$(cat /etc/passwd | grep "${HOME}" | awk -F ':' '{print $1}')
		CURRENT_USER_GROUP=$(cat /etc/passwd | grep "${HOME}" | awk -F ':' '{print $5}' | cut -d ',' -f 1)
	fi
	####################
	if grep -Eq 'debian|ubuntu' "/etc/os-release"; then
		LINUX_DISTRO='debian'
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
		wget --no-check-certificate -qO "router-zsh.bash" https://raw.githubusercontent.com/2moe/tmoe-zsh/master/zsh.sh
		chmod +x 'router-zsh.bash'
		#bash -c "$(cat 'router-zsh.bash' |sed 's@/usr/bin@/opt/bin@g' |sed 's@-e /bin@-e /opt/bin@g' |sed 's@whiptail@dialog@g')"
		sed -i 's@/usr/bin@/opt/bin@g' 'router-zsh.bash'
		sed -i 's@-e /bin@-e /opt/bin@g' 'router-zsh.bash'
		sed -i 's@whiptail@dialog@g' 'router-zsh.bash'
		sed -i 's@wget --no-check-certificate -qO "router-zsh.bash"@#&@' 'router-zsh.bash'
		sed -i 's@bash router-zsh.bash@#&@' 'router-zsh.bash'
		bash router-zsh.bash

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
	#####################
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
	if [ ! -z "${DEPENDENCIES}" ]; then
		echo "正在${YELLOW}安装${RESET}相关${GREEN}软件包${RESET}及其${BLUE}依赖...${RESET}"
		echo "${GREEN}${PACKAGES_INSTALL_COMMAND}${BLUE}${DEPENDENCIES}${RESET}"
		echo "如需${BOLD}${RED}卸载${RESET}${RESET}，请${YELLOW}手动${RESET}输${RED}${PACKAGES_REMOVE_COMMAND}${RESET}${BLUE}${DEPENDENCIES}${RESET}"
		if [ "$(id -u)" != "0" ]; then
			if [ $(command -v curl) ]; then
				sudo -E bash -c "$(curl -LfsS https://raw.githubusercontent.com/2moe/tmoe-zsh/master/zsh.sh)" ||
					su -c "$(curl -LfsS https://raw.githubusercontent.com/2moe/tmoe-zsh/master/zsh.sh)"
			else
				sudo -E bash -c "$(wget -qO- https://raw.githubusercontent.com/2moe/tmoe-zsh/master/zsh.sh)" ||
					su -c "$(wget -qO- https://raw.githubusercontent.com/2moe/tmoe-zsh/master/zsh.sh)"
			fi
			exit 0
		fi

		if [ "${LINUX_DISTRO}" = "debian" ]; then
			apt update
			apt install -y ${DEPENDENCIES} || apt install -y command-not-found zsh git pv wget xz-utils tar whiptail command-not-found

		elif [ "${LINUX_DISTRO}" = "alpine" ]; then
			apk add -q ${DEPENDENCIES}
			#apk add -q xz newt tar zsh git wget bash zsh-vcs pv

		elif [ "${LINUX_DISTRO}" = "arch" ]; then
			pacman -Syu --noconfirm ${DEPENDENCIES}

		elif [ "${LINUX_DISTRO}" = "redhat" ]; then
			dnf install -y --skip-broken ${DEPENDENCIES} || yum install -y --skip-broken ${DEPENDENCIES}
			#dnf install -y zsh git pv wget xz tar newt || yum install -y zsh git pv wget xz tar newt

		elif [ "${LINUX_DISTRO}" = "openwrt" ]; then
			#opkg update
			opkg install ${DEPENDENCIES} || opkg install whiptail

		elif [ "${LINUX_DISTRO}" = "void" ]; then
			xbps-install -S
			xbps-install -y ${DEPENDENCIES}

		elif [ "${LINUX_DISTRO}" = "gentoo" ]; then
			emerge -av ${DEPENDENCIES}

		elif [ "${LINUX_DISTRO}" = "suse" ]; then
			zypper in -y ${DEPENDENCIES}

		elif [ "${LINUX_DISTRO}" = "slackware" ]; then
			slackpkg install ${DEPENDENCIES}

		else
			apt update
			apt install -y command-not-found zsh git pv wget xz-utils tar whiptail command-not-found || port install ${DEPENDENCIES} || guix package -i ${DEPENDENCIES} || pkg install ${DEPENDENCIES} || pkg_add ${DEPENDENCIES} || pkgutil -i ${DEPENDENCIES}

		fi
	fi

	TERMUXGITCLONEZSH
}
####################################################
ANDROIDTERMUX() {
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

	ANDROIDGITCLONEFONTS
}
###############################################
ANDROIDGITCLONEFONTS() {
	#git clone字体文件
	if [ ! -d "${HOME}/.termux/fonts/Ubuntu" ]; then
		rm -rf "${HOME}/.termux/.ZSHPOWERLINEFONTS" 2>/dev/null
		mkdir -p "${HOME}/.termux/"
		git clone https://gitee.com/mo2/zsh-powerline-font.git --depth=1 "${HOME}/.termux/.ZSHPOWERLINEFONTS"
		rm -rf "${HOME}/.termux/fonts" 2>/dev/null
		mv "${HOME}/.termux/.ZSHPOWERLINEFONTS/fonts" "${HOME}/.termux"
		rm -rf "${HOME}/.termux/.ZSHPOWERLINEFONTS"
	fi
	chsh -s zsh
	TERMUXGITCLONEZSH
}
###########################################
fix_zsh_folder_permissions() {
	chmod 755 -R ${ZSH_FOLDER}
	if [ "${LINUX_DISTRO}" != "Android" ] && [ ${HOME} != "/root" ]; then
		echo "正在将$ZSH_FOLDER}的权限修改为${CURRENT_USER_NAME}用户和${CURRENT_USER_GROUP}用户组"
		sudo -E chown -R ${CURRENT_USER_NAME}:${CURRENT_USER_GROUP} ${ZSH_FOLDER}
	fi
}
################
#termux git clone zsh
TERMUXGITCLONEZSH() {
	cur=$(pwd)
	#tmoe-zsh旧版迁移新版，必须要先删掉旧仓库文件夹。
	if ! grep -q 'mo2/zsh.git' "${HOME}/.termux-zsh/.git/config" 2>/dev/null; then
		rm -rf "${HOME}/.termux-zsh"
	fi
	if [ ! -d "${HOME}/.termux-zsh" ]; then
		git clone https://github.com/2moe/tmoe-zsh.git "${HOME}/.termux-zsh" --depth 1
		ZSH_FOLDER="${HOME}/.termux-zsh"
		fix_zsh_folder_permissions
		rm -f ${HOME}/theme 2>/dev/null
		#else
		#cd "${HOME}/.termux-zsh"
		#git reset --hard origin/master
		#git pull --depth=1 origin master
	fi

	ZSHMANAGER
}
######################################################
ZSHMANAGER() {
	cd ${cur}
	OPTION=$(whiptail --title "TMOE-ZSH manager running on Linux.(20200322)" --backtitle "输zsh-i启动本工具，Please select onekey configuration for initial installation." --menu "输zsh-i启动本工具,Please use enter and arrow keys to operate.请使用方向键和回车键进行操作,当前主菜单下共有7个选项,初次安装请选择一键配置" 20 50 7 \
		"1" "Onekey configuration 一键配置" \
		"2" "Itemized configuration 分项配置" \
		"3" "Remove zsh 移除" \
		"4" "Backup zsh 备份" \
		"5" "Restore 还原" \
		"6" "update 更新" \
		"7" "Exit 退出" \
		3>&1 1>&2 2>&3)
	if [ "${OPTION}" == '1' ]; then
		CHOOSEBACKUP
	fi
	if [ "${OPTION}" == '2' ]; then
		ItemizedConfiguration
	fi
	if [ "${OPTION}" == '3' ]; then
		REMOVEZSH
	fi
	if [ "${OPTION}" == '4' ]; then
		BACKUPZSH
	fi
	if [ "${OPTION}" == '5' ]; then
		RESTOREZSH
	fi
	if [ "${OPTION}" == '6' ]; then
		UPDATEPLUGINS
	fi
	if [ "${OPTION}" == '7' ]; then
		exit
	fi
}
##################################################
ItemizedConfiguration() {
	OPTION=$(whiptail --title "Itemized Configuration" --menu "您想要配置哪个项目?zsh主题全平台通用,Termux配色和字体仅适用Android Termux,xfce4终端配色仅适用于linux。You can use zsh theme on all platforms,but termux colors and fonts are only available for Android." 17 50 5 \
		"1" "Termux配色 color schemes" \
		"2" "Termux字体 fonts" \
		"3" "zsh主题 themes" \
		"4" "xfce4终端配色 xfce4-terminal color schemes" \
		"5" "Set zsh as the default(默认) shell" \
		"0" "Back to the main menu 返回主菜单" \
		3>&1 1>&2 2>&3)
	if [ "${OPTION}" == '0' ]; then
		ZSHMANAGER
	fi

	if [ "${OPTION}" == '1' ]; then
		if [ "${LINUX_DISTRO}" = "Android" ]; then
			bash ${HOME}/.termux/colors.sh
		else
			echo '非常抱歉，此功能只支持安卓'
			echo "Sorry, this feature only supports Android"
			echo 'Press Enter to return.'
			echo "${YELLOW}按回车键返回。${RESET}"
			read
			ItemizedConfiguration
		fi
	fi

	if [ "${OPTION}" == '2' ]; then
		if [ "${LINUX_DISTRO}" = "Android" ]; then
			bash ${HOME}/.termux/fonts.sh
		else
			echo '非常抱歉，此功能只支持安卓'
			echo "Sorry, this feature only supports Android"
			echo 'Press Enter to return.'
			echo "${YELLOW}按回车键返回。${RESET}"
			read
			ItemizedConfiguration
		fi
	fi

	if [ "${OPTION}" == '3' ]; then
		bash ${HOME}/.termux/themes.sh
	fi
	if [ "${OPTION}" == '4' ]; then
		XFCE4TERMINALCOLOR
	fi

	if [ "${OPTION}" == '5' ]; then
		DEFAULTSHELL
	fi
	exit
}
############################
XFCE4TERMINALCOLOR() {
	if [ "${LINUX_DISTRO}" = "Android" ]; then
		echo '非常抱歉，此功能不支持安卓'
		echo 'Press Enter to return.'
		echo "${YELLOW}按回车键返回。${RESET}"
		read
		ItemizedConfiguration
	fi
	if [ ! -d "/usr/share/xfce4/terminal" ]; then
		echo "检测到xfce终端目录不存在，您当前可能没有安装xfce终端"
		echo 'Press Enter to continue,press Ctrl+C to cancel.'
		echo "${YELLOW}按回车键继续,按Ctrl+C取消。${RESET}"
		read
		mkdir -p /usr/share/xfce4/terminal
		apt install -y xfce4-terminal
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
		apt update
		apt install -y ${DEPENDENCIES}
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
REMOVEZSH() {
	OPTION=$(whiptail --title "REMOVE ZSH" --menu "您想要移除哪个项目？Which item do you want to remove?" 15 50 4 \
		"0" "Back to the main menu 返回主菜单" \
		"1" "Oh-my-zsh" \
		"2" "字体 fonts" \
		"3" "本工具 This tool" \
		"4" "zsh and git " \
		"5" "旧版残留文件 Legacy residual files" \
		"6" "zsh配置文件 .zshrc" \
		3>&1 1>&2 2>&3)

	if [ "${OPTION}" == '0' ]; then
		ZSHMANAGER
	fi
	if [ "${OPTION}" == '1' ]; then
		echo "${YELLOW}按回车键确认删除，Ctrl+C取消。${RESET} "
		echo "Press Enter to confirm the deletion, press Ctrl + C to cancel."
		read
		uninstall_oh_my_zsh 2>/dev/null || rm -rf ${HOME}/.oh-my-zsh
		echo "${YELLOW}删除完成，按回车键返回 Press Enter to return.${RESET} "
		read
		ZSHMANAGER
	fi
	if [ "${OPTION}" == '2' ]; then
		echo "${YELLOW}按回车键确认删除，Ctrl+C取消。${RESET} "
		echo "Press Enter to confirm the deletion, press Ctrl + C to cancel."
		read
		rm -rf ${HOME}/.termux/fonts
		echo "${YELLOW}删除完成，按回车键返回 Press Enter to return.${RESET} "
		read
		ZSHMANAGER
	fi
	if [ "${OPTION}" == '3' ]; then
		echo "${YELLOW}按回车键确认删除，Ctrl+C取消。${RESET} "
		echo "Press Enter to confirm the deletion, press Ctrl + C to cancel."
		read
		rm -rf ${HOME}/.termux-zsh
		echo "${YELLOW}删除完成，按回车键退出 Press Enter to exit.${RESET} "
		read
		exit
	fi

	if [ "${OPTION}" == '4' ]; then
		echo "${YELLOW}按回车键确认卸载，Ctrl+C取消。${RESET} "
		echo "Press Enter to confirm the deletion, press Ctrl + C to cancel."
		read
		apt purge git zsh
		apt autoremove
		echo "${YELLOW}卸载完成，按回车键返回 Press Enter to return.${RESET} "
		read
		ZSHMANAGER
	fi

	if [ "${OPTION}" == '5' ]; then
		echo '以下文件夹将被删除，是否确认？'
		ls -lAh ${HOME}/.zsh-syntax-highlighting
		ls -lAh ${HOME}/termux-ohmyzsh
		ls -lh ${HOME}/theme
		echo '按回车键确认，Ctrl+C取消。'
		echo "Press enter to confirm."
		read
		rm -rf ${HOME}/.zsh-syntax-highlighting ${HOME}/termux-ohmyzsh ${HOME}/theme
		echo "${YELLOW}删除完成，按回车键退出 Press Enter to exit.${RESET} "
		read
		exit
	fi
	if [ "${OPTION}" == '6' ]; then
		cat ${HOME}/.zshrc
		ls -lh ${HOME}/.zshrc
		echo "${YELLOW}按回车键确认删除，Ctrl+C取消。${RESET} "
		echo "Press Enter to confirm the deletion, press Ctrl + C to cancel."
		read
		rm -f ${HOME}/.zshrc
		echo "${YELLOW}删除完成，建议您返回主菜单使用一键配置，按回车键返回 Press Enter to return.${RESET} "
		read
		ZSHMANAGER
	fi

}

#################################################################
CHOOSEBACKUP() {
	if [ -d "${HOME}/.TERMUXFONTSTMPMOVE" ]; then
		rm -rf "${HOME}/.TERMUXFONTSTMPMOVE" 2>/dev/null
	fi

	if [ -d ${HOME}/.termux/fonts ]; then
		mv -f "${HOME}/.termux/fonts" "${HOME}/.TERMUXFONTSTMPMOVE" 2>/dev/null
	fi

	if (whiptail --title "Do you need to backup the current zsh configuration?" --yes-button 'OK (*￣▽￣*)o' --no-button 'No (っ °Д °；)っ' --yesno "您即将修改zsh的配色、字体和主题，请问是否需要备份当前zsh配置(不包含字体)。\n您可以单独输zshcolor来更改颜色，输zshfont来更改字体，输zshtheme来更改主题，输zsh-i进入zsh管理器。" 12 60); then
		mv "${HOME}/.termux" "${HOME}/.termux.bak.$(date +%Y.%m.%d-%H:%M:%S)" 2>/dev/null
		cp "${HOME}/.zshrc" "${HOME}/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)" 2>/dev/null
	else
		if [ ! -f "${HOME}/.termux/colors/wild.cherry" ]; then
			rm -rf "${HOME}/.termux/colors" 2>/dev/null
		fi

	fi
	if [ "$(uname -o)" != "Android" ]; then
		chsh -s $(command -v zsh) || sudo chsh -s $(command -v zsh)
	fi

	COLORSANDFONTS
}
################################
BACKUPZSH() {

	if [ ! -d /sdcard/Download/backup ]; then
		mkdir -p /sdcard/Download/backup && cd /sdcard/Download/backup
	else
		cd /sdcard/Download/backup
	fi

	ls -lth ./zsh*.tar.* 2>/dev/null && echo '您之前所备份的(部分)文件如上所示'

	echo "${YELLOW}按回车键选择压缩类型 Press enter to select compression type${RESET} "
	read

	echo $(date +%Y-%m-%d_%H-%M) >backuptime.tmp
	TMPtime=zsh_$(cat backuptime.tmp)

	if (whiptail --title "Select compression type 选择压缩类型 " --yes-button "tar.xz" --no-button "tar.gz" --yesno "Which do yo like better? \n tar.xz压缩率高，但速度慢。tar.xz has a higher compression ration, but is slower.\n tar.gz速度快,但压缩率低。tar.gz compresses faster, but with a lower compression ratio.\n 压缩过程中，进度条倒着跑是正常现象。" 12 60); then

		echo "您选择了tar.xz,即将为您备份至/sdcard/Download/backup/${TMPtime}.tar.xz"
		echo "${YELLOW}按回车键开始备份,按Ctrl+C取消。Press Enter to start the backup.${RESET} "
		read

		#tar -PJpcf - ${HOME}/.z ${HOME}/.zshrc ${HOME}/.termux ${HOME}/.zsh_history ${HOME}/.oh-my-zsh ${HOME}/.termux-zsh | (pv -n >${TMPtime}.tar.xz) 2>&1 | whiptail --gauge "Compressing into tar.xz" 10 70
		if [ -d "${HOME}/.termux-zsh" ]; then
			tar -PJpcf - ${HOME}/.z ${HOME}/.zshrc ${HOME}/.termux ${HOME}/.zsh_history ${HOME}/.oh-my-zsh ${HOME}/.termux-zsh | (pv -p --timer --rate --bytes >${TMPtime}.tar.xz)
		else
			if [ -d "${HOME}/.termux" ]; then

				tar -PJpcf - ${HOME}/.zshrc ${HOME}/.termux ${HOME}/.zsh_history ${HOME}/.oh-my-zsh | (pv -p --timer --rate --bytes >${TMPtime}.tar.xz)

			else
				tar -PJpcf - ${HOME}/.zshrc ${HOME}/.zsh_history ${HOME}/.oh-my-zsh | (pv -p --timer --rate --bytes >${TMPtime}.tar.xz)
			fi

		fi

		#xz -z -T0 -e -9 -f -v ${TMPtime}.tar
		echo "Don't worry too much, it is normal for some directories to backup without permission."
		echo "部分目录无权限备份是正常现象。"
		rm -f backuptime.tmp
		pwd
		ls -lth ./zsh*tar.xz | grep ^- | head -n 1
		echo "${YELLOW}备份完成,按回车键返回。${RESET} "
		echo "Press enter to return."
		read
		ZSHMANAGER

	else

		echo "您选择了tar.gz,即将为您备份至/sdcard/Download/backup/${TMPtime}.tar.gz"
		echo "${YELLOW}按回车键开始备份,按Ctrl+C取消。Press Enter to start the backup.${RESET} "
		read

		#tar -Ppczf - ${HOME}/.z ${HOME}/.zshrc ${HOME}/.termux ${HOME}/.zsh_history ${HOME}/.oh-my-zsh ${HOME}/.termux-zsh | (pv -n >${TMPtime}.tar.gz) 2>&1 | whiptail --gauge "Compressing into tar.gz \n正在压缩成tar.gz" 10 70
		#tar -Ppczf - ${HOME}/.z ${HOME}/.zshrc ${HOME}/.termux ${HOME}/.zsh_history ${HOME}/.oh-my-zsh ${HOME}/.termux-zsh | (pv -p --timer --rate --bytes >${TMPtime}.tar.gz)

		if [ -d "${HOME}/.termux-zsh" ]; then
			tar -Ppczf - ${HOME}/.z ${HOME}/.zshrc ${HOME}/.termux ${HOME}/.zsh_history ${HOME}/.oh-my-zsh ${HOME}/.termux-zsh | (pv -p --timer --rate --bytes >${TMPtime}.tar.gz)
		else
			if [ -d "${HOME}/.termux" ]; then

				tar -Ppczf - ${HOME}/.zshrc ${HOME}/.termux ${HOME}/.zsh_history ${HOME}/.oh-my-zsh | (pv -p --timer --rate --bytes >${TMPtime}.tar.gz)

			else
				tar -Ppczf - ${HOME}/.zshrc ${HOME}/.zsh_history ${HOME}/.oh-my-zsh | (pv -p --timer --rate --bytes >${TMPtime}.tar.gz)
			fi

		fi

		echo "Don't worry too much, it is normal for some directories to backup without permission."
		echo "部分目录无权限备份是正常现象。"
		rm -f backuptime.tmp
		#  whiptail --gauge "正在备份,可能需要几分钟的时间请稍后.........." 6 60 0
		pwd
		ls -lth ./zsh*tar.gz | grep ^- | head -n 1
		echo 'gzip压缩至60%完成是正常现象。'
		echo "${YELLOW}备份完成,按回车键返回。${RESET} "
		echo "Press enter to return."
		read
		ZSHMANAGER
	fi
}
###############################################
RESTOREZSH() {

	cd /sdcard/Download/backup
	ls -lth zsh*tar* || echo '未检测到备份文件' | head -n 10 2>/dev/null

	echo '目前仅支持还原最新的备份，如需还原旧版，请手动输以下命令'

	echo 'cd /sdcard/Download/backup ;ls ; tar -JPxvf 文件名.tar.xz 或 tar -Pzxvf 文件名.tar.gz'
	echo '请注意大小写，并把文件名改成具体名称'

	RESTORE=$(ls -lth ./zsh*tar* | grep ^- | head -n 1 | cut -d '/' -f 2)
	echo " "
	ls -lh ${RESTORE}
	printf "${YELLOW}即将为您还原${RESTORE}，请问是否确认？[Y/n]${RESET} "
	#printf之后分行
	echo ''
	echo 'Do you want to restore it?[Y/n]'

	read opt
	case $opt in
	y* | Y* | "")

		#0-6是截取字符
		if [ "${RESTORE:0-6:6}" == 'tar.xz' ]; then
			echo 'tar.xz'
			pv ${RESTORE} | tar -PJx
		fi

		if [ "${RESTORE:0-6:6}" == 'tar.gz' ]; then
			echo 'tar.gz'
			pv ${RESTORE} | tar -Pzx
		fi

		;;

	\
		\
		n* | N*) echo "skipped." ;;
	*) echo "Invalid choice. skipped." ;;

		#tar xfv $pathTar -C $path
		#(pv -n $pathTar | tar xfv $pathTar -C $path ) 2>&1 | dialog --gauge "Extracting file..." 6 50

	esac

	echo "${YELLOW}按回车键返回。Press enter to return.${RESET}"
	read
	ZSHMANAGER
}
###############################################
UPDATEPLUGINS() {
	if [ -e "/usr/lib/command-not-found" ]; then
		if [ "${LINUX_DISTRO}" = "debian" ]; then
			grep -q 'command-not-found' "${HOME}/.zshrc" 2>/dev/null || sed -i "$ a\source ${HOME}/.oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh" "${HOME}/.zshrc"
			if ! grep -qi 'Ubuntu' '/etc/os-release'; then
				apt-file update 2>/dev/null
				update-command-not-found 2>/dev/null
			fi
			apt update
			apt upgrade -y zsh git
		fi
	fi

	if [ -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
		cd "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
		git reset --hard origin/master
		git pull --depth=1 origin master --allow-unrelated-histories
	fi
	#upgrade zsh plugins and tool
	cd "${HOME}/.termux-zsh"
	#git fetch --depth=1
	git reset --hard origin/master
	git pull --depth=1 origin master --allow-unrelated-histories
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
	echo "${YELLOW}更新完成，按回车键返回。Press enter to return.${RESET}"
	read
	ZSHMANAGER

}
##############
android_default_shell() {
	if (whiptail --title "android_default_shell" --yes-button 'Yes' --no-button 'no' --yesno 'Android在配置本工具时，已经将zsh设置为默认shell了，您也可以在终端下输chsh -s bash或chsh -s zsh来切换默认shell 。您是否需要将默认shell设置为zsh?' 12 50); then
		chsh -s zsh
	else
		ZSHMANAGER
	fi
}
##########
gnu_linux_default_shell() {
	if (whiptail --title "gnu_linux_default_shell" --yes-button 'Yes' --no-button 'no' --yesno 'Linux在设置时需要输密码,若需手动配置，请输chsh -s $(command -v zsh)或chsh -s /bin/zsh,您是否需要将默认shell设置为zsh?' 10 50); then
		chsh -s $(command -v zsh) || sudo chsh -s $(command -v zsh)
	else
		ZSHMANAGER
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
	ZSHMANAGER
}

######################################
#####################################################
COLORSANDFONTS() {
	if [ -d "${HOME}/.termux-zsh/fonts" ]; then
		rm -rf "${HOME}/.termux-zsh/fonts" 2>/dev/null
	fi

	cp -rf "${HOME}/.termux-zsh/.termux" "${HOME}"
	mv -f "${HOME}/.TERMUXFONTSTMPMOVE" "${HOME}/.termux/fonts" 2>/dev/null

	CONFZSH
}

##################################################################################
CONFZSH() {
	#git clone oh-my-zsh
	if [ ! -d "${HOME}/.oh-my-zsh" ]; then
		git clone https://github.com/ohmyzsh/ohmyzsh.git "${HOME}/.oh-my-zsh" --depth 1 || git clone --depth=1 git://github.com/ohmyzsh/ohmyzsh "${HOME}/.oh-my-zsh"
		ZSH_FOLDER="${HOME}/.oh-my-zsh"
		fix_zsh_folder_permissions
		#else
		#   cd "${HOME}/.oh-my-zsh" && git pull --depth=1
	fi
	#新版不再覆盖zsh配置

	if [ ! -f "${HOME}/.zshrc" ]; then
		cp "${HOME}/.oh-my-zsh/templates/zshrc.zsh-template" "${HOME}/.zshrc" || wget -O "${HOME}/.zshrc" 'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template'
		chmod 755 "${HOME}/.zshrc"
	fi

	if [ -e "/usr/lib/command-not-found" ]; then
		if [ "${LINUX_DISTRO}" = "debian" ]; then
			grep -q 'command-not-found' "${HOME}/.zshrc" 2>/dev/null || sed -i "$ a\source ${HOME}/.oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh" "${HOME}/.zshrc"
			if ! grep -qi 'Ubuntu' '/etc/os-release'; then
				apt-file update 2>/dev/null
				update-command-not-found 2>/dev/null
			fi
		fi
	fi

	#重置主题
	sed -i '/^ZSH_THEME/d' "${HOME}/.zshrc"
	sed -i '1iZSH_THEME="agnoster"' "${HOME}/.zshrc"
	##############################################
	#外面双引号，里面单引号。
	#添加alias
	grep -q 'alias zshcolor=' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zshcolor='bash ${HOME}/.termux/colors.sh'" "${HOME}/.zshrc"

	#echo -e "\nalias zshcolor='${HOME}/.termux/colors.sh'" >>"${HOME}/.zshrc"

	grep -q 'alias zshfont=' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zshfont='bash ${HOME}/.termux/fonts.sh'" "${HOME}/.zshrc"

	grep -q 'alias zshtheme=' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zshtheme='bash ${HOME}/.termux/themes.sh'" "${HOME}/.zshrc"

	grep -q 'alias zsh-i=' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zsh-i='bash ${HOME}/.termux-zsh/update.sh'" "${HOME}/.zshrc"

	grep -q 'alias zsh-i=' "${HOME}/.bashrc" >/dev/null 2>&1 || sed -i "$ a\alias zsh-i='bash ${HOME}/.termux-zsh/update.sh'" "${HOME}/.bashrc"

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
	if grep -Eq 'buster|stretch|jessie|Bionic Beaver|Xenial|Cosmic|Disco' "/etc/os-release"; then
		ENABLE_FZF_TAB_EXTRA_OPT='false'
	fi
	if [ "${LINUX_DISTRO}" != "debian" ] && [ "${LINUX_DISTRO}" != "Android" ]; then
		ENABLE_FZF_TAB_EXTRA_OPT='false'
	fi

	if [ "${LINUX_DISTRO}" = "debian" ] || [ "${LINUX_DISTRO}" = "alpine" ] || [ "${LINUX_DISTRO}" = "redhat" ] || [ "${LINUX_DISTRO}" = "arch" ] || [ "${LINUX_DISTRO}" = "Android" ]; then
		if [ $(command -v fzf) ]; then
			if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/fzf-tab" ]; then
				sed -i '/fzf-tab.zsh/d' "${HOME}/.zshrc"
				git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git "${HOME}/.oh-my-zsh/custom/plugins/fzf-tab" || git clone --depth=1 git://github.com/Aloxaf/fzf-tab.git "${HOME}/.oh-my-zsh/custom/plugins/fzf-tab"
				chmod 755 -R "${HOME}/.oh-my-zsh/custom/plugins/fzf-tab"
				grep -q 'custom/plugins/fzf-tab/fzf-tab.zsh' "${HOME}/.zshrc" >/dev/null 2>&1 || sed -i "$ a\source ${HOME}/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.zsh" "${HOME}/.zshrc"
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

	alias zshcolor="bash ${HOME}/.termux/colors.sh"
	alias zshfont="bash ${HOME}/.termux/fonts.sh"
	alias zshtheme="bash ${HOME}/.termux/themes.sh"
	alias zsh-i="bash ${HOME}/.termux-zsh/zsh.sh"
	#echo -e "oh-my-zsh install complete!\nChoose your color scheme now~"
	####################################################
	#cd ${HOME}/.oh-my-zsh/themes || mkdir -p ${HOME}/.oh-my-zsh/themes && cd ${HOME}/.oh-my-zsh/themes
	#配置完成后的提示内容。
	echo "您已安装zsh,之后可以单独输${YELLOW}zshtheme${RESET}来更改主题,${YELLOW}zshcolor${RESET} 来更改配色，输 ${YELLOW}zshfont ${RESET}来更改字体,输 ${YELLOW}zsh-i ${RESET}进入zsh主题管理工具。"
	echo 'You have installed zsh, you can type "zshcolor" to change the color, type "zshfont" to change the font, type "zsh-i" to backup and reset the zsh configuration. '
	echo "当前已为您加载了z插件，若您曾访问过/sdcard/Download，则您可以输${YELLOW}z Down${RESET}或${YELLOW}z load${RESET}来快速跳转，访问列表可以输 ${YELLOW}z ${RESET}获取。"
	echo "还为您加载了解压插件extract，例如某文件名为233.tar.xz，则您无需输${YELLOW}tar -Jxf 233.tar.xz${RESET}，只需输${YELLOW}x 233.tar.xz${RESET}。同理，若另一文件为233.7z，则您只需输入${YELLOW}x 233.7z${RESET}即可解压。"
	echo '注意：您在解压前必须先安装相关依赖，例如：zip需要unzip，7z需要p7zip，安装方法类似于apt install -y unzip'
	echo 'Plugins such as syntax highlighting, extract, and z have been configured for you. Enjoy the fun of zsh!'
	##############################################################
	cd ${cur}
	if [ "${LINUX_DISTRO}" = "Android" ]; then
		echo "Choose your color scheme now~"
		#echo '请选择您的配色'
		bash ${HOME}/.termux/colors.sh
		echo ''
		echo "Choose your font now~"
		#echo '请选择您的字体'
		bash ${HOME}/.termux/fonts.sh
	fi
	echo ''
	echo "Choose your theme now~"
	#echo '请选择您的主题'
	bash ${HOME}/.termux/themes.sh

}
#########################################
CHECKSYSTEM
