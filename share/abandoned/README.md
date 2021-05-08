# 已经废弃的功能

## 不再支持macos

### MANUALLY CONFIGURE 手动配置

Unix 系统(例如：**MacOS、FreeBSD、OpenBSD、NetBSD**和**SunOS**等)请参考手动配置步骤

#### MacOS

If you are using MacOS, then install **homebrew** before configuration.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

如果您使用的是苹果 MacOS，那么请在配置前先安装 **homebrew**  
您可以通过[BFSU 镜像站](https://mirrors.bfsu.edu.cn/help/homebrew/)或者[TUNA 镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)来安装 **homebrew**

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

If you are using Apple Silicon arm64 CPU, then you should add `brew` to your PATH.  
如果您正在使用 Apple M1 或其他 Apple arm64 cpu 的 mac 设备，那么请将 **/opt/homebrew/bin** 加入到 **PATH** 中。

```bash
grep -qF '/opt/homebrew/bin' /etc/paths || sudo /usr/bin/sed -i "" '1i \
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

for i in /opt/homebrew/bin /usr/local/bin ${PREFIX}/bin;do
    if [[ -d ${i} ]];then
        BIN_DIR=${i}
        break
    fi
done

chmod -R g-w /usr/local/share/zsh || sudo chmod -R g-w /usr/local/share/zsh
ln -sv ${TMOE_ZSH_DIR}/git/share/themes.sh ${BIN_DIR}/zshtheme || sudo ln -svf ${TMOE_ZSH_DIR}/git/share/themes.sh ${BIN_DIR}/zshtheme
ln -sv ${TMOE_ZSH_DIR}/git/zsh.sh ${BIN_DIR}/zsh-i || sudo ln -svf ${TMOE_ZSH_DIR}/git/zsh.sh ${BIN_DIR}/zsh-i
```

##### bsd-sed -> gnu-sed ; bsd-awk -> gnu-awk

```shell
    ln -sv $(command -v gsed) ${BIN_DIR}/sed || sudo ln -svf $(command -v gsed) ${BIN_DIR}/sed
    ln -sv $(command -v gawk) ${BIN_DIR}/awk || sudo ln -svf $(command -v gawk) ${BIN_DIR}/awk
```

Finally, restart the terminal, and type `zshtheme`

If you want to continue using this script, it is recommended that you keep gnu-sed as the default sed.  
If you want to restore to bsd-sed, type the following commands.

```shell
for i in sed awk;do
    sudo unlink ${BIN_DIR}/${i}
done
```

#### windows terminal

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
