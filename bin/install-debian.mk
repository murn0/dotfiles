include $(PWD)/bin/colors.mk

MAKEFILE_PATH := $(shell dirname $(realpath $(dir $(lastword $(MAKEFILE_LIST)))))
INSTALL_SCRIPTS := $(MAKEFILE_PATH)/install-scripts

VERSION_CODENAME := $(shell grep -e ^VERSION_CODENAME= /etc/os-release | awk -F'[=]' '{ print $$2 }')

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-fish install-fisher install-packages

install-fish: ## Install fish shell (https://fishshell.com/)
ifeq ($(VERSION_CODENAME), stretch)
	@echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_9.0/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
	@curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_9.0/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
else ifeq ($(VERSION_CODENAME), buster)
	@echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
	@curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
else ifeq ($(VERSION_CODENAME), bullseye)
	@echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
	@curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
endif
	@sudo apt update
	@sudo apt -y install --no-install-recommends fish;
	@echo "${BLUE}${BOLD}===> $$(fish -v)${RESET}"
	
install-fisher: ## Install fisher (https://github.com/jorgebucaran/fisher)
	@$(MAKE) -f $(INSTALL_SCRIPTS)/install-fisher.mk --no-print-directory

PACKAGES := iterm2-shell-integration aquaproj
define PACKAGE_TEMPLATE
$(1):
	@echo "${YELLOW}▓▒░ Installing $1 ${RESET}"
	@$(MAKE) -f $(INSTALL_SCRIPTS)/install-$1.mk --no-print-directory
endef
$(foreach package, $(PACKAGES), $(eval $(call PACKAGE_TEMPLATE,$(package))))

install-packages: $(PACKAGES) ## Install all packages