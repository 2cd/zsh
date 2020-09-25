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
  3024.dark) TMOE_COLOR=3024.dark ;;
  3024.light) TMOE_COLOR=3024.light ;;
  aci) TMOE_COLOR=aci ;;
  aco) TMOE_COLOR=aco ;;
  apathy.dark) TMOE_COLOR=apathy.dark ;;
  apathy.light) TMOE_COLOR=apathy.light ;;
  argonaut) TMOE_COLOR=argonaut ;;
  ashes.dark) TMOE_COLOR=ashes.dark ;;
  ashes.light) TMOE_COLOR=ashes.light ;;
  atelierdune.dark) TMOE_COLOR=atelierdune.dark ;;
  atelierdune.light) TMOE_COLOR=atelierdune.light ;;
  atelierforest.dark) TMOE_COLOR=atelierforest.dark ;;
  atelierforest.light) TMOE_COLOR=atelierforest.light ;;
  atelierheath.dark) TMOE_COLOR=atelierheath.dark ;;
  atelierheath.light) TMOE_COLOR=atelierheath.light ;;
  atelierlakeside.dark) TMOE_COLOR=atelierlakeside.dark ;;
  atelierlakeside.light) TMOE_COLOR=atelierlakeside.light ;;
  atelierseaside.dark) TMOE_COLOR=atelierseaside.dark ;;
  atelierseaside.light) TMOE_COLOR=atelierseaside.light ;;
  azu) TMOE_COLOR=azu ;;
  base16.solarized.dark) TMOE_COLOR=base16.solarized.dark ;;
  base16.solarized.light) TMOE_COLOR=base16.solarized.light ;;
  bespin.dark) TMOE_COLOR=bespin.dark ;;
  bespin.light) TMOE_COLOR=bespin.light ;;
  bim) TMOE_COLOR=bim ;;
  black.on.white) TMOE_COLOR=black.on.white ;;
  brewer.dark) TMOE_COLOR=brewer.dark ;;
  brewer.light) TMOE_COLOR=brewer.light ;;
  bright.dark) TMOE_COLOR=bright.dark ;;
  bright.light) TMOE_COLOR=bright.light ;;
  cai) TMOE_COLOR=cai ;;
  chalk) TMOE_COLOR=chalk ;;
  chalk.dark) TMOE_COLOR=chalk.dark ;;
  chalk.light) TMOE_COLOR=chalk.light ;;
  codeschool.dark) TMOE_COLOR=codeschool.dark ;;
  codeschool.light) TMOE_COLOR=codeschool.light ;;
  colors.dark) TMOE_COLOR=colors.dark ;;
  colors.light) TMOE_COLOR=colors.light ;;
  default) TMOE_COLOR=default ;;
  default.dark) TMOE_COLOR=default.dark ;;
  default.light) TMOE_COLOR=default.light ;;
  dracula) TMOE_COLOR=dracula ;;
  eighties.dark) TMOE_COLOR=eighties.dark ;;
  eighties.light) TMOE_COLOR=eighties.light ;;
  elementary) TMOE_COLOR=elementary ;;
  elic) TMOE_COLOR=elic ;;
  elio) TMOE_COLOR=elio ;;
  embers.dark) TMOE_COLOR=embers.dark ;;
  embers.light) TMOE_COLOR=embers.light ;;
  flat) TMOE_COLOR=flat ;;
  flat.dark) TMOE_COLOR=flat.dark ;;
  flat.light) TMOE_COLOR=flat.light ;;
  freya) TMOE_COLOR=freya ;;
  gnometerm) TMOE_COLOR=gnometerm ;;
  google.dark) TMOE_COLOR=google.dark ;;
  google.light) TMOE_COLOR=google.light ;;
  gotham) TMOE_COLOR=gotham ;;
  grayscale.dark) TMOE_COLOR=grayscale.dark ;;
  grayscale.light) TMOE_COLOR=grayscale.light ;;
  greenscreen.dark) TMOE_COLOR=greenscreen.dark ;;
  greenscreen.light) TMOE_COLOR=greenscreen.light ;;
  gruvbox.dark) TMOE_COLOR=gruvbox.dark ;;
  gruvbox.light) TMOE_COLOR=gruvbox.light ;;
  harmonic16.dark) TMOE_COLOR=harmonic16.dark ;;
  harmonic16.light) TMOE_COLOR=harmonic16.light ;;
  hemisu.dark) TMOE_COLOR=hemisu.dark ;;
  hemisu.light) TMOE_COLOR=hemisu.light ;;
  hybrid) TMOE_COLOR=hybrid ;;
  isotope.dark) TMOE_COLOR=isotope.dark ;;
  isotope.light) TMOE_COLOR=isotope.light ;;
  jup) TMOE_COLOR=jup ;;
  londontube.dark) TMOE_COLOR=londontube.dark ;;
  londontube.light) TMOE_COLOR=londontube.light ;;
  mar) TMOE_COLOR=mar ;;
  marrakesh.dark) TMOE_COLOR=marrakesh.dark ;;
  marrakesh.light) TMOE_COLOR=marrakesh.light ;;
  materia) TMOE_COLOR=materia ;;
  material) TMOE_COLOR=material ;;
  miu) TMOE_COLOR=miu ;;
  mocha.dark) TMOE_COLOR=mocha.dark ;;
  mocha.light) TMOE_COLOR=mocha.light ;;
  monokai.dark) TMOE_COLOR=monokai.dark ;;
  monokai.light) TMOE_COLOR=monokai.light ;;
  nancy) TMOE_COLOR=nancy ;;
  neon) TMOE_COLOR=neon ;;
  nep) TMOE_COLOR=nep ;;
  nord) TMOE_COLOR=nord ;;
  ocean.dark) TMOE_COLOR=ocean.dark ;;
  ocean.light) TMOE_COLOR=ocean.light ;;
  one.dark) TMOE_COLOR=one.dark ;;
  one.light) TMOE_COLOR=one.light ;;
  pali) TMOE_COLOR=pali ;;
  paraiso.dark) TMOE_COLOR=paraiso.dark ;;
  paraiso.light) TMOE_COLOR=paraiso.light ;;
  peppermint) TMOE_COLOR=peppermint ;;
  railscasts.dark) TMOE_COLOR=railscasts.dark ;;
  railscasts.light) TMOE_COLOR=railscasts.light ;;
  rydgel) TMOE_COLOR=rydgel ;;
  sat) TMOE_COLOR=sat ;;
  shapeshifter.dark) TMOE_COLOR=shapeshifter.dark ;;
  shapeshifter.light) TMOE_COLOR=shapeshifter.light ;;
  shel) TMOE_COLOR=shel ;;
  smyck) TMOE_COLOR=smyck ;;
  solarized.dark) TMOE_COLOR=solarized.dark ;;
  solarized.light) TMOE_COLOR=solarized.light ;;
  summerfruit.dark) TMOE_COLOR=summerfruit.dark ;;
  summerfruit.light) TMOE_COLOR=summerfruit.light ;;
  tango) TMOE_COLOR=tango ;;
  tin) TMOE_COLOR=tin ;;
  tomorrow) TMOE_COLOR=tomorrow ;;
  tomorrow.dark) TMOE_COLOR=tomorrow.dark ;;
  tomorrow.light) TMOE_COLOR=tomorrow.light ;;
  tomorrow.night) TMOE_COLOR=tomorrow.night ;;
  tomorrow.night.blue) TMOE_COLOR=tomorrow.night.blue ;;
  tomorrow.night.bright) TMOE_COLOR=tomorrow.night.bright ;;
  tomorrow.night.eighties) TMOE_COLOR=tomorrow.night.eighties ;;
  twilight.dark) TMOE_COLOR=twilight.dark ;;
  twilight.light) TMOE_COLOR=twilight.light ;;
  ura) TMOE_COLOR=ura ;;
  vag) TMOE_COLOR=vag ;;
  white.on.black) TMOE_COLOR=white.on.black ;;
  wild.cherry) TMOE_COLOR=wild.cherry ;;
  zenburn) TMOE_COLOR=zenburn ;;
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
  COUNT=0
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
  序号列表模式。若参数为空，则将进入此模式。
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
 3024.dark // 3024.light // aci // aco // apathy.dark // apathy.light // argonaut // ashes.dark // ashes.light // atelierdune.dark // atelierdune.light // atelierforest.dark // atelierforest.light // atelierheath.dark // atelierheath.light // atelierlakeside.dark // atelierlakeside.light // atelierseaside.dark // atelierseaside.light // azu // base16.solarized.dark // base16.solarized.light // bespin.dark // bespin.light // bim // black.on.white // brewer.dark // brewer.light // bright.dark // bright.light // cai // chalk // chalk.dark // chalk.light // codeschool.dark // codeschool.light // colors.dark // colors.light // default // default.dark // default.light // dracula // eighties.dark // eighties.light // elementary // elic // elio // embers.dark // embers.light // flat // flat.dark // flat.light // freya // gnometerm // google.dark // google.light // gotham // grayscale.dark // grayscale.light // greenscreen.dark // greenscreen.light // gruvbox.dark // gruvbox.light // harmonic16.dark // harmonic16.light // hemisu.dark // hemisu.light // hybrid // isotope.dark // isotope.light // jup // londontube.dark // londontube.light // mar // marrakesh.dark // marrakesh.light // materia // material // miu // mocha.dark // mocha.light // monokai.dark // monokai.light // nancy // neon // nep // nord // ocean.dark // ocean.light // one.dark // one.light // pali // paraiso.dark // paraiso.light // peppermint // railscasts.dark // railscasts.light // rydgel // sat // shapeshifter.dark // shapeshifter.light // shel // smyck // solarized.dark // solarized.light // summerfruit.dark // summerfruit.light // tango // tin // tomorrow // tomorrow.dark // tomorrow.light // tomorrow.night // tomorrow.night.blue // tomorrow.night.bright // tomorrow.night.eighties // twilight.dark // twilight.light // ura // vag // white.on.black // wild.cherry // zenburn
