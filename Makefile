# Variables
DOTFILES_CONF_PATH := $(if $(XDG_CONFIG_HOME),$(XDG_CONFIG_HOME),$(HOME)/.config)

include $(PWD)/bin/colors.mk
	
.PHONY: ascii-art setup-arch copy-config-files help

ascii-art: ## Print a ascii-art
	@$(MAKE) -f $(PWD)/bin/ascii.mk --no-print-directory

setup-arch: ascii-art ## Setup arch linux
	@$(MAKE) -f $(PWD)/bin/setup-arch.mk --no-print-directory
	@$(MAKE) copy-config-files --no-print-directory
	@echo "${BLUE}Successfully setup completed! Type${RESET} ${BOLD}fish${RESET} ${BLUE}to start a fish shell and enjoy hacking!${RESET}"

copy-config-files: ## Copy config files.
	@cp -rf $(PWD)/.config/fish/conf.d/. $(DOTFILES_CONF_PATH)/fish/conf.d/ 

help: ascii-art ## Help
	@awk 'BEGIN {FS = ":.*##"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-17s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help