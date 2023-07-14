include $(PWD)/bin/colors.mk

MAKEFILE_PATH := $(shell dirname $(realpath $(dir $(lastword $(MAKEFILE_LIST)))))
INSTALL_SCRIPTS := $(MAKEFILE_PATH)/install-scripts

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-Brewfile install-packages

install-Brewfile: ## Install Brewfile bundle (https://github.com/Homebrew/homebrew-bundle)
	@/opt/homebrew/bin/brew bundle --file=$(MAKEFILE_PATH)/.Brewfile

PACKAGES := iterm2-shell-integration aquaproj
define PACKAGE_TEMPLATE
$(1):
	@echo "${YELLOW}▓▒░ Installing $1 ${RESET}"
	@$(MAKE) -f $(INSTALL_SCRIPTS)/install-$1.mk --no-print-directory
endef
$(foreach package, $(PACKAGES), $(eval $(call PACKAGE_TEMPLATE,$(package))))

install-packages: $(PACKAGES) ## Install all packages