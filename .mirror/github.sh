#!/bin/bash
cd ..
ALL_SHARE_FILE=$(find ./share/* ./tools/* | tr '\n' ' ' | cut -d '%' -f 1)
unset SHARE_FILE
for i in ${ALL_SHARE_FILE}; do
    if [ ! -d "${i}" ]; then
        SHARE_FILE="${SHARE_FILE} ${i}"
    fi
done
SHARE_FILE="${SHARE_FILE} zsh.sh"
sed -i 's!gitee.com/mo2/zsh/raw/master/zsh.sh!raw.githubusercontent.com/2cd/zsh/master/zsh.sh!g' ./.mirror/zsh
# sed -i 's!https://gitee.com/mo2/zsh/raw/master/zsh.sh!${TMOE_GIT_REPO}/raw/master/zsh.sh!g' zsh.sh
# sed -i 's@gitee.com/mo2/fzf-tab@github.com/Aloxaf/fzf-tab@g' zsh.sh ./tools/*sh
# sed -i 's@gitee.com/mirrors/neofetch/raw/master/neofetch@raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch@g' zsh.sh ./tools/*sh
# sed -i 's@gitee.com/mirrors/oh-my-zsh/raw/master/templates/zshrc.zsh-template@raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/templates/zshrc.zsh-template@g' zsh.sh ./tools/*sh
# sed -i 's@gitee.com/mo2/zsh.git@github.com/2moe/tmoe-zsh.git@g' zsh.sh ./tools/*sh
# sed -i 's@gitee.com/mirrors/oh-my-zsh.git@github.com/ohmyzsh/ohmyzsh.git@g' zsh.sh ./tools/*sh
# sed -i 's@###tmoe-github@@' zsh.sh ./tools/*sh
# sed -i 's@gitee.com/mo2/zsh/raw/master/@raw.githubusercontent.com/2moe/tmoe-zsh/master/@g' zsh.sh ./tools/*sh
# sed -i 's@gitee.com/mo2/linux/raw/master/@raw.githubusercontent.com/2moe/tmoe-linux/master/@g' zsh.sh ./tools/*sh
# sed -i 's@gitee.com/romkatv/powerlevel10k@github.com/romkatv/powerlevel10k@g' zsh.sh ./tools/*sh ./share/themes.sh
# sed -i 's@gitee.com/ak2/powerlevel9k@github.com/Powerlevel9k/powerlevel9k@g' ./share/themes.sh
# sed -i 's@gitee.com/ak2/fast-syntax-highlighting@github.com/zdharma/fast-syntax-highlighting@g' zsh.sh ./tools/*sh
# sed -i 's@gitee.com/ak2/zsh-autosuggestions@github.com/zsh-users/zsh-autosuggestions@g' zsh.sh ./tools/*sh
# sed -i 's@gitee.com/ak2/zinit.git@github.com/zdharma/zinit.git@g' ./tools/*sh
# sed -i 's@gitee.com/mo2/zsh@github.com/2moe/tmoe-zsh@g' zsh.sh
# sed -i 's@gitee.com/ak2/p10k_config/@github.com/2moe/p10k_config/@g' share/themes.sh

sed -e 's!https://gitee.com/mo2/zsh/raw/master/zsh.sh!${TMOE_GIT_REPO}/raw/master/zsh.sh!g' \
    -e 's@gitee.com/mo2/fzf-tab@github.com/Aloxaf/fzf-tab@g' \
    -e 's@gitee.com/mirrors/neofetch/raw/master/neofetch@raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch@g' \
    -e 's@gitee.com/mo2/zsh.git@github.com/2cd/zsh.git@g' \
    -e 's@gitee.com/mirrors/oh-my-zsh.git@github.com/ohmyzsh/ohmyzsh.git@g' \
    -e 's@###tmoe-github@@' \
    -e 's@gitee.com/mo2/zsh/raw/master/@raw.githubusercontent.com/2cd/zsh/master/@g' \
    -e 's@gitee.com/mo2/linux/raw/master/@raw.githubusercontent.com/2moe/tmoe-linux/master/@g' \
    -e 's@gitee.com/romkatv/powerlevel10k@github.com/romkatv/powerlevel10k@g' \
    -e 's@gitee.com/ak2/powerlevel9k@github.com/Powerlevel9k/powerlevel9k@g' \
    -e 's@gitee.com/ak2/fast-syntax-highlighting@github.com/zdharma/fast-syntax-highlighting@g' \
    -e 's@gitee.com/ak2/zsh-autosuggestions@github.com/zsh-users/zsh-autosuggestions@g' \
    -e 's@gitee.com/ak2/zinit.git@github.com/zdharma/zinit.git@g' \
    -e 's@gitee.com/mo2/zsh@github.com/2cd/zsh@g' \
    -e 's@gitee.com/ak2/p10k_config/@github.com/2moe/p10k_config/@g' \
    -i ${SHARE_FILE}

# raw.githubusercontent.com/2moe/tmoe-zsh/master/

# https://raw.githubusercontent.com/2cd/zsh/master/zsh.sh
