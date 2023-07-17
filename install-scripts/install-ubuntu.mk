include $(PWD)/install-scripts/colors.mk

MAKEFILE_PATH := $(shell dirname $(realpath $(dir $(lastword $(MAKEFILE_LIST)))))
INSTALL_SCRIPTS := $(MAKEFILE_PATH)/install-scripts

VERSION_CODENAME := $(shell grep -e ^VERSION_CODENAME= /etc/os-release | awk -F'[=]' '{ print $$2 }')

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-fish install-fisher install-packages

install-fish: ## Install fish shell (https://fishshell.com/)
	@echo "${YELLOW}▓▒░ Installing fish shell${RESET}"
	@sudo apt update
	@sudo apt-get install -y software-properties-common
	@sudo apt-add-repository -y ppa:fish-shell/release-3
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