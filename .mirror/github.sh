#!/bin/bash
cd ..
sed -i 's@gitee.com/mo2/fzf-tab@github.com/Aloxaf/fzf-tab@g' zsh.sh ./tools/*sh
sed -i 's@gitee.com/mirrors/neofetch/raw/master/neofetch@raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch@g' zsh.sh ./tools/*sh
sed -i 's@gitee.com/mirrors/oh-my-zsh/raw/master/templates/zshrc.zsh-template@raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template@g' zsh.sh ./tools/*sh
sed -i 's@gitee.com/mo2/zsh.git@github.com/2moe/tmoe-zsh.git@g' zsh.sh ./tools/*sh
sed -i 's@gitee.com/mirrors/oh-my-zsh.git@github.com/ohmyzsh/ohmyzsh.git@g' zsh.sh ./tools/*sh
sed -i 's@###tmoe-github@@' zsh.sh ./tools/*sh
sed -i 's@gitee.com/mo2/zsh/raw/master/@raw.githubusercontent.com/2moe/tmoe-zsh/master/@g' zsh.sh ./tools/*sh
#sed -i 's@https://gitee.com/mo2/zsh/raw/master/zsh.sh@git.io/zsh.sh@' README.md
sed -i 's@gitee.com/mo2/linux/raw/master/@raw.githubusercontent.com/2moe/tmoe-linux/master/@g' zsh.sh ./tools/*sh
sed -i 's@gitee.com/romkatv/powerlevel10k@github.com/romkatv/powerlevel10k@g' zsh.sh ./tools/*sh ./share/themes.sh
sed -i 's@gitee.com/ak2/powerlevel9k@github.com/Powerlevel9k/powerlevel9k@g' ./share/themes.sh
#sed -i 's@gitee.com/mo2/zsh-syntax-highlighting@github.com/zsh-users/zsh-syntax-highlighting@g' zsh.sh ./tools/*sh
sed -i 's@gitee.com/ak2/fast-syntax-highlighting@github.com/zdharma/fast-syntax-highlighting@g' zsh.sh ./tools/*sh
sed -i 's@gitee.com/ak2/zsh-autosuggestions@github.com/zsh-users/zsh-autosuggestions@g' zsh.sh ./tools/*sh
sed -i 's@gitee.com/ak2/zinit.git@github.com/zdharma/zinit.git@g' ./tools/*sh
sed -i 's@gitee.com/mo2/zsh.git@https://github.com/2moe/tmoe-zsh.git@g' zsh.sh
