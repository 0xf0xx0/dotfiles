set -eu

pnpm prune
npm store prune
yarn cache clean
yay -Sc
