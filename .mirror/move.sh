#!/usr/bin/env bash
cd ~/gitee/zsh
cp -rf zsh.sh tools .gitignore config share .mirror ~/github/github-zsh/
cd ~/github/github-zsh/.mirror
bash ./github.sh
pwd
code ..
