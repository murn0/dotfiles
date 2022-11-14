include $(PWD)/bin/colors.mk

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-nvim

install-nvim: ## Install Nvim (https://github.com/neovim/neovim)
	@curl -Lo $(HOME)/nvim-linux64.deb "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb"
	@sudo apt install $(HOME)/nvim-linux64.deb
	@$(RM) $(HOME)/nvim-linux64.deb
	@echo "${BLUE}${BOLD}===> $$(nvim --version)${RESET}"
