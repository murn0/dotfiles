include $(PWD)/bin/colors.mk

MAKEFILE_PATH := $(shell dirname $(realpath $(dir $(lastword $(MAKEFILE_LIST)))))

OS_NAME := $(shell grep -e ^ID= /etc/os-release | awk -F'[=]' '{ print $$2 }')
VERSION_CODENAME := $(shell grep -e ^VERSION_CODENAME= /etc/os-release | awk -F'[=]' '{ print $$2 }')

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-fish install-fisher install-packages

install-fish: ## Install fish shell (https://fishshell.com/)
ifeq ($(OS_NAME), ubuntu)
	@echo "${YELLOW}▓▒░ Installing fish shell${RESET}"
	@sudo apt update
	@sudo apt-get install -y software-properties-common
	@sudo apt-add-repository -y ppa:fish-shell/release-3
	@sudo apt -y install --no-install-recommends fish;
else ifeq ($(OS_NAME), debian)
ifeq ($(VERSION_CODENAME), stretch)
	@echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_9.0/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
	@curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_9.0/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
else ifeq ($(VERSION_CODENAME), buster)
	@echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
	@curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
else ifeq ($(VERSION_CODENAME), bullseye)
	@echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
	@curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
endif
	@sudo apt update
	@sudo apt -y install --no-install-recommends fish;
endif
	@echo "${BLUE}${BOLD}===> $$(fish -v)${RESET}"
	
install-fisher: ## Install fisher (https://github.com/jorgebucaran/fisher)
	@echo "${YELLOW}▓▒░ Installing fisher${RESET}"
	@fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher';
	@echo "${BLUE}${BOLD}===> $$(fish -c 'fisher -v')${RESET}"

install-packages: install-starship \
install-github-cli \
install-exa \
install-tree \
install-fd \
install-bat \
install-fzf \
install-zoxide \
install-nvim \
install-iterm2-shell-integration

install-starship: ## Install starship (https://starship.rs/)
	@curl -sS https://starship.rs/install.sh | sh -s -- --yes
	@echo "${BLUE}${BOLD}===> $$(starship --version)${RESET}"

install-github-cli: ## Install GithubCLI (https://github.com/cli/cli)
	@sh $(MAKEFILE_PATH)/install-scripts/install-github-cli.sh
	@echo "${BLUE}${BOLD}===> $$(gh --version)${RESET}"

EXA_LATEST_VERSION := $(shell curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
install-exa: ## Install exa (https://github.com/ogham/exa)
	@curl -Lo $(HOME)/exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-musl-v$(EXA_LATEST_VERSION).zip"
	@sudo unzip -o $(HOME)/exa.zip bin/exa -d /usr/local
	@$(RM) $(HOME)/exa.zip
	@echo "${BLUE}${BOLD}===> $$(exa --version)${RESET}"

install-tree: ## Install tree (http://mama.indstate.edu/users/ice/tree/)
	@sudo apt update
	@sudo apt install -y tree
	@echo "${BLUE}${BOLD}===> $$(tree --version)${RESET}"

FD_LATEST_VERSION := $(shell curl -s "https://api.github.com/repos/sharkdp/fd/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
install-fd: ## Install fd (https://github.com/sharkdp/fd) ⚠️最新版をインストールしているがパッケージ名が衝突する問題もある(https://github.com/sharkdp/fd#on-ubuntu)
	@curl -Lo $(HOME)/fd_$(FD_LATEST_VERSION)_amd64.deb "https://github.com/sharkdp/fd/releases/latest/download/fd_$(FD_LATEST_VERSION)_amd64.deb"
	@sudo dpkg -i $(HOME)/fd_$(FD_LATEST_VERSION)_amd64.deb
	@echo "${BLUE}${BOLD}===> $$(fd --version)${RESET}"

BAT_LATEST_VERSION := $(shell curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
install-bat: ## Install bat (https://github.com/sharkdp/bat) ⚠️最新版をインストールしているがパッケージ名が衝突する問題もある(https://github.com/sharkdp/bat#on-ubuntu-using-apt)
	@curl -Lo $(HOME)/bat_$(BAT_LATEST_VERSION)_amd64.deb "https://github.com/sharkdp/bat/releases/latest/download/bat_$(BAT_LATEST_VERSION)_amd64.deb"
	@sudo dpkg -i $(HOME)/bat_$(BAT_LATEST_VERSION)_amd64.deb
	@echo "${BLUE}${BOLD}===> $$(bat --version)${RESET}"

FZF_LATEST_VERSION := $(shell curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
install-fzf: ## Install fzf (https://github.com/junegunn/fzf)
	@curl -Lo $(HOME)/fzf-$(FZF_LATEST_VERSION)-linux_amd64.tar.gz "https://github.com/junegunn/fzf/releases/latest/download/fzf-$(FZF_LATEST_VERSION)-linux_amd64.tar.gz"
	@sudo tar -zxvf $(HOME)/fzf-$(FZF_LATEST_VERSION)-linux_amd64.tar.gz -C /usr/local/bin
	@$(RM) $(HOME)/fzf-$(FZF_LATEST_VERSION)-linux_amd64.tar.gz
	@echo "${BLUE}${BOLD}===> $$(fzf --version)${RESET}"

install-zoxide: ## Install zoxide (https://github.com/ajeetdsouza/zoxide)
	@curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
	@echo "${BLUE}${BOLD}===> $$(zoxide --version)${RESET}"

install-nvim: ## Install Nvim (https://github.com/neovim/neovim)
	@curl -Lo $(HOME)/nvim-linux64.deb "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb"
	@sudo apt install $(HOME)/nvim-linux64.deb
	@$(RM) $(HOME)/nvim-linux64.deb
	@echo "${BLUE}${BOLD}===> $$(nvim --version)${RESET}"

install-iterm2-shell-integration: ## Install iTerm2 Shell Integration
	@mkdir $(HOME)/.config/iterm2
	@curl -Lo $(HOME)/.config/iterm2/.iterm2_shell_integration.fish "https://iterm2.com/shell_integration/fish"