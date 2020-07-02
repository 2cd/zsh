# Tmoe-zsh 介绍 Introduction

> 方便轻松地为 GNU/Linux 和 Android-Termux 配置 zsh 主题  
> **Easily configure zsh themes for GNU/Linux and Android-Termux**

## 预览 Preview

### 部分主题预览截图 Screenshot

![Capture__2020-03-24-17-29-552.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/3luF9hHGPnPuhwHu.png)

![Snipaste_2020-03-24_17-12-57.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/YsZou4mIXZUFUYdZ.png)

### 目前可选 200 多种主题 You can choose more than 200 zsh themes

![Snipaste_2020-03-24_17-34-37.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/ZSIBFuC1v3AKcTFX.png)

### 100 多种配色 More than 100 color schemes

![Snipaste_2020-03-24_17-16-22.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/3JQSGux51j6Fj5cp.png)

### 近 50 种字体 Nearly 50 fonts

![Snipaste_2020-03-24_17-20-59.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/K9PweO1nbWok8XUh.png)

### 管理器界面预览 Interface preview screenshot

![86K2M8.png](https://s1.ax1x.com/2020/03/20/86K2M8.png)
![Capture__2020-03-24-17-41-46.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/hSQuBsUxPRbjSgUM.png)

为 Linux 和 Termux 一键配置[oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)环境，目前支持修改 200 多种主题，100 多种配色和近 50 种字体。

Linux 仅支持修改 zsh 主题，termux 除主题外，还支持修改配色和字体。

2020-03-19 更新内容：

增加了对其它 linux 系统的支持！

2020-03-24 更新内容：  
支持 Gentoo/Funtoo

## 2.安装说明 Installation instructions for different systems

1.Android-[Termux](https://termux.com/)

```shell
    apt install -y curl
    bash -c "$(curl -L git.io/zsh.sh)"
```

如果你在国内，那么可以使用 gitee 仓库。

```shell
    bash -c "$(curl -LfsS https://gitee.com/mo2/zsh/raw/master/zsh.sh)"
```

2.Debian/Ubuntu/Mint/Kali

```shell
    sudo apt update
    sudo apt install -y curl
    bash <(curl -L git.io/zsh.sh)
```

3.RedHat/Fedora/CentOS

```shell
    dnf install -y curl || yum install -y curl
    bash -c "$(curl -L git.io/zsh.sh)"
```

4.Arch/Manjaro

```shell
    pacman -Syu --noconfirm curl
    bash -c "$(curl -L git.io/zsh.sh)"
```

5.OpenWRT/Entware(只测试了 mipsel 架构路由器的 Entware 系统)

```shell
    opkg update
    opkg install libustream-openssl ca-bundle ca-certificates wget bash
    bash -c "$(wget --no-check-certificate -qO- git.io/zsh.sh)"
```

6.Alpine/iOS-[iSH](https://ish.app/)

```shell
    apk add wget
    wget -O /tmp/.tmoe-zsh git.io/zsh.sh
    ash /tmp/.tmoe-zsh
```

7.Void

```shell
    xbps-install -S
    xbps-install -y wget
    bash -c "$(wget -qO- git.io/zsh.sh)"
```

8.Gentoo/Funtoo

```shell
    emerge -avk net-misc/wget
    bash -c "$(wget -qO- git.io/zsh.sh)"
```

9.其它 system 未测试,以下系统请自行解决依赖关系。  
例如:**OpenSuse**和**GuixSD**等发行版。  
还有 Unix 系统，例如：**MacOS、FreeBSD、OpenBSD、NetBSD**和**SunOS**等。  
相关依赖为 `zsh git pv wget tar xz newt(whiptail)`

## 3.使用说明 Instructions for using the script

**Change color scheme:**
​  
​`​ zshcolor ​`
​  
**Change theme:**
​  
​`​ zshtheme ​`
​  
**Change font:**
​  
​`​ zshfont ​`  
**Start zsh manager:**
​  
​`​ zsh-i ​`

## 4.相关项目

**[oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)**  
**[Cabbagec/termux-ohmyzsh](https://github.com/Cabbagec/termux-ohmyzsh)**  
**[romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)**  
**[zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)**  
**[Aloxaf/fzf-tab](https://github.com/Aloxaf/fzf-tab)**  
**[zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)**

zsh 里面的额外主题是我从[oh-my-zsh/external-themes](https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes)里介绍的 Github 仓库里一个个下载下来的，不保证全都能用。
