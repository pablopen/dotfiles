# dotfiles

My Mac setup, managed with [chezmoi](https://chezmoi.io): shell, Terminal profiles, SSH key for GitHub, apps, command-line tools and their config.

- **Homebrew** installs GUI apps and fonts (`Brewfile`)
- **mise** installs command-line tools and project runtimes (`mise/global.toml`)

## Requirements

- A Mac with an administrator account (Homebrew and the Command Line Tools ask for the password).
- The Xcode Command Line Tools, which provide `git`. The setup installs them if missing; to do it by hand first, the command is:

  ```sh
  xcode-select --install
  ```

Nothing else: no Homebrew, no git clone. The one-liner below takes care of both.

## New Mac

1. Open Terminal and run:

   ```sh
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply pablopen
   ```

2. Answer the prompts as they come: password for the Command Line Tools, password for Homebrew, the Firefox default-browser dialog, a passphrase for the new SSH key, then paste the key (already on the clipboard) into the GitHub page that opens and press Enter. Everything after that runs on its own.

3. Open a new Terminal window. Open Docker Desktop once; it finishes its own setup.

4. Point the repo at SSH so you can push:

   ```sh
   chezmoi cd
   git remote set-url origin git@github.com:pablopen/dotfiles.git
   ```

## Day to day

```sh
chezmoi diff            # what would change
chezmoi apply           # make it so
chezmoi edit ~/.zshrc   # edit the source copy, then apply
chezmoi cd              # go to the repo to commit
chezmoi update          # pull and apply
```

Apps update themselves. `mise upgrade` updates the command-line tools; `chezmoi upgrade` updates chezmoi.

Config files (`~/.zshrc`, `~/.gitconfig`, `~/.ssh/config`, mise and VS Code settings) come from the repo. If one was edited in place (by hand or by an installer), `chezmoi status` marks it `M` and `chezmoi apply` asks before touching it. To keep the local edit, `chezmoi re-add <file>` copies it into the repo (for the templated `.zshrc` and `.gitconfig`, paste the lines from `chezmoi diff` into the template instead).

## Adding things

- **An app**: a `cask` line in `Brewfile` (names at [formulae.brew.sh](https://formulae.brew.sh/cask/)).
- **A command-line tool**: a line in `mise/global.toml`. If mise's registry entry is broken, `"github:owner/repo" = "latest"` fetches the binary from its GitHub releases.
- **A Terminal profile**: drop the `.terminal` file in `terminal/`; all of them are imported, and `.chezmoidata.toml` names the default.
- **An install step**: a script in `chezmoi/.chezmoiscripts/`, numbered for its place in the order.

## Credits

- Solarized Dark profile from [newelldev/macos-terminal-solarized](https://github.com/newelldev/macos-terminal-solarized), built on [Ethan Schoonover's palette](https://ethanschoonover.com/solarized/); font, bold and blink settings changed.
- Selenized by [Jan Warchol](https://github.com/jan-warchol/selenized).
- Fonts from [powerline/fonts](https://github.com/powerline/fonts).
