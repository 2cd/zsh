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
  p9k | powerlevel9k) TMOE_THEME=powerlevel9k ;;
  p10k | -p10k | powerlevel10k) TMOE_THEME=powerlevel10k ;;
  3den | abaykan | adben | af-magic | afowler | agkozak | agnoster | agnosterzak | alanpeabody | alien | alien-minimal | amuse | antsy | aphrodite | apple | arrow | asciigit | aussiegeek | avit | avit-da2k | awesomepanda | bender | bira | blinks | blokkzh | bullet-train | bunnyruni | bureau | candy | candy-kingdom | chi | chill | ciacho | classytouch | clean | cloud | color-input | color-input-line | cordial | crcandy | crunch | cypher | daivasmara | dallas | darkblood | daveverwer | dieter | docker-zsh | dogenpunk | dpoggi | dpoggi-newline-timestamp | drofloh | dst | dstufft | ducula | duellj | eastwood | edvardm | elessar | emotty | enlightenment | essembeh | evan | fino | fino-time | 'fishbone++' | fishy | fishy2 | flazz | fletcherm | fox | frisk | frontcube | funky | funkyberlin | fwalch | gallifrey | gallois | garyblessington | gentoo | geoffgarside | geometry | gianu | gitstatus | gitster | gnzh | gozilla | half-life | halil | haribo | hedgehog | hub | humza | hyper-oh-my-zsh | hyperzsh | igeek | igorsilva | imajes | imp | imperator | intheloop | intika | itchy | jaischeema | jbergantine | jispwoso | jnrowe | jonathan | josh | jovial | jreese | jtriley | juanghurtado | junkfood | kafeitu | kardan | kayid | kennethreitz | kimwz | kinda-fishy | kiwi | kmac | kolo | kphoen | lambda | lambda-gitster | lambda-mod | lambda-v | linuxonly | lukerandall | macovsky | maran | matte-black-yellow | matte-black-yellow-line | maza | mcquen | mgutz | mh | michelebologna | mikeh | miloshadzic | minimal | minimal-improved | minimal2 | mira | mlh | mortalscumbag | mrtazz | murilasso | muse | nanotech | nebirhos | nicoulaj | node | nodeys | norm | nothing | nt9 | nuts | obraun | odin | oh-wonder | omega | oxide | passion | peepcode | philips | philthy | pi | pmcgee | powerlevel10k | punctual | pure | pygmalion | pygmalion-virtualenv | rafiki-zsh | random | random-emoji | re5et | refined | reggae | retro-term | rgm | risto | rixius | rkj | rkj-repos | robbyrussell | robbyrussell-wip | sammy | schminitz | shayan | short | simonoff | simple | skaro | sm | smt | sobole | Soliah | solus | sonicradish | sorin | spaceship-zsh | sporty_256 | staples | steeef | strug | sunaku | sunrise | superjarin | suvash | takashiyoshida | terminalparty | theta | theunraveler | tjkirch | tjkirch_mod | tonotdo | traditional-plus | trapd00r | typewritten | vero | via | wedisagree | wezm | wezm+ | windows-cmd | wuffers | xiong-chiamiov | xiong-chiamiov-plus | xxf | ys | zeroastro | zeta | zhann | zsh2000 | λpure) TMOE_THEME="$1" ;;
  *) printf "%s\n" "Unknown parameter,you can type ${GREEN}zshtheme h${RESET} to get help information.If you find a bug, please submit an issue to the git-repo of ${BLUE}tmoe-zsh${RESET}." ;;
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
    部分主题需要联网下载。
    Some themes need to be downloaded.
    The following themes use git to clone their repo:
    以下主题使用git克隆整个仓库：
    powerlevel10k | pure | via | aphrodite | typewritten | abaykan | agkozak | agnosterzak | alien | alien-minimal | antsy | asciigit | avit-da2k | bender | blokkzh | bullet-train | bunnyruni | chi | chill | ciacho | classytouch | cordial | daivasmara | docker-zsh | drofloh | ducula | elessar | enlightenment | fishbone++ | fishy2 | funkyberlin | geometry | gitstatus | halil | haribo | hyper-oh-my-zsh | hyperzsh | igeek | igorsilva | imp | jovial | kimwz | kinda-fishy | lambda-mod | lambda-v | maza | minimal-improved | node | nodeys | nothing | nt9 | nuts | odin | omega | oxide | pi | punctual | rafiki-zsh | robbyrussell-wip | shayan | sm | sobole | spaceship-zsh | staples | theta | traditional-plus | vero | windows-cmd | zeroastro | zeta | zsh2000 | λpure
  
  以下主题使用了CDN进行下载加速：
  The following themes use jsdelivr CDN for download acceleration：
  color-input | color-input-line | dpoggi-newline-timestamp | gitster | imperator | intika | kayid | kmac | matte-black-yellow | matte-black-yellow-line | minimal2 | passion | retro-term | short

  以下主题托管于github gist,下载无加速：
  xxf | solus | schminitz | reggae | random-emoji | philthy | oh-wonder | hedgehog | hub | mcquen 
  --------------
  ${BOLD}${YELLOW}NOTES${RESET}${RESET} of ${GREEN}manual mode${RESET} 
  ${GREEN}手动模式${RESET}的${BOLD}${YELLOW}说明${RESET}${RESET}
  You can type ${GREEN}zshtheme${RESET} ${BLUE}\$THEME_NAME${RESET} to change the zsh theme.
  In the process of typing zsh, you can press TAB to  complete.
  For example.01: If you type ${GREEN}zshtheme${RESET} ${BLUE}agnosterzak${RESET},then zsh theme will be changed to ${BLUE}agnosterzak${RESET}.
  02:   ${GREEN}zshtheme${RESET} ${BLUE}xiong-chiamiov-plus${RESET}
  
  您可以输${GREEN}zshtheme${RESET} ${BLUE}\$主题名称${RESET}来修改主题。
  在输入zshtheme的过程中，按下TAB键进行补全，按多次TAB键列出参数列表。
  例如： 输入${GREEN}zshtheme${RESET} ${BLUE}powerlevel10k${RESET}或者${GREEN}zshtheme${RESET} ${BLUE}p10k${RESET}，将主题修改为${BLUE}powerlevel10k${RESET}。
  --------------
  ${BOLD}${YELLOW}LIST OF ZSH THEMES${RESET}${RESET}:
