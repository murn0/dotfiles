include $(PWD)/bin/colors.mk

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-starship

install-starship: ## Install starship (https://starship.rs/)
	@curl -sS https://starship.rs/install.sh | sh -s -- --yes
	@echo "${BLUE}${BOLD}===> $$(starship --version)${RESET}"