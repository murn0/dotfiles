include $(PWD)/bin/colors.mk

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-aqua

install-aqua: ## Install aqua (https://github.com/aquaproj/aqua)
	@curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.1.1/aqua-installer
	@echo "c2af02bdd15da6794f9c98db40332c804224930212f553a805425441f8331665  aqua-installer" | sha256sum -c
	@chmod +x aqua-installer
	@./aqua-installer -v v2.4.1
	@$(RM) ./aqua-installer