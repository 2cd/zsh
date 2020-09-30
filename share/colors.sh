#!/usr/bin/env bash
#/data/data/com.termux/files/usr/bin/bash
################
tmoe_color_main() {
  terminal_color
  tmoe_termux_color_env
  CATCAT_COLOR='false'
  case "$1" in
  h | -h | help | --help | --get-help-info)
    CATCAT_COLOR='true'
    get_tmoe_termux_color_help_info
    ;;
  -n | --no-color)
    get_tmoe_termux_color_help_info
    ;;
  -num | --number | "")
    get_tmoe_termux_color_help_info
    choose_termux_color
    ;;
  '3024.dark' | '3024.light' | 'aci' | 'aco' | 'apathy.dark' | 'apathy.light' | 'argonaut' | 'ashes.dark' | 'ashes.light' | 'atelierdune.dark' | 'atelierdune.light' | 'atelierforest.dark' | 'atelierforest.light' | 'atelierheath.dark' | 'atelierheath.light' | 'atelierlakeside.dark' | 'atelierlakeside.light' | 'atelierseaside.dark' | 'atelierseaside.light' | 'azu' | 'base16.solarized.dark' | 'base16.solarized.light' | 'bespin.dark' | 'bespin.light' | 'bim' | 'black.on.white' | 'brewer.dark' | 'brewer.light' | 'bright.dark' | 'bright.light' | 'cai' | 'chalk' | 'chalk.dark' | 'chalk.light' | 'codeschool.dark' | 'codeschool.light' | 'colors.dark' | 'colors.light' | 'default' | 'default.dark' | 'default.light' | 'dracula' | 'eighties.dark' | 'eighties.light' | 'elementary' | 'elic' | 'elio' | 'embers.dark' | 'embers.light' | 'flat' | 'flat.dark' | 'flat.light' | 'freya' | 'gnometerm' | 'google.dark' | 'google.light' | 'gotham' | 'grayscale.dark' | 'grayscale.light' | 'greenscreen.dark' | 'greenscreen.light' | 'gruvbox.dark' | 'gruvbox.light' | 'harmonic16.dark' | 'harmonic16.light' | 'hemisu.dark' | 'hemisu.light' | 'hybrid' | 'isotope.dark' | 'isotope.light' | 'jup' | 'londontube.dark' | 'londontube.light' | 'mar' | 'marrakesh.dark' | 'marrakesh.light' | 'materia' | 'material' | 'miu' | 'mocha.dark' | 'mocha.light' | 'monokai.dark' | 'monokai.light' | 'nancy' | 'neon' | 'nep' | 'nord' | 'ocean.dark' | 'ocean.light' | 'one.dark' | 'one.light' | 'pali' | 'paraiso.dark' | 'paraiso.light' | 'peppermint' | 'railscasts.dark' | 'railscasts.light' | 'rydgel' | 'sat' | 'shapeshifter.dark' | 'shapeshifter.light' | 'shel' | 'smyck' | 'solarized.dark' | 'solarized.light' | 'summerfruit.dark' | 'summerfruit.light' | 'tango' | 'tin' | 'tomorrow' | 'tomorrow.dark' | 'tomorrow.light' | 'tomorrow.night' | 'tomorrow.night.blue' | 'tomorrow.night.bright' | 'tomorrow.night.eighties' | 'twilight.dark' | 'twilight.light' | 'ura' | 'vag' | 'white.on.black' | 'wild.cherry' | 'zenburn') TMOE_COLOR="$1" ;;
  esac
  case_tmoe_zsh_color_scheme
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
case_tmoe_zsh_color_scheme() {
  case ${TMOE_COLOR} in
  "") ;;
  *)
    TMOE_TERMUX_COLOR="${TMOE_COLOR}"
    cp -rvf "${COLORS_DIR}/${TMOE_TERMUX_COLOR}" "${TERMUX_COLOR_FILE}"
    termux-reload-settings
    ;;
  esac
}
############
tmoe_termux_color_env() {
  TMOE_COLOR=''
  case $(uname -o) in
  Android) [[ -e "${HOME}/.termux" ]] || mkdir -p ${HOME}/.termux ;;
  *)
    get_tmoe_termux_color_help_info
    echo "${RED}Sorry${RESET}！此功能暂未适配GNU/Linux"
    echo "请输zsh-i，并选择分项配置。"
    echo "The function of changing color scheme is only suitable for termux."
    exit 1
    ;;
  esac
  TERMUX_COLOR_FILE="${HOME}/.termux/colors.properties"
  COLORS_DIR=${HOME}/.config/tmoe-zsh/git/share/colors
}
##############
get_tmoe_termux_color_help_info() {
  CATCAT=''
  for i in /bin/lolcat /usr/games/lolcat; do
    #batcat | bat)
    #[[ ! $(command -v ${i}) ]] || CATCAT=""${i}" "--language" "zsh""
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
  ${BOLD}${YELLOW}COMMAND${RESET}${RESET}: ${GREEN}zshcolor${RESET} 
  ${BOLD}${YELLOW}命令${RESET}${RESET}: ${GREEN}zshcolor${RESET}
  ${BOLD}${YELLOW}Description${RESET}${RESET}: ${BLUE}This command can change the terminal color scheme${RESET}.
  ${BOLD}${YELLOW}描述${RESET}${RESET}: ${BLUE}此命令能修改终端配色${RESET}。
  --------------
  ${YELLOW}-h${RESET}      --help 
  get-help-info 获取帮助信息
  --------------
  ${YELLOW}-n${RESET}      --no-color
  In this mode, the color scheme list will have no color.
  若您安装了lolcat，则主题列表将输出五彩斑斓的颜色，而${YELLOW}-n${RESET}参数将${RED}禁用${RESET}此模式。
  --------------
  ${YELLOW}-num${RESET}    --number list. This is the default mode.
  If the parameter is empty, it will enter this mode.
  It is interactive, you need to type ${GREEN}zshcolor${RESET} or ${GREEN}zshcolor -num${RESET} to start this mode first, and then type the option number,finally press ${YELLOW}Enter${RESET} key.
  ${GREEN}序号列表${RESET}模式。若参数为空，则将进入此模式。
  此模式为交互式操作，您可以先输${GREEN}zshcolor${RESET}启动,接着输入数字序号。
  --------------
  ${BOLD}${YELLOW}NOTES${RESET}${RESET} of ${GREEN}manual mode${RESET} 
  ${GREEN}手动模式${RESET}的${BOLD}${YELLOW}说明${RESET}${RESET}
  You can type ${GREEN}zshcolor${RESET} ${BLUE}\$COLOR_NAME${RESET} to change the terminal color scheme.
  For example.01: If you type ${GREEN}zshcolor${RESET} ${BLUE}monokai.dark${RESET},then terminal color will be changed to ${BLUE}monokai.dark${RESET}.
  您可以输${GREEN}zshcolor${RESET} ${BLUE}\$配色名称${RESET}来修改配色。
  例如： 输入${GREEN}zshcolor${RESET} ${BLUE}neon${RESET}，将配色修改为${BLUE}neon${RESET}。
  --------------
  ${BOLD}${YELLOW}LIST OF COLOR SCHEMES${RESET}${RESET}:
ENDOFTMOEZSHHELP01
  ${CATCAT} <<-'ENDOFTMOEZSHHELP02'
    '3024.dark' | '3024.light' | 'aci' | 'aco' | 'apathy.dark' | 'apathy.light' | 'argonaut' | 'ashes.dark' | 'ashes.light' | 'atelierdune.dark' | 'atelierdune.light' | 'atelierforest.dark' | 'atelierforest.light' | 'atelierheath.dark' | 'atelierheath.light' | 'atelierlakeside.dark' | 'atelierlakeside.light' | 'atelierseaside.dark' | 'atelierseaside.light' | 'azu' | 'base16.solarized.dark' | 'base16.solarized.light' | 'bespin.dark' | 'bespin.light' | 'bim' | 'black.on.white' | 'brewer.dark' | 'brewer.light' | 'bright.dark' | 'bright.light' | 'cai' | 'chalk' | 'chalk.dark' | 'chalk.light' | 'codeschool.dark' | 'codeschool.light' | 'colors.dark' | 'colors.light' | 'default' | 'default.dark' | 'default.light' | 'dracula' | 'eighties.dark' | 'eighties.light' | 'elementary' | 'elic' | 'elio' | 'embers.dark' | 'embers.light' | 'flat' | 'flat.dark' | 'flat.light' | 'freya' | 'gnometerm' | 'google.dark' | 'google.light' | 'gotham' | 'grayscale.dark' | 'grayscale.light' | 'greenscreen.dark' | 'greenscreen.light' | 'gruvbox.dark' | 'gruvbox.light' | 'harmonic16.dark' | 'harmonic16.light' | 'hemisu.dark' | 'hemisu.light' | 'hybrid' | 'isotope.dark' | 'isotope.light' | 'jup' | 'londontube.dark' | 'londontube.light' | 'mar' | 'marrakesh.dark' | 'marrakesh.light' | 'materia' | 'material' | 'miu' | 'mocha.dark' | 'mocha.light' | 'monokai.dark' | 'monokai.light' | 'nancy' | 'neon' | 'nep' | 'nord' | 'ocean.dark' | 'ocean.light' | 'one.dark' | 'one.light' | 'pali' | 'paraiso.dark' | 'paraiso.light' | 'peppermint' | 'railscasts.dark' | 'railscasts.light' | 'rydgel' | 'sat' | 'shapeshifter.dark' | 'shapeshifter.light' | 'shel' | 'smyck' | 'solarized.dark' | 'solarized.light' | 'summerfruit.dark' | 'summerfruit.light' | 'tango' | 'tin' | 'tomorrow' | 'tomorrow.dark' | 'tomorrow.light' | 'tomorrow.night' | 'tomorrow.night.blue' | 'tomorrow.night.bright' | 'tomorrow.night.eighties' | 'twilight.dark' | 'twilight.light' | 'ura' | 'vag' | 'white.on.black' | 'wild.cherry' | 'zenburn'
  --------------
ENDOFTMOEZSHHELP02
}
######
select_termux_color() {
  cat <<-ENDOFTMOEZSHHELP03
	ENDOFTMOEZSHHELP03
  PS3="请输入${YELLOW}选项数字${RESET},并按${BLUE}回车键${RESET}。\
  Please type the ${GREEN}option number${RESET} and press ${BLUE}Enter${RESET}${YELLOW}[1-123]:${RESET}"
  select TERMUX_COLOR_NAME in '3024.dark' '3024.light' 'aci' 'aco' 'apathy.dark' 'apathy.light' 'argonaut' 'ashes.dark' 'ashes.light' 'atelierdune.dark' 'atelierdune.light' 'atelierforest.dark' 'atelierforest.light' 'atelierheath.dark' 'atelierheath.light' 'atelierlakeside.dark' 'atelierlakeside.light' 'atelierseaside.dark' 'atelierseaside.light' 'azu' 'base16.solarized.dark' 'base16.solarized.light' 'bespin.dark' 'bespin.light' 'bim' 'black.on.white' 'brewer.dark' 'brewer.light' 'bright.dark' 'bright.light' 'cai' 'chalk' 'chalk.dark' 'chalk.light' 'codeschool.dark' 'codeschool.light' 'colors.dark' 'colors.light' 'default' 'default.dark' 'default.light' 'dracula' 'eighties.dark' 'eighties.light' 'elementary' 'elic' 'elio' 'embers.dark' 'embers.light' 'flat' 'flat.dark' 'flat.light' 'freya' 'gnometerm' 'google.dark' 'google.light' 'gotham' 'grayscale.dark' 'grayscale.light' 'greenscreen.dark' 'greenscreen.light' 'gruvbox.dark' 'gruvbox.light' 'harmonic16.dark' 'harmonic16.light' 'hemisu.dark' 'hemisu.light' 'hybrid' 'isotope.dark' 'isotope.light' 'jup' 'londontube.dark' 'londontube.light' 'mar' 'marrakesh.dark' 'marrakesh.light' 'materia' 'material' 'miu' 'mocha.dark' 'mocha.light' 'monokai.dark' 'monokai.light' 'nancy' 'neon' 'nep' 'nord' 'ocean.dark' 'ocean.light' 'one.dark' 'one.light' 'pali' 'paraiso.dark' 'paraiso.light' 'peppermint' 'railscasts.dark' 'railscasts.light' 'rydgel' 'sat' 'shapeshifter.dark' 'shapeshifter.light' 'shel' 'smyck' 'solarized.dark' 'solarized.light' 'summerfruit.dark' 'summerfruit.light' 'tango' 'tin' 'tomorrow' 'tomorrow.dark' 'tomorrow.light' 'tomorrow.night' 'tomorrow.night.blue' 'tomorrow.night.bright' 'tomorrow.night.eighties' 'twilight.dark' 'twilight.light' 'ura' 'vag' 'white.on.black' 'wild.cherry' 'zenburn' 'skip跳过'; do
    case ${TERMUX_COLOR_NAME} in
    'skip跳过')
      cat <<-ENDOFTMOEZSHHELP04
      skipped.
		  输${YELLOW}zshcolor h${RESET}来获取${BLUE}终端配色帮助信息${RESET}。
		  You can type ${GREEN}zshcolor h${RESET} to get the ${BLUE}help info of terminal color schemes${RESET}.
	ENDOFTMOEZSHHELP04
      break
      ;;
    '3024.dark' | '3024.light' | 'aci' | 'aco' | 'apathy.dark' | 'apathy.light' | 'argonaut' | 'ashes.dark' | 'ashes.light' | 'atelierdune.dark' | 'atelierdune.light' | 'atelierforest.dark' | 'atelierforest.light' | 'atelierheath.dark' | 'atelierheath.light' | 'atelierlakeside.dark' | 'atelierlakeside.light' | 'atelierseaside.dark' | 'atelierseaside.light' | 'azu' | 'base16.solarized.dark' | 'base16.solarized.light' | 'bespin.dark' | 'bespin.light' | 'bim' | 'black.on.white' | 'brewer.dark' | 'brewer.light' | 'bright.dark' | 'bright.light' | 'cai' | 'chalk' | 'chalk.dark' | 'chalk.light' | 'codeschool.dark' | 'codeschool.light' | 'colors.dark' | 'colors.light' | 'default' | 'default.dark' | 'default.light' | 'dracula' | 'eighties.dark' | 'eighties.light' | 'elementary' | 'elic' | 'elio' | 'embers.dark' | 'embers.light' | 'flat' | 'flat.dark' | 'flat.light' | 'freya' | 'gnometerm' | 'google.dark' | 'google.light' | 'gotham' | 'grayscale.dark' | 'grayscale.light' | 'greenscreen.dark' | 'greenscreen.light' | 'gruvbox.dark' | 'gruvbox.light' | 'harmonic16.dark' | 'harmonic16.light' | 'hemisu.dark' | 'hemisu.light' | 'hybrid' | 'isotope.dark' | 'isotope.light' | 'jup' | 'londontube.dark' | 'londontube.light' | 'mar' | 'marrakesh.dark' | 'marrakesh.light' | 'materia' | 'material' | 'miu' | 'mocha.dark' | 'mocha.light' | 'monokai.dark' | 'monokai.light' | 'nancy' | 'neon' | 'nep' | 'nord' | 'ocean.dark' | 'ocean.light' | 'one.dark' | 'one.light' | 'pali' | 'paraiso.dark' | 'paraiso.light' | 'peppermint' | 'railscasts.dark' | 'railscasts.light' | 'rydgel' | 'sat' | 'shapeshifter.dark' | 'shapeshifter.light' | 'shel' | 'smyck' | 'solarized.dark' | 'solarized.light' | 'summerfruit.dark' | 'summerfruit.light' | 'tango' | 'tin' | 'tomorrow' | 'tomorrow.dark' | 'tomorrow.light' | 'tomorrow.night' | 'tomorrow.night.blue' | 'tomorrow.night.bright' | 'tomorrow.night.eighties' | 'twilight.dark' | 'twilight.light' | 'ura' | 'vag' | 'white.on.black' | 'wild.cherry' | 'zenburn')
      echo "${BLUE}${TERMUX_COLOR_NAME}${RESET}"
      cp -rvf "${COLORS_DIR}/${TERMUX_COLOR_NAME}" "${TERMUX_COLOR_FILE}"
      break
      ;;
    *)
      echo ${BOLD}--------------${RESET}
      echo "Please ${BLUE}type${RESET} the right ${BOLD}${RED}pure number${RESET}${RESET}!"
      echo "请${BLUE}输入${RESET}正确的${BOLD}${RED}纯数字${RESET}${RESET}!"
      ;;
    esac
  done
}
############
choose_termux_color() {
  echo -e "The default color scheme is monokai dark.\nYou can choose another one from the list below"
  echo "您可以在${BLUE}此列表${RESET}中选择终端${YELLOW}配色${RESET}。"
  select_termux_color
  #echo "您可以输${YELLOW}zshcolor${RESET} 来更改${BLUE}配色${RESET},you can type ${GREEN}zshcolor${RESET} to change the ${BLUE}color${RESET}."
  termux-reload-settings
}
##############
tmoe_color_main "$@"
