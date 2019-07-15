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

# Common PHP Tools path
PHPUNIT   := $(BIN)/phpunit
PHPCS     := $(BIN)/phpcs
PHPMD     := $(BIN)/phpmd
METRICS   := $(BIN)/phpmetrics
INFECTION := $(BIN)/infection

install: ## Install all PHP Tools (skip existing tools in ./vendor/bin)
	$(call install_phar,$(INFECTION),https://github.com/infection/infection/releases/download/0.13.1/infection.phar)
	$(call install_phar,$(PHPUNIT),https://phar.phpunit.de/phpunit-8.phar)

check-tools: ## Check all Tools
	php --version
	$(INFECTION) --version

---: ## ------------------------------------------------------------------------
help: ## Show this help and exit
	@echo "$(Yellow)Usage:$(NC)\n  make [target] [arguments]"
	@echo ''
	@echo "$(Yellow)Available targets:$(NC)"
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(THIS_MAKEFILE) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  $(Cyan)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ''
%:
	@:

