APP_NAME = PHP Project Template

SHELL ?= /bin/bash
# Determine this Makefile as Main file
THIS_MAKEFILE := $(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))
ARGS = $(filter-out $@,$(MAKECMDGOALS))

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
Makefile: ;              # skip prerequisite discovery

# Run make help by default
.DEFAULT_GOAL = help

ifneq ("$(wildcard ./VERSION)","")
VERSION ?= $(shell cat ./VERSION | head -n 1)
else
VERSION ?= 0.0.0
endif

# Public targets

.PHONY: .title
.title:
	$(info $(APP_NAME) v$(VERSION))

---: ## ----------------------------------------------------
.PHONY: phpcs
phpcs: ## Run PHP_CodeSniffer inspection
	./vendor/bin/phpcs --version
	./vendor/bin/phpcs

.PHONY: phpmd
phpmd: ## Run PHP Mess Detector inspection
	./vendor/bin/phpmd --version
	./vendor/bin/phpmd /src,/tests text phpmd.xml.dist

.PHONY: tests
tests: ## Run PHPUnit tests
	./vendor/bin/phpunit
	cat storage/logs/coverage-summary.txt

.PHONY: infection
infection: ## PHP Mutation Testing
	./vendor/bin/infection

---: ## ----------------------------------------------------
.PHONY: help
help: .title ## Show this help and exit
	echo ''
	echo 'Usage: make <target> [ENV_VAR=VALUE ...]'
	echo ''
	echo 'Available targets:'
	echo ''
	grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(THIS_MAKEFILE) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  %-15s %s\n", $$1, $$2}'
	echo ''
%:
	@:
