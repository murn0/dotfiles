include $(PWD)/bin/colors.mk

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-zoxide

install-zoxide: ## Install zoxide (https://github.com/ajeetdsouza/zoxide)
	@curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
	@echo "${BLUE}${BOLD}===> $$(zoxide --version)${RESET}"