include $(PWD)/bin/colors.mk

FD_LATEST_VERSION := $(shell curl -s "https://api.github.com/repos/sharkdp/fd/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-fd

install-fd: ## Install fd (https://github.com/sharkdp/fd) ⚠️最新版をインストールしているがパッケージ名が衝突する問題もある(https://github.com/sharkdp/fd#on-ubuntu)
	@curl -Lo $(HOME)/fd_$(FD_LATEST_VERSION)_amd64.deb "https://github.com/sharkdp/fd/releases/latest/download/fd_$(FD_LATEST_VERSION)_amd64.deb"
	@sudo dpkg -i $(HOME)/fd_$(FD_LATEST_VERSION)_amd64.deb
	@$(RM) $(HOME)/fd_$(FD_LATEST_VERSION)_amd64.deb
	@echo "${BLUE}${BOLD}===> $$(fd --version)${RESET}"