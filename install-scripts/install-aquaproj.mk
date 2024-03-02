include $(PWD)/install-scripts/colors.mk

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-aqua

install-aqua: ## Install aqua (https://github.com/aquaproj/aqua)
	@curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.3.0/aqua-installer
	@echo "411caf1b5fcef4f5e74aa2a9fe99182ea13ab93ecd8ed4a983a7cff9f08edab9  aqua-installer" | sha256sum -c
	@chmod +x aqua-installer
	@./aqua-installer -v v2.23.2
	@$(RM) ./aqua-installer