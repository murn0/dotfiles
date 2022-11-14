include $(PWD)/bin/colors.mk

EXA_LATEST_VERSION := $(shell curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-exa

install-exa: ## Install exa (https://github.com/ogham/exa)
	@curl -Lo $(HOME)/exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-musl-v$(EXA_LATEST_VERSION).zip"
	@sudo unzip -o $(HOME)/exa.zip bin/exa -d /usr/local
	@$(RM) $(HOME)/exa.zip
	@echo "${BLUE}${BOLD}===> $$(exa --version)${RESET}"