#!/data/data/com.termux/files/usr/bin/bash
cur=$(pwd)
grep 'alias zshcolor=' "$HOME/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zshcolor='bash $HOME/.termux/colors.sh'" "$HOME/.zshrc"
grep 'alias zshfont=' "$HOME/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zshfont='bash $HOME/.termux/fonts.sh'" "$HOME/.zshrc"
grep 'alias zsh-i=' "$HOME/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zsh-i='bash $HOME/.termux-zsh/update.sh'" "$HOME/.zshrc"
grep 'alias zshtheme=' "$HOME/.zshrc" >/dev/null 2>&1 || sed -i "$ a\alias zshtheme='bash $HOME/.termux/themes.sh'" "$HOME/.zshrc"
cd "$HOME/.termux-zsh"
#git fetch --all
git reset --hard origin/master
git pull --depth=1 origin master --allow-unrelated-histories
cd ${cur}
bash "$HOME/.termux-zsh/zsh.sh"
#echo "Please restart termux!"
exit
