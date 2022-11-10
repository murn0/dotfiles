# My dotfiles
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
- tree (http://mama.indstate.edu/users/ice/tree/)
- fd (https://github.com/sharkdp/fd)
- bat (https://github.com/sharkdp/bat)
- fzf (https://github.com/junegunn/fzf)
- zoxide (https://github.com/ajeetdsouza/zoxide)

## Makefile task
Running the `make` command will display help
- `make setup` - All setup. also run this command to update
- `make doctor` - Check if the package has been successfully installed

## Key bindings
- `Ctrl+r` : History search
- `Ctrl+s` : Directory search (using `fd`)
- `Ctrl+v` : Variable search
- `Ctrl+g` : Git log search
- `Ctrl+c` : `cd` with interactive selection (using `zoxide`)

## Codespaces
You can also start **Github Codespaces** and try it out
```
cd /workspaces/dotfiles
make setup

...

Successfully setup completed! Type fish to start a fish shell and enjoy hacking!

fish
```