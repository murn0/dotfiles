include $(PWD)/bin/colors.mk

MAKEFILE_PATH := $(shell dirname $(realpath $(dir $(lastword $(MAKEFILE_LIST)))))

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-github-cli

install-github-cli: ## Install GithubCLI (https://github.com/cli/cli)
	@sh $(MAKEFILE_PATH)/install-scripts/install-github-cli.sh
	@echo "${BLUE}${BOLD}===> $$(gh --version)${RESET}"