#!/bin/bash
# Xcode Command Line Tools (git, compilers). Installs through softwareupdate so
# the dialog cannot get lost behind other windows.
set -euo pipefail

if xcode-select -p >/dev/null 2>&1; then
  exit 0
fi

echo "==> Installing Xcode Command Line Tools"
flag=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
touch "$flag"
label=$(softwareupdate -l 2>/dev/null \
  | sed -n 's/^.*Label: \(Command Line Tools.*\)$/\1/p' | tail -n1 || true)
if [[ -n "$label" ]]; then
  sudo softwareupdate -i "$label" --verbose || true
fi
rm -f "$flag"

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Falling back to the installer dialog (it may open BEHIND other windows)"
  xcode-select --install || true
  until xcode-select -p >/dev/null 2>&1; do sleep 5; done
fi
