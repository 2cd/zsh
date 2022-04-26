#!/usr/bin/env bash
cd ~/data/git/ee/zsh
# cp -a zsh.sh .mirror/zsh
cp -rf zsh.sh tools .gitignore config share .mirror ../../hub/zsh
cd ../../hub/zsh/.mirror
bash ./github.sh
pwd
# code ..
