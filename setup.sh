#!/bin/zsh
set -eu
# prepare
root=`dirname "$0"`
lnrs="ln --relative --symbolic"
echo $root
exit 0
echo "whee"
source "$root/.profile"

# install omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm "$HOME/.zshrc"

# link everything
lnrs --force "$root/.zshrc" "$HOME/.zshrc"

lnrs "$root/.profile" "$HOME/.profile"

lnrs "$root/.bin" "$HOME/.bin"
lnrs "$root/.config/*" "$XDG_CONFIG_HOME/.config/"

lnrs "$root/.local/share/themes/*" "$XDG_DATA_HOME/themes/"
lnrs "$root/.local/share/icons/*" "$XDG_DATA_HOME/icons/"

# post-install
xrdb "$HOME/.Xresources"
