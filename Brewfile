# GUI apps and fonts. `brew bundle` installs what's missing; chezmoi runs it
# whenever this file changes. Command-line tools go in mise/global.toml.
#
# VS Code and Docker update themselves; `brew upgrade` leaves such casks alone.

cask_args adopt: true   # take over apps already in /Applications

cask "firefox"
cask "visual-studio-code"
cask "docker-desktop"
cask "font-roboto-mono-for-powerline"

brew "defaultbrowser"   # used by the default-browser step

vscode "anthropic.claude-code"