ENDOFTMOEZSHHELP01
  ${CATCAT} <<-'ENDOFTMOEZSHHELP02'
3den , abaykan , adben , af-magic , afowler , agkozak , agnoster , agnosterzak , alanpeabody , alien , alien-minimal , amuse , antsy , aphrodite , apple , arrow , asciigit , aussiegeek , avit , avit-da2k , awesomepanda , bender , bira , blinks , blokkzh , bullet-train , bunnyruni , bureau , candy , candy-kingdom , chi , chill , ciacho , classytouch , clean , cloud , color-input , color-input-line , cordial , crcandy , crunch , cypher , daivasmara , dallas , darkblood , daveverwer , dieter , docker-zsh , dogenpunk , dpoggi , dpoggi-newline-timestamp , drofloh , dst , dstufft , ducula , duellj , eastwood , edvardm , elessar , emotty , enlightenment , essembeh , evan , fino , fino-time , fishbone++ , fishy , fishy2 , flazz , fletcherm , fox , frisk , frontcube , funky , funkyberlin , fwalch , gallifrey , gallois , garyblessington , gentoo , geoffgarside , geometry , gianu , gitstatus , gitster , gnzh , gozilla , half-life , halil , haribo , hedgehog , hub , humza , hyper-oh-my-zsh , hyperzsh , igeek , igorsilva , imajes , imp , imperator , intheloop , intika , itchy , jaischeema , jbergantine , jispwoso , jnrowe , jonathan , josh , jovial , jreese , jtriley , juanghurtado , junkfood , kafeitu , kardan , kayid , kennethreitz , kimwz , kinda-fishy , kiwi , kmac , kolo , kphoen , lambda , lambda-gitster , lambda-mod , lambda-v , linuxonly , lukerandall , macovsky , maran , matte-black-yellow , matte-black-yellow-line , maza , mcquen , mgutz , mh , michelebologna , mikeh , miloshadzic , minimal , minimal-improved , minimal2 , mira , mlh , mortalscumbag , mrtazz , murilasso , muse , nanotech , nebirhos , nicoulaj , node , nodeys , norm , nothing , nt9 , nuts , obraun , odin , oh-wonder , omega , oxide , passion , peepcode , philips , philthy , pi , pmcgee , powerlevel10k , punctual , pure , pygmalion , pygmalion-virtualenv , rafiki-zsh , random-emoji , re5et , refined , reggae , retro-term , rgm , risto , rixius , rkj , rkj-repos , robbyrussell , robbyrussell-wip , sammy , schminitz , shayan , short , simonoff , simple , skaro , sm , smt , sobole , Soliah , solus , sonicradish , sorin , spaceship-zsh , sporty_256 , staples , steeef , strug , sunaku , sunrise , superjarin , suvash , takashiyoshida , terminalparty , theta , theunraveler , tjkirch , tjkirch_mod , tonotdo , traditional-plus , trapd00r , typewritten , vero , via , wedisagree , wezm , wezm+ , windows-cmd , wuffers , xiong-chiamiov , xiong-chiamiov-plus , xxf , ys , zeroastro , zeta , zhann , zsh2000 , λpure
ENDOFTMOEZSHHELP02
  cat <<-ENDOFTMOEZSHHELP03
  ${BOLD}${YELLOW}小技巧${RESET}${RESET}:
  ${BOLD}${YELLOW}TIPS OF TMOE ZSH THEME MANAGER${RESET}${RESET}
  在ZSH环境下,输${YELLOW}zsht${RESET},不按回车,按一次TAB键${BLUE}⇄${RESET}补全为${GREEN}zshtheme${RESET}，再按一次切换为${BLUE}手动模式${RESET}，在该模式下支持搜索主题名称。
  Type ${GREEN}zsht${RESET}, then don't press ${RED}enter${RESET}, press Tab${BLUE}⇄${RESET} key twice to use ${GREEN}manual mode${RESET}.
  --------------
