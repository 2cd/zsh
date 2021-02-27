#!/usr/bin/env bash
cd ~/gitee/zsh
cp -a zsh.sh .mirror/zsh
#sed -i 's!${TMOE_GIT_REPO}/raw/master/zsh.sh!https://cdn.jsdelivr.net/gh/2moe/tmoe-zsh@master/.mirror/zsh!g' .mirror/zsh
cp -rf zsh.sh tools .gitignore config share .mirror ~/github/github-zsh/
cd ~/github/github-zsh/.mirror
bash ./github.sh
pwd
code ..
