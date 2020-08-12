#!/usr/bin/env bash
cd  ~/gitee/zsh
cp -rf update.sh zsh.sh tools .gitignore .termux .mirror ~/github/github-zsh/
cd ~/github/github-zsh/.mirror 
bash ./github.sh
pwd
code ..