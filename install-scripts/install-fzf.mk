include $(PWD)/bin/colors.mk

FZF_LATEST_VERSION := $(shell curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-fzf

install-fzf: ## Install fzf (https://github.com/junegunn/fzf)
	@curl -Lo $(HOME)/fzf-$(FZF_LATEST_VERSION)-linux_amd64.tar.gz "https://github.com/junegunn/fzf/releases/latest/download/fzf-$(FZF_LATEST_VERSION)-linux_amd64.tar.gz"
	@sudo tar -zxvf $(HOME)/fzf-$(FZF_LATEST_VERSION)-linux_amd64.tar.gz -C /usr/local/bin
	@$(RM) $(HOME)/fzf-$(FZF_LATEST_VERSION)-linux_amd64.tar.gz
	@echo "${BLUE}${BOLD}===> $$(fzf --version)${RESET}"