#!/bin/bash
# mise (tool version manager). Its config is a managed file
# (private_dot_config/mise/config.toml.tmpl); the tools are installed after apply.
set -euo pipefail

if [[ -x "$HOME/.local/bin/mise" ]]; then
  exit 0
fi

echo "==> Installing mise"
curl -fsSL https://mise.run | sh
