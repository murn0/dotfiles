include $(PWD)/install-scripts/colors.mk

MAKEFILE_PATH        := $(shell dirname $(realpath $(dir $(lastword $(MAKEFILE_LIST)))))
DOTFILES_CONFIG_PATH := $(MAKEFILE_PATH)/.config
XDG_CONFIG_HOME_PATH := $(HOME)/.config

EXCLUDES             := .DS_Store .git
FISH_SETTING_FILES   := $(wildcard $(MAKEFILE_PATH)/.config/fish/conf.d/*.fish)
FISH_FUNCTION_FILES   := $(wildcard $(MAKEFILE_PATH)/.config/fish/functions/*.fish)
FISH_MODULES_FILES   := $(wildcard $(MAKEFILE_PATH)/.config/fish/modules/*.fish)
ZSH_SETTING_FILES    := $(wildcard $(MAKEFILE_PATH)/.config/zsh/settings/*.zsh)

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: create-fish-symlinks create-tmux-symlinks create-zsh-symlinks create-starship-symlinks create-erdtree-symlinks

create-fish-symlinks: ## Create symbolic link for fish settings
	@echo "${PURPLE}▓▒░ Create symbolic link for Fish${RESET}"
	@$(foreach val, $(filter-out $(EXCULDES), $(FISH_SETTING_FILES)), ln -fnsv $(abspath $(val)) $(XDG_CONFIG_HOME_PATH)/fish/conf.d/$(notdir $(val));)
	@$(foreach val, $(filter-out $(EXCULDES), $(FISH_FUNCTION_FILES)), ln -fnsv $(abspath $(val)) $(XDG_CONFIG_HOME_PATH)/fish/functions/$(notdir $(val));)
	@mkdir -p $(XDG_CONFIG_HOME_PATH)/fish/modules
	@$(foreach val, $(filter-out $(EXCULDES), $(FISH_MODULES_FILES)), ln -fnsv $(abspath $(val)) $(XDG_CONFIG_HOME_PATH)/fish/modules/$(notdir $(val));)
	@ln -fnsv $(DOTFILES_CONFIG_PATH)/fish/config.fish $(XDG_CONFIG_HOME_PATH)/fish/config.fish
	@ln -fnsv $(DOTFILES_CONFIG_PATH)/fish/fish_plugins $(XDG_CONFIG_HOME_PATH)/fish/fish_plugins

create-tmux-symlinks: ## Create symbolic link for tmux settings
	@echo "${PURPLE}▓▒░ Create symbolic link for tmux${RESET}"
	@mkdir -p $(XDG_CONFIG_HOME_PATH)/tmux
	@ln -fnsv $(DOTFILES_CONFIG_PATH)/tmux/tmux.conf $(XDG_CONFIG_HOME_PATH)/tmux/tmux.conf

create-zsh-symlinks: ## Create symbolic link for Zsh settings
	@echo "${PURPLE}▓▒░ Create symbolic link for Zsh${RESET}"
	@mkdir -p $(XDG_CONFIG_HOME_PATH)/zsh/settings
	@$(foreach val, $(filter-out $(EXCULDES), $(ZSH_SETTING_FILES)), ln -fnsv $(abspath $(val)) $(XDG_CONFIG_HOME_PATH)/zsh/settings/$(notdir $(val));)
	@ln -fnsv $(DOTFILES_CONFIG_PATH)/zsh/.zshrc $(XDG_CONFIG_HOME_PATH)/zsh/.zshrc
	@ln -fnsv $(MAKEFILE_PATH)/.zshenv $(HOME)/.zshenv

create-starship-symlinks: ## Create symbolic link for starship settings
	@echo "${PURPLE}▓▒░ Create symbolic link for Starship${RESET}"
	@ln -fnsv $(DOTFILES_CONFIG_PATH)/starship.toml $(XDG_CONFIG_HOME_PATH)/starship.toml
	
create-erdtree-symlinks: ## Create symbolic link for erdtree settings
	@echo "${PURPLE}▓▒░ Create symbolic link for erdtree${RESET}"
	@mkdir -p $(XDG_CONFIG_HOME_PATH)/erdtree
	@ln -fnsv $(DOTFILES_CONFIG_PATH)/erdtree/.erdtree.toml $(XDG_CONFIG_HOME_PATH)/erdtree/.erdtree.toml