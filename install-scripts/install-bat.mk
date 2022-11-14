include $(PWD)/bin/colors.mk

BAT_LATEST_VERSION := $(shell curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-bat

install-bat: ## Install bat (https://github.com/sharkdp/bat) ⚠️最新版をインストールしているがパッケージ名が衝突する問題もある(https://github.com/sharkdp/bat#on-ubuntu-using-apt)
	@curl -Lo $(HOME)/bat_$(BAT_LATEST_VERSION)_amd64.deb "https://github.com/sharkdp/bat/releases/latest/download/bat_$(BAT_LATEST_VERSION)_amd64.deb"
	@sudo dpkg -i $(HOME)/bat_$(BAT_LATEST_VERSION)_amd64.deb
	@$(RM) $(HOME)/bat_$(BAT_LATEST_VERSION)_amd64.deb
	@echo "${BLUE}${BOLD}===> $$(bat --version)${RESET}"