ENDOFTMOEZSHHELP02
}
######
choose_termux_color() {
  echo -e "The default color scheme is monokai dark.\nYou can choose another one from the list below"
  echo "您可以在${BLUE}此列表${RESET}中选择终端${YELLOW}配色${RESET}。"
  for TRUE_TERMUX_COLOR_FILE in "${COLORS_DIR}"/*; do
    TERMUX_COLOR_NAME[COUNT]=$(echo ${TRUE_TERMUX_COLOR_FILE} | awk -F '/' '{print $NF}')
    echo -e "($COUNT) ${TERMUX_COLOR_NAME[COUNT]}"
    COUNT=$(($COUNT + 1))
  done
  COUNT=$(($COUNT - 1))

  while true; do
    read -p '请输入选项数字,并按回车键,留空不更改。Please type the option number and press Enter:' TERMUX_COLOR_NUMBER
    if [[ -z "${TERMUX_COLOR_NUMBER}" ]]; then
      break
    elif ! [[ ${TERMUX_COLOR_NUMBER} =~ ^[0-9]+$ ]]; then
      echo "Please type the right number!"
    elif ((${TERMUX_COLOR_NUMBER} >= 0 && ${TERMUX_COLOR_NUMBER} <= $COUNT)); then
      eval TMOE_TERMUX_COLOR=${TERMUX_COLOR_NAME[TERMUX_COLOR_NUMBER]}
      cp -rvf "${COLORS_DIR}/${TMOE_TERMUX_COLOR}" "${TERMUX_COLOR_FILE}"
      break
    else
      echo "Please type the right number!"
    fi
  done
  #echo "您可以输${YELLOW}zshcolor${RESET} 来更改${BLUE}配色${RESET},you can type ${GREEN}zshcolor${RESET} to change the ${BLUE}color${RESET}."
  cat <<-ENDOFTMOEZSHHELP03
		  输${YELLOW}zshcolor -h${RESET}来获取${BLUE}终端配色帮助信息${RESET}。
		  You can type ${GREEN}zshcolor -h${RESET} to get the ${BLUE}terminal color scheme help info${RESET}.
	ENDOFTMOEZSHHELP03
  termux-reload-settings
}
##############
tmoe_color_main "$@"
