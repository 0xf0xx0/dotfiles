#!/bin/bash
set -eu
root=`dirname "$0"`

ln -fbrs "$root/.zshrc" "$HOME/.zshrc"

ln -rs "$root/.bin" "$HOME/.bin"
ln -rs "$root/.config/*" "$XDG_CONFIG_HOME/.config/"

ln -rs "$root/.local/share/themes/*" "$XDG_DATA_HOME/themes/"
ln -rs "$root/.local/share/icons/*" "$XDG_DATA_HOME/icons/"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
