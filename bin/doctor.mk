include $(PWD)/bin/colors.mk

CHECK_COMMANDS := fish starship gh exa tree fd bat fzf zoxide nvim

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