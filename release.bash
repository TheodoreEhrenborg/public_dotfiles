#!/usr/bin/env bash
set -e
# Some files have mildly sensitive information,
# like a `curl v2.wttr.in` shortcut that reveals where I live.
# Run this script, and then run
# rsync -av --exclude='.git' --exclude='.jj' ~/dotfiles/ ~/projects/public_dotfiles/
# to deploy to the public repo

# Set public = true in home.nix
sed -i 's/public ? false/public ? true/' home.nix

# Remove the files with sensitive information
rm my-abbreviations.el
rm restic_ignore
rm i3_swap.bash
rm i3status_config
rm i3_config
rm config.fish
