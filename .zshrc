# OMZ Config
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/zcompdump
ZSH_THEME=clean
CASE_SENSITIVE="false"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# zsh-autosuggestions
plugins=( zsh-syntax-highlighting colored-man-pages)

if [ -f ~/.zsh-insulter/zsh.command-not-found ]; then
    . ~/.zsh-insulter/zsh.command-not-found
fi

source "$ZSH"/oh-my-zsh.sh

# User configuration
# PATH in /etc/profile.d/localpath
## aliases
alias ccat='highlight --style darkplus -O truecolor --stdout'
alias cp='cp -rv'
alias ferium='nocorrect ferium'
alias fl='env WINEPREFIX=/home/ging/.local/share/wineprefixes/fl-stuwudio wine64 $HOME/Desktop/FL\ Studio\ 20.lnk'
alias foresta='git-foresta --reverse --all --style 15 --graph-symbol-tip ┻ --graph-symbol-commit ┠ --graph-symbol-merge ┣ --graph-symbol-overpass ━'
alias gh='nocorrect gh'
alias killall='nocorrect killall'
alias nf='neowofetch'
alias nnn='nnn -edUHior'
alias pipx='nocorrect pipx'
alias pnpm='nocorrect pnpm'
alias pnpx='nocorrect pnpx'
alias reload='source ~/.zshrc && echo -e "\\e[4;32mReloaded!\\e[0m"'
alias time='/bin/time -f "%E real %U usermode %P %M Kb mem"'
alias tldr='nocorrect tldr'
alias yiff='nocorrect yay'
## functions
encodeqr() { qrencode $* -o - | feh -; }

## imports
### Development
source "$HOME/.config/zsh/ssh.zsh.config"
source "$HOME/.config/zsh/distcc.zsh.config"
source "$HOME/.config/zsh/ftp.zsh.config"

### Furry MUCKs
alias furrymuck='telnet furrymuck.com 8888'
alias furtoonia='telnet ft.furtoonia.net 9999'

### LMMS
alias getlmms="git clone --recurse-submodules -b master https://github.com/lmms/lmms && cd ./lmms && mkdir build"
alias buildlmms='cmake .. -DCMAKE_INSTALL_PREFIX=../target/  -Wno-dev -DWANT_CARLA=ON -DWANT_VST=ON -DCMAKE_PREFIX_PATH=/usr/lib/wine && make -j14'
alias updatelmms="git remote update && git pull && git submodule update --init --recursive"
alias uablmms="updatelmms && cd ./build && buildlmms"
alias fullmms="getlmms && cd ./build && buildlmms"

### misc
alias lansetup='sudo sysctl net.ipv4.ip_forward=1 && sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE && sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT && sudo iptables -A FORWARD -i wlan1 -o wlan0 -j ACCEPT'
alias lanup='nmcli device connect wlan1'
alias landown='nmcli device disconnect wlan1'

# setup completion
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
