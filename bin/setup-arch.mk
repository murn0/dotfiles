include $(PWD)/bin/colors.mk

.PHONY: install-fish install-fisher install-bobthefish install-exa install-peco

all: install-fish install-fisher install-bobthefish install-exa install-peco

install-fish: ## Install fish shell (https://fishshell.com/)
	@if type fish >/dev/null 2>&1; then \
		echo "${GREEN}===> command found: fish${RESET}"; \
		fish -v; \
	else \
		echo "${YELLOW}▓▒░ Installing fish${RESET}"; \
		pacman -S fish; \
	fi

install-fisher: SHELL := /usr/sbin/fish
install-fisher: ## Install fisher (https://github.com/jorgebucaran/fisher)
	@if type -q fisher; \
		echo "${GREEN}===> command found: fisher${RESET}"; \
		fisher -v; \
	else; \
		echo "${YELLOW}▓▒░ Installing fisher${RESET}"; \
		curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; \
	end

install-bobthefish: SHELL := /usr/sbin/fish
install-bobthefish: ## Install theme oh-my-fish/theme-bobthefish (https://github.com/oh-my-fish/theme-bobthefish)
	@echo "${YELLOW}▓▒░ Installing oh-my-fish/theme-bobthefish${RESET}"
	@fisher install oh-my-fish/theme-bobthefish

install-exa: ## Install exa plugin (https://the.exa.website/)
	@if type exa >/dev/null 2>&1; then \
		echo "${GREEN}===> command found: exa${RESET}"; \
		exa -v; \
	else \
		echo "${YELLOW}▓▒░ Installing exa${RESET}"; \
		pacman -S exa; \
	fi

install-peco: ## Install peco plugin (https://github.com/peco/peco)
	@if type peco >/dev/null 2>&1; then \
		echo "${GREEN}===> command found: peco${RESET}"; \
		peco --version; \
	else \
		echo "${YELLOW}▓▒░ Installing peco${RESET}"; \
		pacman -Syu peco; \
	fi
