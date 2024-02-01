# My dotfiles
## Instalation
```
curl -sL https://raw.githubusercontent.com/murn0/dotfiles/master/install.sh | sh
```
## Shell
- fish shell (https://github.com/fish-shell/fish-shell) `3.7.0`

## Fish shell plugin management
- fisher (https://github.com/jorgebucaran/fisher) `v4.4.4`
    - fzf.fish (https://github.com/PatrickF1/fzf.fish) `v10.2`
        - ⚠️ Attention to the version of dependent packages: `fish`,`fzf`,`fd`,`bat` (https://github.com/PatrickF1/fzf.fish#installation)

## Font
- Nerd Fonts (https://www.nerdfonts.com/)
    - HackGen (https://github.com/yuru7/HackGen) `v2.9.0`

## Prompt
- starship (https://github.com/starship/starship) `v1.17.1`

## Install packages
- bat (https://github.com/sharkdp/bat) `v0.24.0`
- delta (https://github.com/dandavison/delta) `v0.16.5`
- dog (https://github.com/ogham/dog) `0.1.0`
- erdtree (https://github.com/solidiquis/erdtree) `v3.1.2`
- exa (https://github.com/ogham/exa) `v0.10.1`
- fd (https://github.com/sharkdp/fd) `v8.7.1`
- fzf (https://github.com/junegunn/fzf) `0.46.1`
- gh-dash (https://github.com/dlvhdr/gh-dash) `v3.11.1`
- GithubCLI (https://github.com/cli/cli) `v2.43.1`
- lazygit (https://github.com/jesseduffield/lazygit) `v0.40.2`
- neovim (https://github.com/neovim/neovim) `v0.9.5`
- zoxide (https://github.com/ajeetdsouza/zoxide) `v0.9.2`

## Makefile task
Running the `make` command will display help
- `make setup` - All setup. also run this command to update
- `make doctor` - Check if the package has been successfully installed
- `make create-symlinks` - Create all symbolic link
- `make unlinks` - Unlink all symbolic link

## Key bindings
- `Ctrl+r` : History search
- `Ctrl+f` : Directory search (using `fd`)
- `Ctrl+v` : Variable search
- `Ctrl+g` : Git log search
- `Ctrl+z` : `cd` with interactive selection (using `zoxide`)

## Requires
⚠️For MacOS, please install Homebrew first

## Codespaces
You can also start **Github Codespaces** and try it out
```
cd ~/.dotfiles
make setup

...

Successfully setup completed! Type fish to start a fish shell and enjoy hacking!

fish
```