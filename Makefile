# Variables
MAKEFILE_PATH      := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
INSTALL_SCRIPTS_PATH           := $(MAKEFILE_PATH)/install-scripts
DOTFILES_CONF_PATH := $(if $(XDG_CONFIG_HOME),$(XDG_CONFIG_HOME),$(HOME)/.config)

UNAME_S := $(shell uname -s)
UNAME_P := $(shell uname -p)
ifeq ($(UNAME_S), Linux)
OS_NAME := $(shell grep -e ^ID= /etc/os-release | awk -F'[=]' '{ print $$2 }')
endif

include $(INSTALL_SCRIPTS_PATH)/colors.mk

.DEFAULT_GOAL := help

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

setup: ascii-art install create-symlinks init ## All setup
	@echo "${BLUE}Successfully setup completed! Type${RESET} ${BOLD}fish${RESET} ${BLUE}to start a fish shell and enjoy hacking!${RESET}"

install: ## Install packages
ifeq ($(UNAME_S), Linux)
	@echo "${WHITE}${BOLD}$(UNAME_S) - $(UNAME_P)${RESET}"
	@echo "${WHITE}${BOLD}Distribution is $(OS_NAME)${RESET}"
	@echo "${PURPLE}${BOLD}▓▒░ $(INSTALL_SCRIPTS_PATH)/install-$(OS_NAME).mk を実行します${RESET}"
	@$(MAKE) -f $(INSTALL_SCRIPTS_PATH)/install-$(OS_NAME).mk --no-print-directory
endif
ifeq ($(UNAME_S), Darwin)
	@echo "${WHITE}${BOLD}$(UNAME_S) - $(UNAME_P)${RESET}"
	@echo "${PURPLE}${BOLD}▓▒░ $(INSTALL_SCRIPTS_PATH)/install-macos.mk を実行します${RESET}"
	@$(MAKE) -f $(INSTALL_SCRIPTS_PATH)/install-macos.mk --no-print-directory
endif

create-symlinks: ## Create symbolic links
	@$(MAKE) -f $(INSTALL_SCRIPTS_PATH)/symlinks.mk --no-print-directory

unlinks: ## Unlink symbolic links
	@$(MAKE) -f $(INSTALL_SCRIPTS_PATH)/unlinks.mk --no-print-directory

init: ## Initialize settings
	@echo "${GREEN}▓▒░ Fisher update${RESET}"
	@fish -c 'fisher update'
	@echo "${GREEN}▓▒░ Install all tools globally${RESET}"
	@fish -c '$(HOME)/.local/share/aquaproj-aqua/bin/aqua i -a'

doctor: ## Troubleshooting
	@$(MAKE) -f $(INSTALL_SCRIPTS_PATH)/doctor.mk --no-print-directory

ascii-art: ## Print a ascii-art
	@$(MAKE) -f $(INSTALL_SCRIPTS_PATH)/ascii.mk --no-print-directory

help: ## Help
	@awk 'BEGIN {FS = ":.*##"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-17s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)