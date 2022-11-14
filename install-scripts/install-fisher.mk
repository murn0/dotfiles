include $(PWD)/bin/colors.mk

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-fisher

install-fisher: ## Install fisher (https://github.com/jorgebucaran/fisher)
	@echo "${YELLOW}▓▒░ Installing fisher${RESET}"
	@fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher';
	@echo "${BLUE}${BOLD}===> $$(fish -c 'fisher -v')${RESET}"