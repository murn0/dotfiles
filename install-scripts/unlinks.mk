include $(PWD)/install-scripts/colors.mk

MAKEFILE_PATH        := $(shell dirname $(realpath $(dir $(lastword $(MAKEFILE_LIST)))))
XDG_CONFIG_HOME_PATH := $(HOME)/.config

FISH_SETTING_DIR   := $(XDG_CONFIG_HOME_PATH)/fish/conf.d
FISH_FUNCTION_DIR   := $(XDG_CONFIG_HOME_PATH)/fish/functions
FISH_MODULES_DIR	:= $(XDG_CONFIG_HOME_PATH)/fish/modules
ZSH_SETTING_DIR    := $(XDG_CONFIG_HOME_PATH)/zsh/settings

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: unlink-fish-symlinks \
	unlink-tmux-symlinks \
	unlink-zsh-symlinks \
	unlink-starship-symlinks \
	unlink-erdtree-symlinks \
	unlink-lazygit-symlinks \
	unlink-wezterm-symlinks \
	unlink-gh-dash-symlinks

unlink-fish-symlinks: ## Unlink symbolic link for fish settings
	@echo "${RED}▓▒░ Unlink symbolic link for Fish${RESET}"
	@find $(FISH_SETTING_DIR) -name "*.fish" -type l -exec unlink {} \;
	@find $(FISH_FUNCTION_DIR) -name "*.fish" -type l -exec unlink {} \;
	@find $(FISH_MODULES_DIR) -name "*.fish" -type l -exec unlink {} \;
	@unlink $(XDG_CONFIG_HOME_PATH)/fish/config.fish
	@unlink $(XDG_CONFIG_HOME_PATH)/fish/fish_plugins

unlink-tmux-symlinks: ## Unlink symbolic link for tmux settings
	@echo "${RED}▓▒░ Unlink symbolic link for tmux${RESET}"
	@unlink $(XDG_CONFIG_HOME_PATH)/tmux/tmux.conf

unlink-zsh-symlinks: ## Unlink symbolic link for Zsh settings
	@echo "${RED}▓▒░ Unlink symbolic link for Zsh${RESET}"
	@find $(ZSH_SETTING_DIR) -name "*.zsh" -type l -exec unlink {} \;
	@unlink $(XDG_CONFIG_HOME_PATH)/zsh/.zshrc
	@unlink $(HOME)/.zshenv

unlink-starship-symlinks: ## Unlink symbolic link for starship settings
	@echo "${RED}▓▒░ Unlink symbolic link for Starship${RESET}"
	@unlink $(XDG_CONFIG_HOME_PATH)/starship.toml
	
unlink-erdtree-symlinks: ## Unlink symbolic link for erdtree settings
	@echo "${RED}▓▒░ Unlink symbolic link for erdtree${RESET}"
	@unlink $(XDG_CONFIG_HOME_PATH)/erdtree/.erdtree.toml

unlink-lazygit-symlinks: ## Unlink symbolic link for lazygit settings
	@echo "${RED}▓▒░ Unlink symbolic link for lazygit${RESET}"
	@unlink $(XDG_CONFIG_HOME_PATH)/lazygit/config.yml

unlink-wezterm-symlinks: ## Unlink symbolic link for wezterm settings
	@echo "${RED}▓▒░ Unlink symbolic link for wezterm${RESET}"
	@unlink $(XDG_CONFIG_HOME_PATH)/wezterm/wezterm.lua

unlink-gh-dash-symlinks: ## Unlink symbolic link for gh-dash settings
	@echo "${RED}▓▒░ Unlink symbolic link for gh-dash${RESET}"
	@unlink $(XDG_CONFIG_HOME_PATH)/gh-dash/config.yml