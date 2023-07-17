include $(PWD)/install-scripts/colors.mk

CHECK_COMMANDS := fish bat dog erd exa fd fzf gh nvim starship zoxide

all: $(CHECK_COMMANDS)

define TEMPLATE
$(1):
ifeq ($(shell which $1), )
	@echo "${RED}${BOLD}===> $1 が見つかりません${RESET}"
else
	@echo "${BLUE}${BOLD}===> $(shell $1 --version)${RESET}"
endif
endef

$(foreach task, $(CHECK_COMMANDS), $(eval $(call TEMPLATE,$(task))))