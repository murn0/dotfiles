include $(PWD)/bin/colors.mk

MAKEFILE_PATH := $(shell dirname $(realpath $(dir $(lastword $(MAKEFILE_LIST)))))
INSTALL_SCRIPTS := $(MAKEFILE_PATH)/install-scripts

OS_NAME := $(shell grep -e ^ID= /etc/os-release | awk -F'[=]' '{ print $$2 }')
VERSION_CODENAME := $(shell grep -e ^VERSION_CODENAME= /etc/os-release | awk -F'[=]' '{ print $$2 }')

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-fish install-fisher install-packages

install-fish: ## Install fish shell (https://fishshell.com/)
ifeq ($(OS_NAME), ubuntu)
	@echo "${YELLOW}▓▒░ Installing fish shell${RESET}"
	@sudo apt update
	@sudo apt-get install -y software-properties-common
	@sudo apt-add-repository -y ppa:fish-shell/release-3
	@sudo apt -y install --no-install-recommends fish;
else ifeq ($(OS_NAME), debian)
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
endif
	@echo "${BLUE}${BOLD}===> $$(fish -v)${RESET}"
	
install-fisher: ## Install fisher (https://github.com/jorgebucaran/fisher)
	@$(MAKE) -f $(INSTALL_SCRIPTS)/install-fisher.mk --no-print-directory


PACKAGES := starship github-cli exa tree fd bat fzf zoxide nvim iterm2-shell-integration
define PACKAGE_TEMPLATE
$(1):
	@$(MAKE) -f $(INSTALL_SCRIPTS)/install-$1.mk --no-print-directory
endef
$(foreach package, $(PACKAGES), $(eval $(call PACKAGE_TEMPLATE,$(package))))

install-packages: $(PACKAGES) ## Install all packages