APP_NAME = PHP Project Template

SHELL ?= /bin/bash
PARALLELISM := $(shell getconf _NPROCESSORS_ONLN)
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

OUTPUT_DIR := storage/logs

# Public targets

.PHONY: .title
.title:
	$(info $(APP_NAME) v$(VERSION))

---: ## ----------------------------------------------------
.PHONY: phpcs
phpcs: ## Run PHP_CodeSniffer inspection
	./vendor/bin/phpcs --version
	./vendor/bin/phpcs $(CLI_OPTIONS)

.PHONY: phpmd
phpmd: ## Run PHP Mess Detector inspection
	./vendor/bin/phpmd --version
	
	FORMAT=text
	if [ "$(GITHUB_ACTIONS)" == "true" ]; then FORMAT=github; fi
	
	./vendor/bin/phpmd ./src $${FORMAT} phpmd.xml.dist $(CLI_OPTIONS)

.PHONY: tests
tests: ## Run PHPUnit tests
	./vendor/bin/phpunit $(CLI_OPTIONS)
	cat $(OUTPUT_DIR)/coverage-summary.txt

.PHONY: infection
infection: ## PHP Mutation Testing
	./vendor/bin/infection --threads=$(PARALLELISM) \
		--coverage=$(OUTPUT_DIR) $(CLI_OPTIONS)
	echo "See detailed reports: ./$(OUTPUT_DIR)"
	ls ./$(OUTPUT_DIR)/ | grep infection

---: ## ----------------------------------------------------

.PHONY: metrics
metrics: ## Generate PHP Metrics HTML report
	./vendor/bin/phpmetrics --version
	./vendor/bin/phpmetrics \
		--config=phpmetrics.json \
		--junit=$(OUTPUT_DIR)/junit.xml

---: ## ----------------------------------------------------
.PHONY: help
help: .title ## Show this help and exit
	echo ''
	echo 'Usage: make <target> [ENV_VAR=VALUE ...] [CLI_OPTIONS="--tool-cli-args"]'
	echo ''
	echo 'Available targets:'
	echo ''
	grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(THIS_MAKEFILE) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  %-15s %s\n", $$1, $$2}'
	echo ''
%:
	@:
