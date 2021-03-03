# Tmoe-zsh 介绍 Introduction

```bash
. <(curl -L git.io/zsh.sh)
```

> **Easily configure zsh themes and plugins for GNU/Linux and Android-Termux**

## Preview

You can press TAB key to complete.
![zshtheme completion](https://images.gitee.com/uploads/images/2020/0929/185820_e054932c_7793225.gif)

### Screenshot

![Capture__2020-03-24-17-29-552.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/3luF9hHGPnPuhwHu.png)

![Snipaste_2020-03-24_17-12-57.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/YsZou4mIXZUFUYdZ.png)

### 200 多种主题 You can choose more than 200 zsh themes

![Snipaste_2020-03-24_17-34-37.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/ZSIBFuC1v3AKcTFX.png)

### 100 多种配色 More than 100 color schemes

![Snipaste_2020-03-24_17-16-22.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/3JQSGux51j6Fj5cp.png)

### 近 50 种字体 Nearly 50 fonts

![Snipaste_2020-03-24_17-20-59.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/K9PweO1nbWok8XUh.png)

### Interface preview screenshot

![86K2M8.png](https://s1.ax1x.com/2020/03/20/86K2M8.png)
![Capture__2020-03-24-17-41-46.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/hSQuBsUxPRbjSgUM.png)

Based on [zinit](https://github.com/zdharma/zinit), use "Turbo Mode" to delay loading plugins.

2020-03-19 ：

Added support for more GNU/Linux distributions.

2020-03-24 ：  
Support Gentoo/Funtoo

2020-08-13:
Supports management of about 283 plugins.

2020-09: Refactored code, not compatible with the old version.
You can execute the following command to delete the old version.

```shell
ZSHRC_FILE="${HOME}/.zshrc"
TMOE_ZSH_GIT_DIR="${HOME}/.config/tmoe-zsh/git"
rm -rv "${TMOE_ZSH_GIT_DIR}" "$(command -v zsh-i)"
mv "${ZSHRC_FILE}" "${ZSHRC_FILE}_$(date +%Y%m%d).bak"
```

## 2. Installation

### 2-1.Install using script

1.Android-[Termux](https://termux.com/)

```shell
    . <(curl -L git.io/zsh.sh)
```

如果您居住在中国内地，那么可以使用 gitee 仓库。

```shell
    bash -c "$(curl -L gitee.com/mo2/zsh/raw/2/2)"
```

2.Debian/Ubuntu/Mint/Kali

```shell
    sudo apt update
    sudo apt install -y curl
    bash <(curl -L git.io/zsh.sh)
```

3.RedHat/Fedora/CentOS

```shell
    sudo dnf install -y curl || sudo yum install -y curl
    bash -c "$(curl -L git.io/zsh.sh)"
```

4.Arch/Manjaro

```shell
    [[ $(command -v curl) ]] || sudo pacman -Syu curl
    bash -c "$(curl -L git.io/zsh.sh)"
```

5.~~OpenWRT/Entware~~

> 202009:No longer supports routers.

```shell
    opkg update
    opkg install libustream-openssl ca-bundle ca-certificates wget bash
    bash -c "$(wget --no-check-certificate -qO- git.io/zsh.sh)"
```

6.Alpine/iOS-[iSH](https://ish.app/)

```shell
    sudo apk add wget bash
    wget -O /tmp/.tmoe-zsh git.io/zsh.sh
    bash /tmp/.tmoe-zsh
```

7.Void

```shell
    sudo xbps-install -Sy wget
    bash -c "$(wget -qO- git.io/zsh.sh)"
```

8.Gentoo/Funtoo

```shell
    emerge -avk net-misc/wget
    bash -c "$(wget -qO- git.io/zsh.sh)"
```

9.OpenSUSE

```bash
    sudo zypper in curl
     bash -c "$(curl -L git.io/zsh.sh)"
```

10.Solus

```bash
    sudo eopkg install wget
    bash -c "$(wget -qO- gitee.com/mo2/zsh/raw/2/2)"
```

11.No other systems tested.  
For example:**GuixSD**,etc.  
I think you can resolve dependencies yourself.  
The relevant dependencies are `zsh git pv wget tar xz newt(whiptail)`  
If you are using Unix, then configure it manually.  
>Unix system,such as：**MacOS、FreeBSD、OpenBSD、NetBSD** and **SunOS**.  

### 2-2.MANUALLY GIT CLONE

```bash
TMOE_ZSH_DIR="${HOME}/.config/tmoe-zsh"
TMOE_ZSH_GIT_DIR="${TMOE_ZSH_DIR}/git"
TMOE_ZSH_GIT_REPO='https://github.com/2moe/tmoe-zsh'
mkdir -p ${TMOE_ZSH_DIR}
git clone --depth=1 "${TMOE_ZSH_GIT_REPO}" "${TMOE_ZSH_GIT_DIR}"
bash ${TMOE_ZSH_GIT_DIR}/zsh.sh
```

### 2-3.MANUALLY CONFIGURE 手动配置

#### MacOS

If you are using MacOS, then install **homebrew** before configuration.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

如果您使用的是苹果MacOS，那么请在配置前先安装 **homebrew**  
您可以通过[BFSU镜像站](https://mirrors.bfsu.edu.cn/help/homebrew/)或者[TUNA镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)来安装 **homebrew**  

```bash
if ! egrep -q '^[^#]*ex.*HOMEBREW_BREW_GIT_REMOTE=' ~/.zprofile;then
    cat >>~/.zprofile<<-'EOF'
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.bfsu.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.bfsu.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.bfsu.edu.cn/homebrew-bottles"
EOF
fi
/bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/Homebrew/install@master/install.sh | sed -E 's#^(\s*)(HOMEBREW_(BREW|CORE)_GIT_REMOTE)=(.*)$#\1\2="${\2:-\4}"#')"
```

如果您正在使用Apple M1或其他Apple arm64 cpu的mac设备，那么请将 **/opt/homebrew/bin** 加入到环境变量中。  
If you are using Apple Silicon arm64 CPU, then you should add `brew` to your PATH.  

```bash
grep -qF '/opt/homebrew/bin' /etc/paths || sudo sed -i "" '1i \
/opt/homebrew/bin
' /etc/paths
```

##### install dependencies

```shell
for i in bat binutils exa fzf gawk gsed pv newt wget xz;do
    brew install ${i}
done
```

##### git clone some repos

```shell
TMOE_ZSH_DIR=${HOME}/.config/tmoe-zsh
ZINIT_DIR=${HOME}/.zinit

mkdir -pv ${TMOE_ZSH_DIR} ${ZINIT_DIR}/plugins ${ZINIT_DIR}/themes/_local
git clone --depth=1 git://github.com/2moe/tmoe-zsh ${TMOE_ZSH_DIR}/git
git clone --depth=1 git://github.com/zdharma/zinit ${ZINIT_DIR}/bin
git clone --depth=1 git://github.com/ohmyzsh/ohmyzsh ${ZINIT_DIR}/omz
git clone --depth=1 git://github.com/Aloxaf/fzf-tab "${ZINIT_DIR}/plugins/_local---fzf-tab"
git clone --depth=1 git://github.com/zdharma/fast-syntax-highlighting "${ZINIT_DIR}/plugins/_local---fast-syntax-highlighting"
git clone --depth=1 git://github.com/zsh-users/zsh-autosuggestions "${ZINIT_DIR}/plugins/_local---zsh-autosuggestions"
    
cd ${ZINIT_DIR}/omz/plugins
for i in $(ls ${PWD}); do
    if [[ -d "${i}" && ! -e "${ZINIT_DIR}/plugins/_local---${i}" ]]; then
        ln -sv ${PWD}/${i} ${ZINIT_DIR}/plugins/_local---${i}
    fi
done
```

##### copy zshrc

```shell
ZSHRC_FILE="${HOME}/.zshrc"
mv -v "${ZSHRC_FILE}" "${ZSHRC_FILE}_$(date +%Y-%m-%d_%H-%M).bak"
cp -av ${TMOE_ZSH_DIR}/git/config/zshrc.zsh ${ZSHRC_FILE}
```

##### load zshtheme plugin

```shell
if ! egrep -q '^[^#]*zinit.*completion/_zshtheme' ${ZSHRC_FILE}; then
    printf "%s\n" "zinit ice lucid wait="1" as"completion" && zinit snippet ${TMOE_ZSH_DIR}/git/share/completion/_zshtheme" >>${ZSHRC_FILE}
fi

for i in /usr/local/bin ${PREFIX}/bin;do
    if [[ -e ${i} ]];then
        BIN_DIR=${i}
        break
    fi
done

chmod -R g-w /usr/local/share/zsh || sudo chmod -R g-w /usr/local/share/zsh
ln -sv ${TMOE_ZSH_DIR}/git/share/themes.sh ${BIN_DIR}/zshtheme || sudo ln -svf ${TMOE_ZSH_DIR}/git/share/themes.sh ${BIN_DIR}/zshtheme
```

##### bsd-sed -> gnu-sed ; bsd-awk -> gnu-awk

```shell
    ln -sv $(command -v gsed) /usr/local/bin/sed || sudo ln -svf $(command -v gsed) /usr/local/bin/sed
    ln -sv $(command -v gawk) /usr/local/bin/awk || sudo ln -svf $(command -v gawk) /usr/local/bin/awk
```

Finally, restart the terminal, and type `zshtheme`  

If you want to continue using this script, it is recommended that you keep gnu-sed as the default sed.  
If you want to restore to bsd-sed, type the following commands.  

```shell
for i in sed awk;do
    sudo unlink /usr/local/bin/${i}
done
```

#### windows-terminal

![Snipaste_2021-03-02_21-13-58.png](https://i.loli.net/2021/03/03/l8RDesWStPYCwjr.png)

If you are using win10, then you can beautify windows-terminal.  

Open [this json file](https://github.com/2moe/tmoe-zsh/blob/master/config/windows-terminal.json)

And copy the contents of the **"schemes"** array to **settings.json**  
![settings.json](https://images.gitee.com/uploads/images/2021/0303/170741_5b42d4d4_5617340.png "Screenshot_20210303_164039.png")

If you are using [windows terminal preview](https://aka.ms/terminal-preview), then you can add `settingsUI` hot key to **"keybindings"** array.

```json
 "keybindings": [
    {
      "command": {
        "action": "openSettings",
        "target": "settingsUI"
      },
      "keys": "ctrl+shift+,"
    },
]
```

Finally, press "ctrl+shift+,"

## 3. INSTRUCTIONS

### 3-1.COMMANDS

**Change theme:**
​  
​`​ zshtheme ​`

You can use `-h` or `--help` parameter to get help information.

**Change color scheme:**
​  
​`​ zshcolor ​`
​  
**Change font:**
​  
​`​ zshfont ​`  
**Start zsh manager:**
​  
​`​ zsh-i ​`

### 3-2. NOTES of zshtheme

![zshtheme](https://images.gitee.com/uploads/images/2020/0926/103629_85422bd6_7793225.png)

```bash
  COMMAND: zshtheme
  命令: zshtheme
  Description: This command can change the ZSH theme.
  描述: 此命令能修改ZSH主题。
  --------------
  -h      --help
  get-help-info 获取帮助信息
  --------------
  -n      --no-color
  In this mode, the theme list will have no color.
  若您安装了lolcat，则主题列表将输出五彩斑斓的颜色，而-n参数将禁用此模式。
  --------------
  -num    --number list. This is the default mode.
  If the parameter is empty, it will enter this mode.
  It is interactive, you need to type zshtheme or zshtheme -num to start this mode first, and then type the option number,finally press Enter key.
  序号列表模式。若参数为空，则将进入此模式。
  此模式为交互式操作，您可以先输zshtheme启动,接着输入数字序号。
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
  NOTES of manual mode
  手动模式的说明
  You can type zshtheme $THEME_NAME to change the zsh theme.
  In the process of typing zsh, you can press TAB to  complete.
  For example.01: If you type zshtheme agnosterzak,then zsh theme will be changed to agnosterzak.
  02:   zshtheme xiong-chiamiov-plus
  您可以输zshtheme $主题名称来修改主题。
  例如： 输入zshtheme powerlevel10k或者zshtheme p10k，将主题修改为powerlevel10k。
  --------------
  LIST OF ZSH THEMES:
3den , abaykan , adben , af-magic , afowler , agkozak , agnoster , agnosterzak , alanpeabody , alien , alien-minimal , amuse , antsy , aphrodite , apple , arrow , asciigit , aussiegeek , avit , avit-da2k , awesomepanda , bender , bira , blinks , blokkzh , bullet-train , bunnyruni , bureau , candy , candy-kingdom , chi , chill , ciacho , classytouch , clean , cloud , color-input , color-input-line , cordial , crcandy , crunch , cypher , daivasmara , dallas , darkblood , daveverwer , dieter , docker-zsh , dogenpunk , dpoggi , dpoggi-newline-timestamp , drofloh , dst , dstufft , ducula , duellj , eastwood , edvardm , elessar , emotty , enlightenment , essembeh , evan , fino , fino-time , fishbone++ , fishy , fishy2 , flazz , fletcherm , fox , frisk , frontcube , funky , funkyberlin , fwalch , gallifrey , gallois , garyblessington , gentoo , geoffgarside , geometry , gianu , gitstatus , gitster , gnzh , gozilla , half-life , halil , haribo , hedgehog , hub , humza , hyper-oh-my-zsh , hyperzsh , igeek , igorsilva , imajes , imp , imperator , intheloop , intika , itchy , jaischeema , jbergantine , jispwoso , jnrowe , jonathan , josh , jovial , jreese , jtriley , juanghurtado , junkfood , kafeitu , kardan , kayid , kennethreitz , kimwz , kinda-fishy , kiwi , kmac , kolo , kphoen , lambda , lambda-gitster , lambda-mod , lambda-v , linuxonly , lukerandall , macovsky , maran , matte-black-yellow , matte-black-yellow-line , maza , mcquen , mgutz , mh , michelebologna , mikeh , miloshadzic , minimal , minimal-improved , minimal2 , mira , mlh , mortalscumbag , mrtazz , murilasso , muse , nanotech , nebirhos , nicoulaj , node , nodeys , norm , nothing , nt9 , nuts , obraun , odin , oh-wonder , omega , oxide , passion , peepcode , philips , philthy , pi , pmcgee , powerlevel10k , punctual , pure , pygmalion , pygmalion-virtualenv , rafiki-zsh , random-emoji , re5et , refined , reggae , retro-term , rgm , risto , rixius , rkj , rkj-repos , robbyrussell , robbyrussell-wip , sammy , schminitz , shayan , short , simonoff , simple , skaro , sm , smt , sobole , Soliah , solus , sonicradish , sorin , spaceship-zsh , sporty_256 , staples , steeef , strug , sunaku , sunrise , superjarin , suvash , takashiyoshida , terminalparty , theta , theunraveler , tjkirch , tjkirch_mod , tonotdo , traditional-plus , trapd00r , typewritten , vero , via , wedisagree , wezm , wezm+ , windows-cmd , wuffers , xiong-chiamiov , xiong-chiamiov-plus , xxf , ys , zeroastro , zeta , zhann , zsh2000 , λpure
```

### 3-3. NOTES of zshcolor

![zshcolor](https://images.gitee.com/uploads/images/2020/0926/104752_29cbd46a_7793225.png)

```bash
  COMMAND: zshcolor
  命令: zshcolor
  Description: This command can change the terminal color scheme.
  描述: 此命令能修改终端配色。
  --------------
  -h      --help
  --------------
  -n      --no-color
  --------------
  -num    --number list. This is the default mode.
  If the parameter is empty, it will enter this mode.
  It is interactive, you need to type zshcolor or zshcolor -num to start this mode first, and then type the option number,finally press Enter key.
  序号列表模式。若参数为空，则将进入此模式。
  此模式为交互式操作，您可以先输zshcolor启动,接着输入数字序号。
  --------------
  NOTES of manual mode
  手动模式的说明
  You can type zshcolor $COLOR_NAME to change the terminal color scheme.
  For example.01: If you type zshcolor monokai.dark,then terminal color will be changed to monokai.dark.
  您可以输zshcolor $配色名称来修改配色。
  例如： 输入zshcolor neon，将配色修改为neon。
  --------------
  LIST OF COLOR SCHEMES:
 3024.dark // 3024.light // aci // aco // apathy.dark // apathy.light // argonaut // ashes.dark // ashes.light // atelierdune.dark // atelierdune.light // atelierforest.dark // atelierforest.light // atelierheath.dark // atelierheath.light // atelierlakeside.dark // atelierlakeside.light // atelierseaside.dark // atelierseaside.light // azu // base16.solarized.dark // base16.solarized.light // bespin.dark // bespin.light // bim // black.on.white // brewer.dark // brewer.light // bright.dark // bright.light // cai // chalk // chalk.dark // chalk.light // codeschool.dark // codeschool.light // colors.dark // colors.light // default // default.dark // default.light // dracula // eighties.dark // eighties.light // elementary // elic // elio // embers.dark // embers.light // flat // flat.dark // flat.light // freya // gnometerm // google.dark // google.light // gotham // grayscale.dark // grayscale.light // greenscreen.dark // greenscreen.light // gruvbox.dark // gruvbox.light // harmonic16.dark // harmonic16.light // hemisu.dark // hemisu.light // hybrid // isotope.dark // isotope.light // jup // londontube.dark // londontube.light // mar // marrakesh.dark // marrakesh.light // materia // material // miu // mocha.dark // mocha.light // monokai.dark // monokai.light // nancy // neon // nep // nord // ocean.dark // ocean.light // one.dark // one.light // pali // paraiso.dark // paraiso.light // peppermint // railscasts.dark // railscasts.light // rydgel // sat // shapeshifter.dark // shapeshifter.light // shel // smyck // solarized.dark // solarized.light // summerfruit.dark // summerfruit.light // tango // tin // tomorrow // tomorrow.dark // tomorrow.light // tomorrow.night // tomorrow.night.blue // tomorrow.night.bright // tomorrow.night.eighties // twilight.dark // twilight.light // ura // vag // white.on.black // wild.cherry // zenburn
```

### 3-4. PLUGINS 预装插件说明

![plugin_01](https://images.gitee.com/uploads/images/2020/0926/105252_7b96060e_7793225.png "截图_2020-09-26_10-52-43.png")  
本工具在执行初始化安装时，将预装某些插件。

```bash
________       ___      ________       ___      __________
 \_____  \     |\  \    |\   ___  \     |\  \    |\___   ___\
 \|___/  /|    \ \  \    \ \  \ \  \    \ \  \   \|___ \  \_|
     /  / /     \ \  \    \ \  \ \  \    \ \  \       \ \  \
    /  /_/__     \ \  \    \ \  \ \  \    \ \  \       \ \  \
   |\________\    \ \__\    \ \__\ \__\    \ \__\       \ \__\
    \|_______|     \|__|     \|__| \|__|     \|__|        \|__|
您可以在安装完成后，输 zsh-i进入zsh插件管理工具。
插件的加载方式基于zinit。
You can type zsh-i to start tmoe-zsh tool.
    ------------
    以下是部分插件的说明：
    插件名称PLUGIN NAME:z
    命令COMMAND:z
    若您曾访问过~/sd/Download，则您可以输"z Down"或"z load"来快速跳转，访问列表可以输"z"获取。
    ------------
    插件名称PLUGIN NAME:extract
    命令COMMAND:x
    Description: This plugin defines a function called "extract" that extracts the archive file you pass it, and it supports a wide variety of archive filetypes.

    例如某文件名为233.tar.xz，则您无需输"tar -Jxf 233.tar.xz"，只需输"x 233.tar.xz"。
    同理，若另一文件为233.7z，则您只需输入"x 233.7z"即可解压。
    注意：您在解压前必须先安装相关依赖，例如：zip需要unzip，7z需要p7zip，安装方法类似于"apt install unzip"
    -----------
    应用名称 APP NAME:exa
    命令COMMAND:exa
    alias ls=exa
    若您的系统满足依赖条件，则ls将alias为exa.
    exa是一款优秀的ls替代品,拥有更好的文件展示体验,输出结果更快,使用rust编写。
    Exa is a modern version of ls.
    输入lst,将展示类似于tree的树状列表。
    输入l,将显示当前目录的文件列表。
    -----------

```

![plugin_02](https://images.gitee.com/uploads/images/2020/0926/105611_54a9c847_7793225.png "截图_2020-09-26_10-55-48.png")

```bash
  应用名称 APP NAME:bat
    命令COMMAND:bat
    alias cat=bat
    bat是cat的替代品，支持多语言语法高亮。
    支持自动分页，对于大文本，以 less 命令输出，可使用类似 vim 的快捷键移动光标。 你可以输q退出bat的页面视图，you can type q to quit bat.
    用法示例：bat -l zsh /etc/os-release
    输入bat -L获取支持的语言
    ------------
    插件名称PLUGIN NAME:colored-man-pages
    命令COMMAND:man
    Description: man手册彩色输出 This plugin adds colors to man pages..
    输入man 软件包或命令名称获取该软件包的文档。
    用法示例：man ssh高亮显示ssh-client的文档（用户手册）。
    man bash获取bash的用户手册。
    ------------
    Other
    补全插件用法：
    输入已知命令或函数的部分字符后，按下TAB键
    You can press TAB KEY to use auto completion plugin.
    ------------
    Plugins such as extract, git ,fast-syntax-highlighting , fzf-tab and z have been configured for you. Enjoy the fun of zsh!

```

作为一款插件管理器，本工具的亮点是自动添加注释内容。

以下是`bat ~/.zshrc`输出的部分内容的截图
![bat ~/.zshrc](https://images.gitee.com/uploads/images/2020/0926/110553_bcc3c060_7793225.png "截图_2020-09-26_11-05-33.png")
Because this tool is based on zinit, the command to load the plugin is zinit.

Like below:

```bash
zinit ice wait lucid pick"fast-syntax-highlighting.plugin.zsh" atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" && zinit light _local/fast-syntax-highlighting    #语法高亮插件，速度比zsh-syntax-highlighting更快。(Short name F-Sy-H). Syntax-highlighting for Zshell – fine granularity, number of features, 40 work hours themes
```

## 4.相关项目

**[zdharma/zinit](https://github.com/zdharma/zinit)**  
**[romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)**  
**[Aloxaf/fzf-tab](https://github.com/Aloxaf/fzf-tab)**  
**[zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)**  
**[oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)**  
**[Cabbagec/termux-ohmyzsh](https://github.com/Cabbagec/termux-ohmyzsh)**  
**[zdharma/fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)**  
**[abaykan/Mine](https://github.com/abaykan/Mine)**  
**[agkozak/agkozak-zsh-prompt](https://github.com/agkozak/agkozak-zsh-prompt)**  
**[zakaziko99/agnosterzak-ohmyzsh-theme](https://github.com/zakaziko99/agnosterzak-ohmyzsh-theme)**  
**[eendroroy/alien](https://github.com/eendroroy/alien)**  
**[eendroroy/alien-minimal](https://github.com/eendroroy/alien-minimal)**  
**[jeffmhubbard/antsy-zsh-theme](https://github.com/jeffmhubbard/antsy-zsh-theme)**  
**[win0err/aphrodite-terminal-theme.git](https://github.com/win0err/aphrodite-terminal-theme.git)**  
**[cemsbr/asciigit](https://github.com/cemsbr/asciigit)**  
**[fdaciuk/avit-da2k](https://github.com/fdaciuk/avit-da2k)**  
**[specious/bender](https://github.com/specious/bender)**  
**[KorvinSilver/blokkzh](https://github.com/KorvinSilver/blokkzh)**  
**[caiogondim/bullet-train-oh-my-zsh-theme](https://github.com/caiogondim/bullet-train-oh-my-zsh-theme)**  
**[jopcode/oh-my-zsh-bunnyruni-theme](https://github.com/jopcode/oh-my-zsh-bunnyruni-theme)**  
**[akinjide/chi](https://github.com/akinjide/chi)**  
**[PsychoPatate/chill.zsh-theme](https://github.com/PsychoPatate/chill.zsh-theme)**  
**[Ciacho/ciacho-ohmyzsh-theme](https://github.com/Ciacho/ciacho-ohmyzsh-theme)**  
**[yarisgutierrez/classyTouch_oh-my-zsh](https://github.com/yarisgutierrez/classyTouch_oh-my-zsh)**  
**[stevelacy/cordial-zsh-theme](https://github.com/stevelacy/cordial-zsh-theme)**  
**[Daivasmara/daivasmara.zsh-theme](https://github.com/Daivasmara/daivasmara.zsh-theme)**  
**[dpdornseifer/docker-zsh-theme](https://github.com/dpdornseifer/docker-zsh-theme)**  
**[channprj/dotfiles-macOS](https://github.com/channprj/dotfiles-macOS)**  
**[drofloh/oh-my-zsh-custom](https://github.com/drofloh/oh-my-zsh-custom)**  
**[janjoswig/Ducula](https://github.com/janjoswig/Ducula)**  
**[fjpalacios/elessar-theme](https://github.com/fjpalacios/elessar-theme)**  
**[w33tmaricich/enlightenment](https://github.com/w33tmaricich/enlightenment)**  
**[EYH0602/Fishbonepp](https://github.com/EYH0602/Fishbonepp)**  
**[akinjide/fishy2](https://github.com/akinjide/fishy2)**  
**[Ottootto2010/funkyberlin-zsh-theme](https://github.com/Ottootto2010/funkyberlin-zsh-theme)**  
**[frmendes/geometry](https://github.com/frmendes/geometry)**  
**[kimyvgy/gitstatus-zsh-theme](https://github.com/kimyvgy/gitstatus-zsh-theme)**  
**[shashankmehta/dotfiles](https://github.com/shashankmehta/dotfiles)**  
**[5m0k3r/zsh-themes](https://github.com/5m0k3r/zsh-themes)**  
**[haribo/omz-haribo-theme](https://github.com/haribo/omz-haribo-theme)**  
**[hedgehog1029/dfbb7e66511e2c399157](https://gist.github.com/hedgehog1029/dfbb7e66511e2c399157)**  
**[hub23/c226b1c77446e099f7684b0d21c6b22a](https://gist.github.com/hub23/c226b1c77446e099f7684b0d21c6b22a)**  
**[willmendesneto/hyper-oh-my-zsh](https://github.com/willmendesneto/hyper-oh-my-zsh)**  
**[tylerreckart/hyperzsh](https://github.com/tylerreckart/hyperzsh)**  
**[Saleh7/igeek-zsh-theme](https://github.com/Saleh7/igeek-zsh-theme)**  
**[igor9silva/zsh-theme](https://github.com/igor9silva/zsh-theme)**  
**[master/Shell-Themes](https://github.com/LinuxGogley/Linux-Mods/tree/master/Shell-Themes)**  
**[igormp/Imp](https://github.com/igormp/Imp)**  
**[Intika-Linux-Apps/Oh-My-Zsh-Intika](https://github.com/Intika-Linux-Apps/Oh-My-Zsh-Intika)**  
**[zthxxx/jovial](https://github.com/zthxxx/jovial)**  
**[AmrMKayid/KayidmacOS](https://github.com/AmrMKayid/KayidmacOS)**  
**[kimwz/kimwz-oh-my-zsh-theme](https://github.com/kimwz/kimwz-oh-my-zsh-theme)**  
**[folixg/kinda-fishy-theme](https://github.com/folixg/kinda-fishy-theme)**  
**[koreymacdougall/config_files](https://github.com/koreymacdougall/config_files)**  
**[ergenekonyigit/lambda-gitster](https://github.com/ergenekonyigit/lambda-gitster)**  
**[halfo/lambda-mod-zsh-theme](https://github.com/halfo/lambda-mod-zsh-theme)**  
**[vkaracic/lambdav-zsh-themes](https://github.com/vkaracic/lambdav-zsh-themes)**  
**[eamazaj/maza-theme](https://github.com/eamazaj/maza-theme)**  
**[ryanpcmcquen/150cf9a66bca2463e5660cafed3e1000](https://gist.github.com/ryanpcmcquen/150cf9a66bca2463e5660cafed3e1000)**  
**[girishrau/oh-my-zsh-customizations](https://github.com/girishrau/oh-my-zsh-customizations)**  
**[gdsrosa/minimal_improved](https://github.com/gdsrosa/minimal_improved)**  
**[skuridin/oh-my-zsh-node-theme](https://github.com/skuridin/oh-my-zsh-node-theme)**  
**[marszall87/nodeys-zsh-theme](https://github.com/marszall87/nodeys-zsh-theme)**  
**[eendroroy/nothing](https://github.com/eendroroy/nothing)**  
**[lenguyenthanh/nt9-oh-my-zsh-theme](https://github.com/lenguyenthanh/nt9-oh-my-zsh-theme)**  
**[rafaelsq/nuts.zsh-theme](https://github.com/rafaelsq/nuts.zsh-theme)**  
**[tylerreckart/odin](https://github.com/tylerreckart/odin)**  
**[kaushik94/a54e128869c0c82bdbed31d56c710daa](https://gist.github.com/kaushik94/a54e128869c0c82bdbed31d56c710daa)**  
**[Section214/zsh-omega](https://github.com/Section214/zsh-omega)**  
**[dikiaap/dotfiles](https://github.com/dikiaap/dotfiles)**  
**[ChesterYue/ohmyzsh-theme-passion](https://github.com/ChesterYue/ohmyzsh-theme-passion)**  
**[philFernandez/56f8953722285834cc9000ffcfe103f4](https://gist.github.com/philFernandez/56f8953722285834cc9000ffcfe103f4)**  
**[tobyjamesthomas/pi](https://github.com/tobyjamesthomas/pi)**  
**[dannynimmo/punctual-zsh-theme](https://github.com/dannynimmo/punctual-zsh-theme)**  
**[sindresorhus/pure.git](https://github.com/sindresorhus/pure.git)**  
**[akabiru/rafiki-zsh](https://github.com/akabiru/rafiki-zsh)**  
**[oshybystyi/2c30543cd48b2c9ecab0](https://gist.github.com/oshybystyi/2c30543cd48b2c9ecab0)**  
**[mgimenez/ae1cde0b637e844da885cb093a916126](https://gist.github.com/mgimenez/ae1cde0b637e844da885cb093a916126)**  
**[ecbrodie/robbyrussell-WIP-theme](https://github.com/ecbrodie/robbyrussell-WIP-theme)**  
**[schminitz/9931af23bbb59e772eec](https://gist.github.com/schminitz/9931af23bbb59e772eec)**  
**[shayanh/shayan-zsh-theme](https://github.com/shayanh/shayan-zsh-theme)**  
**[nikhilkmr300/omz-themes](https://github.com/nikhilkmr300/omz-themes)**  
**[blyndusk/sm-theme](https://github.com/blyndusk/sm-theme)**  
**[sobolevn/sobole-zsh-theme](https://github.com/sobolevn/sobole-zsh-theme)**  
**[cloudnull/4cc7890acaae6cb809e811e09e9eaade](https://gist.github.com/cloudnull/4cc7890acaae6cb809e811e09e9eaade)**  
**[denysdovhan/spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt)**  
**[dersam/staples](https://github.com/dersam/staples)**  
**[eendroroy/theta](https://github.com/eendroroy/theta)**  
**[xfxf/zsh-theme-traditional-plus](https://github.com/xfxf/zsh-theme-traditional-plus)**  
**[reobin/typewritten](https://github.com/reobin/typewritten)**  
**[Raindeer44/vero](https://github.com/Raindeer44/vero)**  
**[badouralix/oh-my-via](https://github.com/badouralix/oh-my-via)**  
**[juliavallina/windows-zsh-theme](https://github.com/juliavallina/windows-zsh-theme)**  
**[xfanwu/18fd7c24360c68bab884](https://gist.github.com/xfanwu/18fd7c24360c68bab884)**  
**[zeroastro/zeroastro-zsh-theme](https://github.com/zeroastro/zeroastro-zsh-theme)**  
**[skylerlee/zeta-zsh-theme](https://github.com/skylerlee/zeta-zsh-theme)**  
**[maverick9000/zsh2000](https://github.com/maverick9000/zsh2000)**  
**[marszall87/lambda-pure](https://github.com/marszall87/lambda-pure)**

zsh 里面的额外主题是我从[oh-my-zsh/external-themes](https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes)里介绍的 Github 仓库里一个个找的。 °(°ˊДˋ°) °
If you find a theme loading error, then you can submit an issue.
