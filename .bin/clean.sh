set -eu

pnpm store prune
yarn cache clean
yay -Sc
