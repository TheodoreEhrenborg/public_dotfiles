set -Eeuo pipefail
git clone https://github.com/doomemacs/doomemacs ~/.config/emacs
cd ~/.config/emacs
git checkout 2b1e07dcf0c5ffce89489c960ef59d204fe8ac3e
~/.config/emacs/bin/doom install
