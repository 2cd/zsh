#!/usr/bin/env bash
cd  ~/gitee/zsh
cp -rf update.sh zsh.sh .termux .mirror ~/github/github-zsh/
cd ~/github/github-zsh/.mirror 
bash ./github.sh
pwd
code ..
echo git commit -am ''
