#!/bin/bash
# Oh My Zsh. The theme lives in the managed ~/.zshrc (dot_zshrc.tmpl), so the
# installer is told to leave .zshrc alone.
set -euo pipefail

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  exit 0
fi

echo "==> Installing Oh My Zsh"
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
  "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  "" --unattended