ENDOFTMOEZSHHELP03
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
  #此处请保持$ZINIT_THEME_DIR
  sed -i "${ZINIT_THEME_LINE} a\zinit light \${ZINIT_THEME_DIR}/${TMOE_ZSH_THEME}" "${ZSHRC_FILE}"
}
###########
rm_zsh_git_theme_dir() {
  rm -rv "${CHOSEN_THEME_DIR}" 2>/dev/null
  mkdir -p "${ZINIT_THEME_DIR}"
}
###########
check_catcat() {
  CATCAT=''
  for i in bat batcat; do
    if [[ $(command -v ${i}) ]]; then
      CATCAT="${i}"
    fi
  done
  unset i
}
###########
cat_zsh_theme_readme_md() {
  check_catcat
  case ${CATCAT} in
  "") cat ${TMOE_THEME_FILE}/README_min.md ;;
  *) cat ${TMOE_THEME_FILE}/README_min.md | head -n 16 | ${CATCAT} -l markdown --pager "less -m -RFeQ" ;;
  esac
}
############
cat_zsh_theme_readme_full_md() {
  check_catcat
  case ${CATCAT} in
  "") cat ${CHOSEN_THEME_DIR}/README.md ;;
  *) ${CATCAT} ${CHOSEN_THEME_DIR}/README.md -l markdown --pager "less -m -RFeQ" ;;
  esac
}
############
check_readme_file() {
  if [ -e "${CHOSEN_THEME_DIR}/README.md" ]; then
    README_LINE_NUM=$(wc -l "${CHOSEN_THEME_DIR}/README.md" | awk '{print $1}')
    cat_zsh_theme_readme_full_md
  elif [ -e "${TMOE_THEME_FILE}/README_min.md" ]; then
    cat_zsh_theme_readme_md
  fi
}
##########
configure_p9k() {
  #p9k已经停止维护
  check_readme_file
  if [ ! -e "${CHOSEN_THEME_DIR}/.git" ]; then
    rm_zsh_git_theme_dir
    git clone --depth=1 ${P9K_URL_01} "${CHOSEN_THEME_DIR}" || git clone --depth=1 ${P9K_URL_02} "${CHOSEN_THEME_DIR}"
  fi
  configure_new_zsh_theme_01
}
##########
git_pull_zsh_theme() {
  cd "${CHOSEN_THEME_DIR}"
  git reset --hard
  git pull --rebase --stat --depth=1 || git rebase --skip
  cd ${CURRENT_DIR}
}
########
configure_p10k() {
  printf "%s\n" "${YELLOW}${P10K_URL_02}${RESET}"
  printf "%s\n" "${BLUE}${CHOSEN_THEME_DIR}${RESET}"
  printf "%s\n" "You can type ${GREEN}p10k configure${RESET} to configure ${BLUE}powerlevel 10k${RESET}."
  printf "%s\n" "输${GREEN}p10k configure${RESET}配置powerlevel 10k${RESET}"
  if [ ! -e "${CHOSEN_THEME_DIR}/.git" ]; then
    cat_zsh_theme_readme_md
    rm_zsh_git_theme_dir
    printf "%s\n" "若无法弹出powerlevel 10k配置面板，则请拉宽屏幕显示大小，然后输${GREEN}p10k configure${RESET}"
    git clone ${P10K_URL_01} "${CHOSEN_THEME_DIR}" --depth=1 || git clone ${P10K_URL_02} "${CHOSEN_THEME_DIR}" --depth=1
    configure_new_zsh_theme_01
  else
    git_pull_zsh_theme
    configure_new_zsh_theme_01
    check_readme_file
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
}
#############
echo_git_repo_url() {
  ZSH_THEME_URL_01=$(cat ${TMOE_THEME_FILE}/git-repo.txt | head -n 1)
  printf "%s\n" "${YELLOW}${ZSH_THEME_URL_01}${RESET}"
}
############
git_clone_zsh_theme_model_01() {
  echo_git_repo_url
  printf "%s\n" "${BLUE}${CHOSEN_THEME_DIR}${RESET}"
  if [ ! -e "${CHOSEN_THEME_DIR}/.git" ]; then
    cat_zsh_theme_readme_md
    rm_zsh_git_theme_dir
    git clone ${ZSH_THEME_URL_01} "${CHOSEN_THEME_DIR}" --depth=1
    configure_new_zsh_theme_01
  else
    git_pull_zsh_theme
    configure_new_zsh_theme_01
    check_readme_file
  fi
  chmod -R a+r ${CHOSEN_THEME_DIR}
}
##########
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
curl_new_zsh_theme_from_git_cdn() {
  echo_git_repo_url
  GIT_THEME_CDN_URL=$(cat ${TMOE_THEME_FILE}/git-cdn.txt | head -n 1)
  if [ ! -s "${CHOSEN_THEME_FILE}" ]; then
    cat_zsh_theme_readme_md
    mkdir -p "${CHOSEN_THEME_DIR}"
    cd "${CHOSEN_THEME_DIR}"
    if [ $(command -v aria2c) ]; then
      aria2c --allow-overwrite=true -o ${TMOE_ZSH_THEME}.zsh-theme ${GIT_THEME_CDN_URL}
    elif [ $(command -v curl) ]; then
      curl -L -o ${TMOE_ZSH_THEME}.zsh-theme ${GIT_THEME_CDN_URL}
    elif [ $(command -v wget) ]; then
      wget -O ${TMOE_ZSH_THEME}.zsh-theme ${GIT_THEME_CDN_URL}
    else
      printf "%s\n" "Can not download this file.Please download manually."
    fi
  else
    check_readme_file
  fi
  chmod a+r ${CHOSEN_THEME_FILE}
  cd ${CURRENT_DIR}
  configure_new_zsh_theme_01
}
###########
case_zsh_theme() {
  temp_zsh_theme_env
  case "${TMOE_ZSH_THEME}" in
  powerlevel9k) configure_p9k ;;
  powerlevel10k) configure_p10k ;;
  pure | via | aphrodite | typewritten)
    #ZSH_THEME_URL_01='https://github.com/sindresorhus/pure.git'
    #ZSH_THEME_URL_01='https://github.com/badouralix/oh-my-via.git'
    git_clone_zsh_theme_model_01
    ;;
  xxf | solus | schminitz | reggae | random-emoji | philthy | hedgehog | hub | mcquen | color-input | color-input-line | dpoggi-newline-timestamp | gitster | imperator | intika | kayid | kmac | matte-black-yellow | matte-black-yellow-line | minimal2 | passion | retro-term | short)
    curl_new_zsh_theme_from_git_cdn
    ;;
  abaykan | agkozak | agnosterzak | alien | alien-minimal | antsy | asciigit | avit-da2k | bender | blokkzh | bullet-train | bunnyruni | chi | chill | ciacho | classytouch | cordial | daivasmara | docker-zsh | drofloh | ducula | elessar | enlightenment | fishbone++ | fishy2 | funkyberlin | geometry | gitstatus | halil | haribo | hyper-oh-my-zsh | hyperzsh | igeek | igorsilva | imp | jovial | kimwz | kinda-fishy | lambda-mod | lambda-v | maza | minimal-improved | node | nodeys | nothing | nt9 | nuts | odin | omega | oxide | pi | punctual | rafiki-zsh | robbyrussell-wip | shayan | sm | sobole | spaceship-zsh | staples | theta | traditional-plus | vero | windows-cmd | zeroastro | zeta | zsh2000 | λpure)
    git_clone_zsh_theme_model_01
    ;;
  *) copy_tmoe_zsh_theme ;;
  esac
}
##########
select_termux_color() {
  cat <<-ENDOFTMOEZSHHELP03
	ENDOFTMOEZSHHELP03
  PS3="请输入${YELLOW}选项数字${RESET},并按${BLUE}回车键${RESET}。\
  Please type the ${GREEN}option number${RESET} and press ${BLUE}Enter${RESET}${YELLOW}[1-238]:${RESET}"
  select TMOE_ZSH_THEME in "3den" "abaykan" "adben" "af-magic" "afowler" "agkozak" "agnoster" "agnosterzak" "alanpeabody" "alien" "alien-minimal" "amuse" "antsy" "aphrodite" "apple" "arrow" "asciigit" "aussiegeek" "avit" "avit-da2k" "awesomepanda" "bender" "bira" "blinks" "blokkzh" "bullet-train" "bunnyruni" "bureau" "candy" "candy-kingdom" "chi" "chill" "ciacho" "classytouch" "clean" "cloud" "color-input" "color-input-line" "cordial" "crcandy" "crunch" "cypher" "daivasmara" "dallas" "darkblood" "daveverwer" "dieter" "docker-zsh" "dogenpunk" "dpoggi" "dpoggi-newline-timestamp" "drofloh" "dst" "dstufft" "ducula" "duellj" "eastwood" "edvardm" "elessar" "emotty" "enlightenment" "essembeh" "evan" "fino" "fino-time" "fishbone++" "fishy" "fishy2" "flazz" "fletcherm" "fox" "frisk" "frontcube" "funky" "funkyberlin" "fwalch" "gallifrey" "gallois" "garyblessington" "gentoo" "geoffgarside" "geometry" "gianu" "gitstatus" "gitster" "gnzh" "gozilla" "half-life" "halil" "haribo" "hedgehog" "hub" "humza" "hyper-oh-my-zsh" "hyperzsh" "igeek" "igorsilva" "imajes" "imp" "imperator" "intheloop" "intika" "itchy" "jaischeema" "jbergantine" "jispwoso" "jnrowe" "jonathan" "josh" "jovial" "jreese" "jtriley" "juanghurtado" "junkfood" "kafeitu" "kardan" "kayid" "kennethreitz" "kimwz" "kinda-fishy" "kiwi" "kmac" "kolo" "kphoen" "lambda" "lambda-gitster" "lambda-mod" "lambda-v" "linuxonly" "lukerandall" "macovsky" "maran" "matte-black-yellow" "matte-black-yellow-line" "maza" "mcquen" "mgutz" "mh" "michelebologna" "mikeh" "miloshadzic" "minimal" "minimal-improved" "minimal2" "mira" "mlh" "mortalscumbag" "mrtazz" "murilasso" "muse" "nanotech" "nebirhos" "nicoulaj" "node" "nodeys" "norm" "nothing" "nt9" "nuts" "obraun" "odin" "oh-wonder" "omega" "oxide" "passion" "peepcode" "philips" "philthy" "pi" "pmcgee" "powerlevel10k" "punctual" "pure" "pygmalion" "pygmalion-virtualenv" "rafiki-zsh" "random" "random-emoji" "re5et" "refined" "reggae" "retro-term" "rgm" "risto" "rixius" "rkj" "rkj-repos" "robbyrussell" "robbyrussell-wip" "sammy" "schminitz" "shayan" "short" "simonoff" "simple" "skaro" "sm" "smt" "sobole" "Soliah" "solus" "sonicradish" "sorin" "spaceship-zsh" "sporty_256" "staples" "steeef" "strug" "sunaku" "sunrise" "superjarin" "suvash" "takashiyoshida" "terminalparty" "theta" "theunraveler" "tjkirch" "tjkirch_mod" "tonotdo" "traditional-plus" "trapd00r" "typewritten" "vero" "via" "wedisagree" "wezm" "wezm+" "windows-cmd" "wuffers" "xiong-chiamiov" "xiong-chiamiov-plus" "xxf" "ys" "zeroastro" "zeta" "zhann" "zsh2000" "λpure" 'skip跳过'; do
    case ${TMOE_ZSH_THEME} in
    'skip跳过')
      break
      ;;
    powerlevel10k | powerlevel9k | 3den | abaykan | adben | af-magic | afowler | agkozak | agnoster | agnosterzak | alanpeabody | alien | alien-minimal | amuse | antsy | aphrodite | apple | arrow | asciigit | aussiegeek | avit | avit-da2k | awesomepanda | bender | bira | blinks | blokkzh | bullet-train | bunnyruni | bureau | candy | candy-kingdom | chi | chill | ciacho | classytouch | clean | cloud | color-input | color-input-line | cordial | crcandy | crunch | cypher | daivasmara | dallas | darkblood | daveverwer | dieter | docker-zsh | dogenpunk | dpoggi | dpoggi-newline-timestamp | drofloh | dst | dstufft | ducula | duellj | eastwood | edvardm | elessar | emotty | enlightenment | essembeh | evan | fino | fino-time | 'fishbone++' | fishy | fishy2 | flazz | fletcherm | fox | frisk | frontcube | funky | funkyberlin | fwalch | gallifrey | gallois | garyblessington | gentoo | geoffgarside | geometry | gianu | gitstatus | gitster | gnzh | gozilla | half-life | halil | haribo | hedgehog | hub | humza | hyper-oh-my-zsh | hyperzsh | igeek | igorsilva | imajes | imp | imperator | intheloop | intika | itchy | jaischeema | jbergantine | jispwoso | jnrowe | jonathan | josh | jovial | jreese | jtriley | juanghurtado | junkfood | kafeitu | kardan | kayid | kennethreitz | kimwz | kinda-fishy | kiwi | kmac | kolo | kphoen | lambda | lambda-gitster | lambda-mod | lambda-v | linuxonly | lukerandall | macovsky | maran | matte-black-yellow | matte-black-yellow-line | maza | mcquen | mgutz | mh | michelebologna | mikeh | miloshadzic | minimal | minimal-improved | minimal2 | mira | mlh | mortalscumbag | mrtazz | murilasso | muse | nanotech | nebirhos | nicoulaj | node | nodeys | norm | nothing | nt9 | nuts | obraun | odin | oh-wonder | omega | oxide | passion | peepcode | philips | philthy | pi | pmcgee | powerlevel10k | punctual | pure | pygmalion | pygmalion-virtualenv | rafiki-zsh | random | random-emoji | re5et | refined | reggae | retro-term | rgm | risto | rixius | rkj | rkj-repos | robbyrussell | robbyrussell-wip | sammy | schminitz | shayan | short | simonoff | simple | skaro | sm | smt | sobole | Soliah | solus | sonicradish | sorin | spaceship-zsh | sporty_256 | staples | steeef | strug | sunaku | sunrise | superjarin | suvash | takashiyoshida | terminalparty | theta | theunraveler | tjkirch | tjkirch_mod | tonotdo | traditional-plus | trapd00r | typewritten | vero | via | wedisagree | wezm | wezm+ | windows-cmd | wuffers | xiong-chiamiov | xiong-chiamiov-plus | xxf | ys | zeroastro | zeta | zhann | zsh2000 | λpure)
      printf "%s\n" "${BLUE}${TMOE_ZSH_THEME}${RESET}"
      temp_zsh_theme_env
      case_zsh_theme
      exec zsh
      break
      ;;
    *)
      echo ${BOLD}--------------${RESET}
      printf "%s\n" "Please ${BLUE}type${RESET} the right ${BOLD}${RED}pure number${RESET}${RESET}!"
      printf "%s\n" "请${BLUE}输入${RESET}正确的${BOLD}${RED}纯数字${RESET}${RESET}!"
      ;;
    esac
  done
}
#########
#echo -e "If it does not take effect, please ${YELLOW}restart${RESET} the terminal app.\n若修改完成后${RED}未生效${RESET}，则建议您${YELLOW}重启终端${RESET}。"
choose_zsh_theme() {
  echo -e "The default theme is xiong-chiamiov-plus.\nYou can choose another one from the list below"
  printf "%s\n" "您可以在${BLUE}此列表${RESET}中选择${YELLOW}zsh主题${RESET}。"
  select_termux_color
  #source "${ZSHRC_FILE}" 2>/dev/null
  case "$(uname -o)" in
  Android) chsh -s zsh ;;
  esac
  #您可以输${YELLOW}zshtheme${RESET}来更改${BLUE}主题${RESET}
  #You can type ${GREEN}zshtheme${RESET} to change the ${BLUE}theme${RESET}.
}
##############
tmoe_theme_main "$@"
#gist:Mcquen
#失效：rainbow-theme
#pure主题非omz extra-theme
