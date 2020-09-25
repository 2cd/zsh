# zsh

EMOJI=(💩 🐦 🚀 🐞 🎨 🍕 🐭 👽 ☕️ 🔬 💀 🐷 🐼 🐶 🐸 🐧 🐳 🍔 🍣 🍻 🔮 💰 💎 💾 💜 🍪 🌞 🌍 🐌 🐓 🍄 )

function random_emoji {
  echo -n "$EMOJI[$RANDOM%$#EMOJI+1]"
}

PROMPT="$(random_emoji)  "
RPROMPT='%c'

# if you want to show git branch uncomment next lines
RPROMPT='%{$fg_bold[colour255]%}%c$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" : "
ZSH_THEME_GIT_PROMPT_SUFFIX=" "

