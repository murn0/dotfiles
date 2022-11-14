include $(PWD)/bin/colors.mk

.PHONY: $(shell cat $(MAKEFILE_LIST) | awk -F':' '/^[a-z0-9_-]+:/ {print $$1}')

all: install-tree

install-tree: ## Install tree (http://mama.indstate.edu/users/ice/tree/)
	@sudo apt update
	@sudo apt install -y tree
	@echo "${BLUE}${BOLD}===> $$(tree --version)${RESET}"