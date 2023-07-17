include $(PWD)/install-scripts/colors.mk

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-iterm2-shell-integration

install-iterm2-shell-integration: ## Install iTerm2 Shell Integration
	@mkdir -p $(HOME)/.config/iterm2
	@curl -Lo $(HOME)/.config/iterm2/.iterm2_shell_integration.fish "https://iterm2.com/shell_integration/fish"