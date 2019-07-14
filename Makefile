# Determine this Makefile as Main file
THIS_MAKEFILE := $(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))

# =================================================================
include ./.makefiles/includes.mk
include ./.makefiles/colors.mk
# =================================================================

.PHONY: help checks

# Run make help by default
.DEFAULT_GOAL = help


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

check-tools: ## Check all Tools
	php --version
