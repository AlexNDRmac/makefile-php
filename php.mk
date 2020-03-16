# ==============================================================================
# This Makefile helps to run various php tools for current project
#
# How-to:
#   1. copy `php.mk` to root of your project
#   2. add `php.mk` to your local or global gitignore
#   3. make -f php.mk <target> <options>
# ==============================================================================

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell


# http://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=PHP%20make
define LOGO
                                                                 
██████╗ ██╗  ██╗██████╗     ███╗   ███╗ █████╗ ██╗  ██╗███████╗
██╔══██╗██║  ██║██╔══██╗    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝
██████╔╝███████║██████╔╝    ██╔████╔██║███████║█████╔╝ █████╗  
██╔═══╝ ██╔══██║██╔═══╝     ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝  
██║     ██║  ██║██║         ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗
╚═╝     ╚═╝  ╚═╝╚═╝         ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
                                                                 
endef

################################################################################
# Colors
# ##############################################################################
Black        := $(shell tput -Txterm setaf 0)
Red          := $(shell tput -Txterm setaf 1)
Green        := $(shell tput -Txterm setaf 2)
Yellow       := $(shell tput -Txterm setaf 3)
LightPurple  := $(shell tput -Txterm setaf 4)
Purple       := $(shell tput -Txterm setaf 5)
Blue         := $(shell tput -Txterm setaf 6)
White        := $(shell tput -Txterm setaf 7)
NC           := $(shell tput -Txterm sgr0)
################################################################################


SHELL := /bin/bash
comma  = ,
space := # <- This Whitespace is Necessary for Substitution
space +=

# Run this makefile help by default
.DEFAULT_GOAL = help

# Determine this Makefile as Main file
THIS_MAKEFILE := $(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))
ARGS := $(filter-out $@, $(MAKECMDGOALS))
# Current Working Dir of Makefile (Full path)
CWD := $(shell cd $(shell dirname $(THIS_MAKEFILE)); pwd)
# Project dir (always current dir from which runs this makefile)
PROJECT_DIR := $(CURDIR)
REPORT_PATH := $(PROJECT_DIR)/storage/logs

## Project specific dirs:
VENDOR_BIN := $(PROJECT_DIR)/vendor/bin

## Tools binary path
PHPCS := $(VENDOR_BIN)/phpcs
PHPMD := $(VENDOR_BIN)/phpmd

## Tools configuration files:
PHPMD_CONFIG := $(shell find -f phpmd.xml* 2>/dev/null | head -n 1)
PHPMD_RULES  := $(if $(PHPMD_CONFIG), $(PROJECT_DIR)/$(PHPMD_CONFIG), "cleancode,codesize,controversial,design,naming,unusedcode")

## Filters for makefile targets:
CHANGED_FILES = $(shell git diff --name-only --diff-filter=ACMR $(BRANCH_BASE) HEAD | grep \.php | paste -sd "," -)
PHPCS_FILTER  = $(if $(filter-out $@, $(ARGS)), $(filter-out $@, $(ARGS)), $(subst $(comma),$(space),$(CHANGED_FILES)))
PHPMD_FILTER  = $(if $(filter-out $@, $(ARGS)), $(filter-out $@, $(ARGS)), $(if $(CHANGED_FILES), $(CHANGED_FILES), .))

.PHONY: help
---: ## --------------------------------------------------------------
phpcs: ## Check Code Style with PHP CodeSniffer [opt.: path]
	$(PHPCS) --version
	$(PHPCS) \
	--report-full=$(REPORT_PATH)/phpcs_report.log \
	--report-diff --report-full $(PHPCS_FILTER) \
	&& echo "$(Green)SUCCSESS!$(NC)" || { echo "$(Red)FAILURE!$(NC)\n${PHPCS_LOG}"; exit 1;}

phpmd: ## Check Code Style with PHP MessDetector [opt.: path]
	$(PHPMD) --version
	echo "config: $(PHPMD_RULES)"
	$(PHPMD) $(strip $(PHPMD_FILTER)) text $(PHPMD_RULES) \
	--reportfile $(REPORT_PATH)/phpmd_report.txt \
	&& echo "$(Green)SUCCSESS!$(NC)" \
	|| (sed 's~$(CURDIR)~.~g' $(REPORT_PATH)/phpmd_report.txt && echo "\n$(Red)FAILURE!$(NC)")

---: ## --------------------------------------------------------------
help: ## Show this help and exit
	echo "$${LOGO}"
	echo "Usage:"
	echo "  make -f $(THIS_MAKEFILE) <target> <target options>"
	echo ''
	echo "Example:"
	echo "  make -f $(THIS_MAKEFILE) phpcs"
	echo "  make -f $(THIS_MAKEFILE) phpmd ./App"
	echo ''
	echo "Targets:"
	echo ''
	grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(THIS_MAKEFILE) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  %-15s %s\n", $$1, $$2}'
	echo ''
%:
	@:
