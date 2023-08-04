# My dotfiles
## Instalation
```
curl -sL https://raw.githubusercontent.com/murn0/dotfiles/master/install.sh | sh
```
## Shell
- fish shell (https://fishshell.com/)

## Fish shell plugin management
- fisher (https://github.com/jorgebucaran/fisher)
    - fzf.fish (https://github.com/PatrickF1/fzf.fish)
        - ⚠️ Attention to the version of dependent packages: `fish`,`fzf`,`fd`,`bat` (https://github.com/PatrickF1/fzf.fish#installation)

## Font
- Nerd Fonts (https://www.nerdfonts.com/)
    - HackGen (https://github.com/yuru7/HackGen)

## Prompt
- starship (https://starship.rs/)

## Install packages
- GithubCLI (https://github.com/cli/cli)
- exa (https://github.com/ogham/exa)
- erdtree (https://github.com/solidiquis/erdtree)
- fd (https://github.com/sharkdp/fd)
- bat (https://github.com/sharkdp/bat)
- fzf (https://github.com/junegunn/fzf)
- zoxide (https://github.com/ajeetdsouza/zoxide)
- dog (https://github.com/ogham/dog)
- neovim (https://github.com/neovim/neovim)
- lazygit (https://github.com/jesseduffield/lazygit)

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
- `Ctrl+l` : Git log search
- `Ctrl+c` : `cd` with interactive selection (using `zoxide`)

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