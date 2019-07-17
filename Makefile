# Determine this Makefile as Main file
THIS_MAKEFILE := $(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))

# =================================================================
include ./.makefiles/includes.mk
include ./.makefiles/colors.mk
include ./.makefiles/functions.mk
# =================================================================

.PHONY: install check-tools help

# Run make help by default
.DEFAULT_GOAL = help

# =================================================================
# Definitions:
# =================================================================

# Current Working Dir (Full path)
CWD = $(shell cd $(shell dirname $(THIS_MAKEFILE)); pwd)
# Full path to `vendor/bin` directory
BIN = $(CWD)/vendor/bin
# Configuration for Tools, source url's
SRC = $(CWD)/.makefiles/.sources.conf

# =================================================================
# Common PHP Tools path
# To add new Tool, just add new line with NAME and PATH
# After adding new PATH, ensure `install` and `check-tools` targets
# =================================================================
PHPUNIT    := $(BIN)/phpunit
PHPCS      := $(BIN)/phpcs
PHPMD      := $(BIN)/phpmd
PHPMETRICS := $(BIN)/phpmetrics
INFECTION  := $(BIN)/infection


# =================================================================
# Makefile Targets:
# =================================================================

---: ## --------------------------------------------------------------
install: ## Install all PHP Tools (skip existing tools in ./vendor/bin)
	$(call install_phar,$(PHPUNIT),$(call config,PHPUNIT,$(SRC)))
	$(call install_phar,$(PHPCS),$(call config,PHPCS,$(SRC)))
	$(call install_phar,$(PHPMD),$(call config,PHPMD,$(SRC)))
	$(call install_phar,$(PHPMETRICS),$(call config,PHPMETRICS,$(SRC)))
	$(call install_phar,$(INFECTION),$(call config,INFECTION,$(SRC)))

check-tools: ## Check all Tools
	$(call check_tools,$(shell which php))
	$(call check_tools,$(PHPUNIT))
	$(call check_tools,$(PHPCS))
	$(call check_tools,$(PHPMD))
	$(call check_tools,$(PHPMETRICS))
	$(call check_tools,$(INFECTION))

---: ## --------------------------------------------------------------
help: .logo ## Show this help and exit
	@echo "$(Yellow)Usage:$(NC)\n  make [target] [arguments]"
	@echo ''
	@echo "$(Yellow)Targets:$(NC)"
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(THIS_MAKEFILE) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  $(Cyan)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ''
%:
	@:

