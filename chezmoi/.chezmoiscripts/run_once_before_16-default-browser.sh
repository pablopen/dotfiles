#!/bin/bash
# Firefox as the default browser, before any step opens a web page.
# macOS asks for confirmation in a dialog; `defaultbrowser` comes from the Brewfile.
set -euo pipefail

eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

if defaultbrowser | grep -q '^\* *firefox$'; then
  exit 0
fi

echo "==> Making Firefox the default browser (confirm in the dialog)"
defaultbrowser firefox
