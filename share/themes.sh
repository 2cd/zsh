#!/usr/bin/env bash
################
tmoe_theme_main() {
  terminal_color
  tmoe_zsh_theme_env
  CATCAT_COLOR='false'
  case "$1" in
  h | -h | help | --help | --get-help-info)
    CATCAT_COLOR='true'
    get_tmoe_zsh_theme_help_info
    ;;
  -n | --no-color)
    get_tmoe_zsh_theme_help_info
    ;;
  -num | --number | "")
    get_tmoe_zsh_theme_help_info
    choose_zsh_theme
    ;;
  3den) TMOE_THEME=3den ;;
  abaykan) TMOE_THEME=abaykan ;;
  adben) TMOE_THEME=adben ;;
  af-magic) TMOE_THEME=af-magic ;;
  afowler) TMOE_THEME=afowler ;;
  agnoster) TMOE_THEME=agnoster ;;
  agnosterzak) TMOE_THEME=agnosterzak ;;
  alanpeabody) TMOE_THEME=alanpeabody ;;
  amuse) TMOE_THEME=amuse ;;
  aphrodite) TMOE_THEME=aphrodite ;;
  apple) TMOE_THEME=apple ;;
  arrow) TMOE_THEME=arrow ;;
  asciigit) TMOE_THEME=asciigit ;;
  aussiegeek) TMOE_THEME=aussiegeek ;;
  avit) TMOE_THEME=avit ;;
  avit-da2k) TMOE_THEME=avit-da2k ;;
  awesomepanda) TMOE_THEME=awesomepanda ;;
  bender) TMOE_THEME=bender ;;
  bira) TMOE_THEME=bira ;;
  blinks) TMOE_THEME=blinks ;;
  blokkzh) TMOE_THEME=blokkzh ;;
  bullet-train) TMOE_THEME=bullet-train ;;
  bunnyruni) TMOE_THEME=bunnyruni ;;
  bureau) TMOE_THEME=bureau ;;
  candy) TMOE_THEME=candy ;;
  candy-kingdom) TMOE_THEME=candy-kingdom ;;
  chi) TMOE_THEME=chi ;;
  chill) TMOE_THEME=chill ;;
  classyTouch) TMOE_THEME=classyTouch ;;
  clean) TMOE_THEME=clean ;;
  cloud) TMOE_THEME=cloud ;;
  cordial) TMOE_THEME=cordial ;;
  crcandy) TMOE_THEME=crcandy ;;
  crunch) TMOE_THEME=crunch ;;
  cypher) TMOE_THEME=cypher ;;
  dallas) TMOE_THEME=dallas ;;
  darkblood) TMOE_THEME=darkblood ;;
  daveverwer) TMOE_THEME=daveverwer ;;
  dieter) TMOE_THEME=dieter ;;
  docker) TMOE_THEME=docker ;;
  dogenpunk) TMOE_THEME=dogenpunk ;;
  dpoggi) TMOE_THEME=dpoggi ;;
  drofloh) TMOE_THEME=drofloh ;;
  dst) TMOE_THEME=dst ;;
  dstufft) TMOE_THEME=dstufft ;;
  ducula) TMOE_THEME=ducula ;;
  duellj) TMOE_THEME=duellj ;;
  eastwood) TMOE_THEME=eastwood ;;
  edvardm) TMOE_THEME=edvardm ;;
  elessar) TMOE_THEME=elessar ;;
  emotty) TMOE_THEME=emotty ;;
  enlightenment) TMOE_THEME=enlightenment ;;
  essembeh) TMOE_THEME=essembeh ;;
  evan) TMOE_THEME=evan ;;
  fino) TMOE_THEME=fino ;;
  fino-time) TMOE_THEME=fino-time ;;
  fishy) TMOE_THEME=fishy ;;
  fishy2) TMOE_THEME=fishy2 ;;
  flazz) TMOE_THEME=flazz ;;
  fletcherm) TMOE_THEME=fletcherm ;;
  fox) TMOE_THEME=fox ;;
  frisk) TMOE_THEME=frisk ;;
  frontcube) TMOE_THEME=frontcube ;;
  funky) TMOE_THEME=funky ;;
  funkyberlin) TMOE_THEME=funkyberlin ;;
  fwalch) TMOE_THEME=fwalch ;;
  gallifrey) TMOE_THEME=gallifrey ;;
  gallois) TMOE_THEME=gallois ;;
  garyblessington) TMOE_THEME=garyblessington ;;
  gentoo) TMOE_THEME=gentoo ;;
  geoffgarside) TMOE_THEME=geoffgarside ;;
  gianu) TMOE_THEME=gianu ;;
  gitster) TMOE_THEME=gitster ;;
  gnzh) TMOE_THEME=gnzh ;;
  gozilla) TMOE_THEME=gozilla ;;
  half-life) TMOE_THEME=half-life ;;
  halil) TMOE_THEME=halil ;;
  haribo) TMOE_THEME=haribo ;;
  hedgehog) TMOE_THEME=hedgehog ;;
  humza) TMOE_THEME=humza ;;
  hyper-oh-my-zsh) TMOE_THEME=hyper-oh-my-zsh ;;
  hyperzsh) TMOE_THEME=hyperzsh ;;
  igorsilva) TMOE_THEME=igorsilva ;;
  imajes) TMOE_THEME=imajes ;;
  imp) TMOE_THEME=imp ;;
  imperator-root) TMOE_THEME=imperator-root ;;
  intheloop) TMOE_THEME=intheloop ;;
  intika) TMOE_THEME=intika ;;
  itchy) TMOE_THEME=itchy ;;
  jaischeema) TMOE_THEME=jaischeema ;;
  jbergantine) TMOE_THEME=jbergantine ;;
  jispwoso) TMOE_THEME=jispwoso ;;
  jnrowe) TMOE_THEME=jnrowe ;;
  jonathan) TMOE_THEME=jonathan ;;
  josh) TMOE_THEME=josh ;;
  jovial) TMOE_THEME=jovial ;;
  jreese) TMOE_THEME=jreese ;;
  jtriley) TMOE_THEME=jtriley ;;
  juanghurtado) TMOE_THEME=juanghurtado ;;
  junkfood) TMOE_THEME=junkfood ;;
  kafeitu) TMOE_THEME=kafeitu ;;
  kardan) TMOE_THEME=kardan ;;
  kayid) TMOE_THEME=kayid ;;
  kennethreitz) TMOE_THEME=kennethreitz ;;
  kimwz) TMOE_THEME=kimwz ;;
  kinda-fishy) TMOE_THEME=kinda-fishy ;;
  kiwi) TMOE_THEME=kiwi ;;
  kmac) TMOE_THEME=kmac ;;
  kolo) TMOE_THEME=kolo ;;
  kphoen) TMOE_THEME=kphoen ;;
  lambda) TMOE_THEME=lambda ;;
  lambda-gitster) TMOE_THEME=lambda-gitster ;;
  lambda-mod) TMOE_THEME=lambda-mod ;;
  lambda-v) TMOE_THEME=lambda-v ;;
  linuxonly) TMOE_THEME=linuxonly ;;
  lukerandall) TMOE_THEME=lukerandall ;;
  macovsky) TMOE_THEME=macovsky ;;
  maran) TMOE_THEME=maran ;;
  maza) TMOE_THEME=maza ;;
  McQuen) TMOE_THEME=McQuen ;;
  mgutz) TMOE_THEME=mgutz ;;
  mh) TMOE_THEME=mh ;;
  michelebologna) TMOE_THEME=michelebologna ;;
  mikeh) TMOE_THEME=mikeh ;;
  miloshadzic) TMOE_THEME=miloshadzic ;;
  minimal) TMOE_THEME=minimal ;;
  minimal2) TMOE_THEME=minimal2 ;;
  minimal_improve) TMOE_THEME=minimal_improve ;;
  mira) TMOE_THEME=mira ;;
  mortalscumbag) TMOE_THEME=mortalscumbag ;;
  mrtazz) TMOE_THEME=mrtazz ;;
  murilasso) TMOE_THEME=murilasso ;;
  muse) TMOE_THEME=muse ;;
  nanotech) TMOE_THEME=nanotech ;;
  nebirhos) TMOE_THEME=nebirhos ;;
  nicoulaj) TMOE_THEME=nicoulaj ;;
  node) TMOE_THEME=node ;;
  nodeys) TMOE_THEME=nodeys ;;
  norm) TMOE_THEME=norm ;;
  nox) TMOE_THEME=nox ;;
  nt9) TMOE_THEME=nt9 ;;
  nuts) TMOE_THEME=nuts ;;
  obraun) TMOE_THEME=obraun ;;
  odin) TMOE_THEME=odin ;;
  ohwonder) TMOE_THEME=ohwonder ;;
  oxide) TMOE_THEME=oxide ;;
  peepcode) TMOE_THEME=peepcode ;;
  philips) TMOE_THEME=philips ;;
  philthy) TMOE_THEME=philthy ;;
  pi) TMOE_THEME=pi ;;
  pmcgee) TMOE_THEME=pmcgee ;;
  p9k | powerlevel9k) TMOE_THEME=powerlevel9k ;;
  p10k | -p10k | powerlevel10k) TMOE_THEME=powerlevel10k ;;
  punctual) TMOE_THEME=punctual ;;
  pygmalion) TMOE_THEME=pygmalion ;;
  pygmalion-virtualenv) TMOE_THEME=pygmalion-virtualenv ;;
  rafiki) TMOE_THEME=rafiki ;;
  random) TMOE_THEME=random ;;
  random-emoji) TMOE_THEME=random-emoji ;;
  re5et) TMOE_THEME=re5et ;;
  refined) TMOE_THEME=refined ;;
  reggae) TMOE_THEME=reggae ;;
  rgm) TMOE_THEME=rgm ;;
  risto) TMOE_THEME=risto ;;
  rixius) TMOE_THEME=rixius ;;
  rkj) TMOE_THEME=rkj ;;
  rkj-repos) TMOE_THEME=rkj-repos ;;
  robbyrussell) TMOE_THEME=robbyrussell ;;
  robbyrussell-WIP) TMOE_THEME=robbyrussell-WIP ;;
  sammy) TMOE_THEME=sammy ;;
  shayan) TMOE_THEME=shayan ;;
  simonoff) TMOE_THEME=simonoff ;;
  simple) TMOE_THEME=simple ;;
  skaro) TMOE_THEME=skaro ;;
  sm) TMOE_THEME=sm ;;
  smt) TMOE_THEME=smt ;;
  sobole) TMOE_THEME=sobole ;;
  Soliah) TMOE_THEME=Soliah ;;
  sonicradish) TMOE_THEME=sonicradish ;;
  sorin) TMOE_THEME=sorin ;;
  sporty_256) TMOE_THEME=sporty_256 ;;
  staples) TMOE_THEME=staples ;;
  steeef) TMOE_THEME=steeef ;;
  strug) TMOE_THEME=strug ;;
  sunaku) TMOE_THEME=sunaku ;;
  sunrise) TMOE_THEME=sunrise ;;
  superjarin) TMOE_THEME=superjarin ;;
  suvash) TMOE_THEME=suvash ;;
  takashiyoshida) TMOE_THEME=takashiyoshida ;;
  terminalparty) TMOE_THEME=terminalparty ;;
  theunraveler) TMOE_THEME=theunraveler ;;
  tjkirch) TMOE_THEME=tjkirch ;;
  tjkirch_mod) TMOE_THEME=tjkirch_mod ;;
  tonotdo) TMOE_THEME=tonotdo ;;
  traditional-plus) TMOE_THEME=traditional-plus ;;
  trapd00r) TMOE_THEME=trapd00r ;;
  typewritten) TMOE_THEME=typewritten ;;
  vero) TMOE_THEME=vero ;;
  via) TMOE_THEME=via ;;
  wedisagree) TMOE_THEME=wedisagree ;;
  wezm) TMOE_THEME=wezm ;;
  wezm+) TMOE_THEME=wezm+ ;;
  windows) TMOE_THEME=windows ;;
  wuffers) TMOE_THEME=wuffers ;;
  xiong-chiamiov) TMOE_THEME=xiong-chiamiov ;;
  xiong-chiamiov-plus) TMOE_THEME=xiong-chiamiov-plus ;;
  xxf) TMOE_THEME=xxf ;;
  ys) TMOE_THEME=ys ;;
  zeroastro) TMOE_THEME=zeroastro ;;
  zeta) TMOE_THEME=zeta ;;
  zhann) TMOE_THEME=zhann ;;
  *) echo "Unknown parameter,you can type ${GREEN}zshtheme h${RESET} to get help information.If you find a bug, please submit an issue to the git-repo of ${BLUE}tmoe-zsh${RESET}." ;;
  esac
  case_tmoe_zsh_theme
}
##############
case_tmoe_zsh_theme() {
  case ${TMOE_THEME} in
  "") ;;
  *)
    TMOE_ZSH_THEME="${TMOE_THEME}"
    temp_zsh_theme_env
    case_zsh_theme
    case "${TMOE_CONTAINER_AUTO_CONFIGURE}" in
    true) ;;
    *) exec zsh ;;
    esac
    ;;
  esac
}
##########
terminal_color() {
  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  BLUE=$(printf '\033[34m')
  BOLD=$(printf '\033[1m')
  RESET=$(printf '\033[m')
}
########
get_tmoe_zsh_theme_help_info() {
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
  ${BOLD}${YELLOW}COMMAND${RESET}${RESET}: ${GREEN}zshtheme${RESET} 
  ${BOLD}${YELLOW}命令${RESET}${RESET}: ${GREEN}zshtheme${RESET}
  ${BOLD}${YELLOW}Description${RESET}${RESET}: ${BLUE}This command can change the ZSH theme${RESET}.
  ${BOLD}${YELLOW}描述${RESET}${RESET}: ${BLUE}此命令能修改ZSH主题${RESET}。
  --------------
  ${YELLOW}-h${RESET}      --help 
  get-help-info 获取帮助信息
  --------------
  ${YELLOW}-n${RESET}      --no-color
  In this mode, the theme list will have no color.
  若您安装了lolcat，则主题列表将输出五彩斑斓的颜色，而${YELLOW}-n${RESET}参数将${RED}禁用${RESET}此模式。
  --------------
  ${YELLOW}-num${RESET}    --number list. This is the default mode.
  If the parameter is empty, it will enter this mode.
  It is interactive, you need to type ${GREEN}zshtheme${RESET} or ${GREEN}zshtheme -num${RESET} to start this mode first, and then type the option number,finally press ${YELLOW}Enter${RESET} key.
  序号列表模式。若参数为空，则将进入此模式。
  此模式为交互式操作，您可以先输${GREEN}zshtheme${RESET}启动,接着输入数字序号。
  --------------
  ${BOLD}${YELLOW}NOTES${RESET}${RESET} of ${GREEN}manual mode${RESET} 
  ${GREEN}手动模式${RESET}的${BOLD}${YELLOW}说明${RESET}${RESET}
  You can type ${GREEN}zshtheme${RESET} ${BLUE}\$THEME_NAME${RESET} to change the zsh theme.
  For example.01: If you type ${GREEN}zshtheme${RESET} ${BLUE}agnosterzak${RESET},then zsh theme will be changed to ${BLUE}agnosterzak${RESET}.
  02:   ${GREEN}zshtheme${RESET} ${BLUE}xiong-chiamiov-plus${RESET}
  您可以输${GREEN}zshtheme${RESET} ${BLUE}\$主题名称${RESET}来修改主题。
  例如： 输入${GREEN}zshtheme${RESET} ${BLUE}powerlevel10k${RESET}或者${GREEN}zshtheme${RESET} ${BLUE}p10k${RESET}，将主题修改为${BLUE}powerlevel10k${RESET}。
  --------------
  ${BOLD}${YELLOW}LIST OF ZSH THEMES${RESET}${RESET}:
ENDOFTMOEZSHHELP01
  ${CATCAT} <<-'ENDOFTMOEZSHHELP02'
  3den , abaykan , adben , af-magic , afowler , agnoster , agnosterzak , alanpeabody , amuse , aphrodite , apple , arrow , asciigit , aussiegeek , avit , avit-da2k , awesomepanda , bender , bira , blinks , blokkzh , bullet-train , bunnyruni , bureau , candy , candy-kingdom , chi , chill , classyTouch , clean , cloud , cordial , crcandy , crunch , cypher , dallas , darkblood , daveverwer , dieter , docker , dogenpunk , dpoggi , drofloh , dst , dstufft , ducula , duellj , eastwood , edvardm , elessar , emotty , enlightenment , essembeh , evan , fino , fino-time , fishy , fishy2 , flazz , fletcherm , fox , frisk , frontcube , funky , funkyberlin , fwalch , gallifrey , gallois , garyblessington , gentoo , geoffgarside , gianu , gitster , gnzh , gozilla , half-life , halil , haribo , hedgehog , humza , hyper-oh-my-zsh , hyperzsh , igorsilva , imajes , imp , imperator-root , intheloop , intika , itchy , jaischeema , jbergantine , jispwoso , jnrowe , jonathan , josh , jovial , jreese , jtriley , juanghurtado , junkfood , kafeitu , kardan , kayid , kennethreitz , kimwz , kinda-fishy , kiwi , kmac , kolo , kphoen , lambda , lambda-gitster , lambda-mod , lambda-v , linuxonly , lukerandall , macovsky , maran , maza , McQuen , mgutz , mh , michelebologna , mikeh , miloshadzic , minimal , minimal2 , minimal_improve , mira , mortalscumbag , mrtazz , murilasso , muse , nanotech , nebirhos , nicoulaj , node , nodeys , norm , nox , nt9 , nuts , obraun , odin , ohwonder , oxide , peepcode , philips , philthy , pi , pmcgee , powerlevel10k , punctual , pygmalion , pygmalion-virtualenv , rafiki , random , random-emoji , re5et , refined , reggae , rgm , risto , rixius , rkj , rkj-repos , robbyrussell , robbyrussell-WIP , sammy , shayan , simonoff , simple , skaro , sm , smt , sobole , Soliah , sonicradish , sorin , sporty_256 , staples , steeef , strug , sunaku , sunrise , superjarin , suvash , takashiyoshida , terminalparty , theunraveler , tjkirch , tjkirch_mod , tonotdo , traditional-plus , trapd00r , typewritten , vero , via , wedisagree , wezm , wezm+ , windows , wuffers , xiong-chiamiov , xiong-chiamiov-plus , xxf , ys , zeroastro , zeta , zhann
ENDOFTMOEZSHHELP02
}
######
tmoe_zsh_theme_env() {
  TMOE_THEME=''
  ZINIT_DIR="${HOME}/.zinit"
  ZINIT_THEME_DIR="${ZINIT_DIR}/themes/_local"
  OMZ_DIR="${ZINIT_DIR}/omz"
  OMZ_THEME_DIR="${OMZ_DIR}/themes"
  TMOE_THEME_DIR="${HOME}/.config/tmoe-zsh/git/share/themes"
  #ZSH_CUSTOM_THEME_PATH="${OMZ_DIR}/custom/themes"
  ZSHRC_FILE="${HOME}/.zshrc"
  CURRENT_DIR=$(pwd)
  #DIR=$(cd $(dirname $0);pwd;)
  P10K_URL_01="https://github.com/romkatv/powerlevel10k.git"
  P10K_URL_02="git://github.com/romkatv/powerlevel10k"
  P9K_URL_01='https://github.com/Powerlevel9k/powerlevel9k.git'
  P9K_URL_02="git://github.com/Powerlevel9k/powerlevel9k"
  COUNT=0
  ZINIT_LINE=$(cat ${ZSHRC_FILE} | egrep -n '^[^#]*source.*bin/zinit.zsh' | awk -F ':' '{print $1}' | head -n 1)
  if ! egrep -q '^[^#]*ZINIT_THEME_DIR=.*themes/_local' "${ZSHRC_FILE}"; then
    sed -i "${ZINIT_LINE} i\ZINIT_THEME_DIR=\${HOME}/.zinit/themes/_local" "${ZSHRC_FILE}"
  fi
  ZINIT_THEME_LINE=$((${ZINIT_LINE} + 3))
}
##########
temp_zsh_theme_env() {
  CHOSEN_THEME_DIR="${ZINIT_THEME_DIR}/${TMOE_ZSH_THEME}"
  CHOSEN_THEME_FILE="${CHOSEN_THEME_DIR}/${TMOE_ZSH_THEME}.zsh-theme"
  OMZ_THEME_FILE="${OMZ_THEME_DIR}/${TMOE_ZSH_THEME}.zsh-theme"
  TMOE_THEME_FILE="${TMOE_THEME_DIR}/${TMOE_ZSH_THEME}"
}
##########
del_zsh_theme_line() {
  sed -i '/^ZSH_THEME=/d' "${ZSHRC_FILE}"
  sed -i "/zinit light.*\${ZINIT_THEME_DIR}/d" "${ZSHRC_FILE}"
}
############
configure_new_zsh_theme_01() {
  #if ! egrep -q "^[^#]*zinit.*${TMOE_ZSH_THEME}" "${ZSHRC_FILE}"; then; fi
  del_zsh_theme_line
  sed -i "${ZINIT_THEME_LINE} a\zinit light \${ZINIT_THEME_DIR}/${TMOE_ZSH_THEME}" "${ZSHRC_FILE}"
}
###########
rm_zsh_git_theme_dir() {
  rm -rv "${CHOSEN_THEME_DIR}" 2>/dev/null
  mkdir -p "${ZINIT_THEME_DIR}"
}
###########
configure_p9k() {
  #p9k已经停止维护
  if [ ! -e "${CHOSEN_THEME_DIR}/.git" ]; then
    rm_zsh_git_theme_dir
    git clone --depth=1 ${P9K_URL_01} "${CHOSEN_THEME_DIR}" || git clone --depth=1 ${P9K_URL_02} "${CHOSEN_THEME_DIR}"
  fi
  configure_new_zsh_theme_01
}
##########
configure_p10k() {
  echo "You can type ${GREEN}p10k configure${RESET} to configure ${BLUE}powerlevel 10k${RESET}."
  echo "输${GREEN}p10k configure${RESET}配置powerlevel 10k${RESET}"
  if [ ! -e "${CHOSEN_THEME_DIR}/.git" ]; then
    rm_zsh_git_theme_dir
    echo "若无法弹出powerlevel 10k配置面板，则请拉宽屏幕显示大小，然后输${GREEN}p10k configure${RESET}"
    git clone ${P10K_URL_01} "${CHOSEN_THEME_DIR}" --depth=1 || git clone ${P10K_URL_02} "${CHOSEN_THEME_DIR}" --depth=1
  else
    cd "${CHOSEN_THEME_DIR}"
    git reset --hard
    git pull --depth=1
    cd ${CURRENT_DIR}
  fi
  P10K_CONFIG_FILE="${HOME}/.p10k.zsh"
  if [ ! -e "${P10K_CONFIG_FILE}" ]; then
    curl -Lo ${P10K_CONFIG_FILE} 'https://gitee.com/ak2/p10k_config/raw/master/.p10k.zsh'
    chmod a+r ${P10K_CONFIG_FILE}
  fi

  if ! grep -q '.p10k.zsh' "${HOME}/.zshrc"; then
    cat >>${HOME}/.zshrc <<-"ENDOFPOWERLEVEL"
		[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh 
		ENDOFPOWERLEVEL
  fi
  configure_new_zsh_theme_01
}
#############
copy_tmoe_zsh_theme() {
  if [ ! -e "${CHOSEN_THEME_FILE}" ]; then
    mkdir -p "${CHOSEN_THEME_DIR}"
    if [ -e "${OMZ_THEME_FILE}" ]; then
      ln -sv "${OMZ_THEME_FILE}" ${CHOSEN_THEME_FILE}
    else
      ln -sv ${TMOE_THEME_FILE} ${CHOSEN_THEME_FILE}
    fi
  fi
  configure_new_zsh_theme_01
}
###########
case_zsh_theme() {
  temp_zsh_theme_env
  case "${TMOE_ZSH_THEME}" in
  powerlevel9k) configure_p9k ;;
  powerlevel10k) configure_p10k ;;
  *) copy_tmoe_zsh_theme ;;
  esac
}
##########
choose_zsh_theme() {
  echo -e "The default theme is xiong-chiamiov-plus.\nYou can choose another one from the list below"
  echo "您可以在${BLUE}此列表${RESET}中选择${YELLOW}zsh主题${RESET}。"
  for ZSH_THEME_FILE in "${TMOE_THEME_DIR}"/*; do
    ZSH_THEME_NAME[COUNT]=$(echo ${ZSH_THEME_FILE} | awk -F '/' '{print $NF}')
    echo -e "(${COUNT}) ${ZSH_THEME_NAME[COUNT]}"
    COUNT=$((${COUNT} + 1))
  done
  COUNT=$((${COUNT} - 1))
  ###############
  while true; do
    read -p "请输入${GREEN}选项数字${RESET},并按${BLUE}回车键${RESET},留空不更改。Please type the ${GREEN}option number${RESET} and press ${BLUE}Enter${RESET}:" ZSH_THEME_NUMBER
    if [[ -z "${ZSH_THEME_NUMBER}" ]]; then
      break
    elif ! [[ ${ZSH_THEME_NUMBER} =~ ^[0-9]+$ ]]; then
      echo "Please type the right number!"
    elif ((${ZSH_THEME_NUMBER} >= 0 && ${ZSH_THEME_NUMBER} <= ${COUNT})); then
      eval TMOE_ZSH_THEME=${ZSH_THEME_NAME[ZSH_THEME_NUMBER]}
      temp_zsh_theme_env
      case_zsh_theme
      ##############
      break
    else
      echo -e "If it does not take effect, please ${YELLOW}restart${RESET} the terminal app.\n若修改完成后${RED}未生效${RESET}，则建议您${YELLOW}重启终端${RESET}。"
    fi
  done
  #source "${ZSHRC_FILE}" 2>/dev/null
  case "$(uname -o)" in
  Android) chsh -s zsh ;;
  esac
  cat <<-ENDOFTMOEZSHHELP03
  输${YELLOW}zshtheme h${RESET}来获取${BLUE}zsh主题帮助信息${RESET}。
  You can type ${GREEN}zshtheme h${RESET} to get the ${BLUE}zsh theme help info${RESET}.
ENDOFTMOEZSHHELP03
  #您可以输${YELLOW}zshtheme${RESET}来更改${BLUE}主题${RESET}
  #You can type ${GREEN}zshtheme${RESET} to change the ${BLUE}theme${RESET}.
  exec zsh
}
##############
tmoe_theme_main "$@"
