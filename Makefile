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
CWD  = $(shell cd $(shell dirname $(THIS_MAKEFILE)); pwd)
# Full path to `vendor/bin` directory
BIN  = $(CWD)/vendor/bin
# Configuration for Tools, source url's
SRC  = $(CWD)/.makefiles/.sources.conf
# Filter Makefile Input params to use they as target input params
ARGS = $(filter-out $@, $(MAKECMDGOALS))

# Detect changed files in current Branch (list of files, separated by comma)
BRANCH        = `git rev-parse --abbrev-ref HEAD`
BRANCH_BASE   = `git merge-base origin/master HEAD`
CHANGED_FILES = $(shell git diff --name-only --diff-filter=ACMR $(BRANCH_BASE) HEAD | grep \.php | paste -sd "," -)

# =================================================================
# Common PHP Tools path
# To add new Tool, just add new line with NAME and PATH
# After adding new PATH, ensure `install` and `check-tools` targets
# =================================================================
PHPUNIT    := $(BIN)/phpunit
PHPCS      := $(BIN)/phpcs
PHPMD      := $(BIN)/phpmd
PHPSTAN    := $(BIN)/phpstan
PHPMETRICS := $(BIN)/phpmetrics
INFECTION  := $(BIN)/infection

# Tools configuration
PHPCS_RULES = $(if $(wildcard $(CWD)/phpcs.xml), $(CWD)/phpcs.xml, PSR2)
PHPMD_RULES = $(if $(wildcard $(CWD)/phpmd.xml), $(CWD)/phpmd.xml, "cleancode,codesize,controversial,design,naming,unusedcode")

# Logs and Report path
REPORT_PATH := $(CWD)/storage/logs

# Log Messages
PHPUNIT_MSG := Code coverage report in HTML format:\n$(Cyan)$(REPORT_PATH)/coverage/index.html$(NC)
PHPCS_MSG   := PHP CODE SNIFFER REPORT DETAILS:\n$(Cyan)$(REPORT_PATH)/phpcs_report.log$(NC)
PHPMD_MSG   := PHP MESS DETECTOR REPORT DETAILS (HTML):\n$(Cyan)$(REPORT_PATH)/phpmd_report.html$(NC)

# =================================================================
# Filter Input Params
# =================================================================
# filter for PHPUnit `--filter` param
FILTER = $(if $(filter-out $@, $(ARGS)), --filter $(filter-out $@, $(ARGS)), "")
# collect only changed files in current Branch
PHPCS_FILTER = $(if $(filter-out $@, $(ARGS)), $(filter-out $@, $(ARGS)), $(subst $(comma),$(space),$(CHANGED_FILES)))
PHPMD_FILTER = $(if $(filter-out $@, $(ARGS)), $(filter-out $@, $(ARGS)), $(CHANGED_FILES))


# =================================================================
# Makefile Targets:
# =================================================================

---: ## --------------------------------------------------------------
install: ## Install all PHP Tools (skip existing tools in ./vendor/bin)
	$(call install_phar,$(PHPUNIT),$(call config,PHPUNIT,$(SRC)))
	$(call install_phar,$(PHPCS),$(call config,PHPCS,$(SRC)))
	$(call install_phar,$(PHPMD),$(call config,PHPMD,$(SRC)))
	$(call install_phar,$(PHPSTAN),$(call config,PHPSTAN,$(SRC)))
	$(call install_phar,$(PHPMETRICS),$(call config,PHPMETRICS,$(SRC)))
	$(call install_phar,$(INFECTION),$(call config,INFECTION,$(SRC)))

check-tools: ## Check all Tools
	$(call check_tools,$(shell which php))
	$(call check_tools,$(PHPUNIT))
	$(call check_tools,$(PHPCS))
	$(call check_tools,$(PHPMD))
	$(call check_tools,$(PHPSTAN))
	$(call check_tools,$(PHPMETRICS))
	$(call check_tools,$(INFECTION))


---: ## --------------------------------------------------------------
unit: ## Run Unit tests
	$(PHPUNIT) --no-coverage --testsuite=Unit $(FILTER)

feature: ## Run Feature tests
	$(PHPUNIT) --no-coverage --testsuite=Feature $(FILTER)

integration: ## Run Integration tests
	$(PHPUNIT) --no-coverage --testsuite=Integration $(FILTER)

tests: ## Run all tests
	$(PHPUNIT) --no-coverage $(FILTER)
	&& echo "$(Green)SUCCSESS!$(NC)" || { echo "$(Red)FAILURE!$(NC)"; exit 1;}

coverage: ## Run all tests with Code Coverage report
	$(PHPUNIT) --stop-on-failure \
	&& echo "$(Green)SUCCSESS!$(NC)" || { echo "$(Red)FAILURE!$(NC)"; exit 1;}
	@echo "$(PHPUNIT_MSG)"

infection: ## Run Mutation Testing
	$(INFECTION) run \
	--configuration=$(CWD)/infection.json \
	--threads=4 --no-progress \
	--coverage=$(REPORT_PATH) \
	--show-mutations --ansi --only-covered \
	--min-msi=60 --min-covered-msi=70

---: ## --------------------------------------------------------------
metrics: ## Generate Code Metrics Report project
	$(METRICS) --version
	$(METRICS) --git \
	$(CWD) \
	--exclude=vendor,database,migrations,views,tests,storage,bootstrap,docker,resources \
	--report-violations=$(REPORT_PATH)/violations.xml \
	--report-html=$(REPORT_PATH)/metrics \
	--junit=$(REPORT_PATH)/phpunit.junit.xml


---: ## --------------------------------------------------------------
phpcs: ## Check Code Style with PHP CodeSniffer [opt.: path]
	$(PHPCS) --version
	# -
	$(PHPCS) \
	--runtime-set ignore_warnings_on_exit true \
	--standard=$(PHPCS_RULES) --parallel=2 \
	--report-full=$(REPORT_PATH)/phpcs_report.log \
	--report-diff --report-full $(PHPCS_FILTER) \
	&& echo "$(Green)SUCCSESS!$(NC)" || { echo "$(Red)FAILURE!$(NC)\n${PHPCS_MSG}"; exit 1;}
	# show full path to report
	@echo "$(PHPCS_MSG)"

phpmd: ## Check Code Style with PHP MessDetector [opt.: path]
	$(PHPMD) --version
	# show Summary report
	$(PHPMD) $(PHPMD_FILTER) text $(PHPMD_RULES) \
	--ignore-violations-on-exit \
	--reportfile $(REPORT_PATH)/phpmd_report.txt
	# --
	$(PHPMD) $(PHPMD_FILTER) html $(PHPMD_RULES) \
	--reportfile $(REPORT_PATH)/phpmd_report.html \
	&& echo "$(Green)SUCCSESS!$(NC)" \
	|| (sed 's~$(CWD)~.~g' $(REPORT_PATH)/phpmd_report.txt && echo "\n$(Red)FAILURE!$(NC)")
	# show full path to report
	@echo
	@echo "$(PHPMD_MSG)"

phpstan: ## Analyze Project with PHPStan [opt.: path]
	$(PHPSTAN) --version
	$(PHPSTAN) analyse --ansi --memory-limit=2G ./ \
	&& echo "$(Green)SUCCSESS!$(NC)" || echo "$(Red)FAILURE!$(NC)"

---: ## --------------------------------------------------------------
show-coverage: ## Open CodeCoverage Report in default browser.
	open $(REPORT_PATH)/coverage/index.html

show-metrics: ## Open PHP Metrics Report in default browser.
	open $(REPORT_PATH)/metrics/index.html

show-phpmd: ## Open Mess Detector Report in default browser.
	open $(REPORT_PATH)/phpmd_report.html

help: .logo ## Show this help and exit
	@echo "$(Yellow)Usage:$(NC)\n  make [target] [arguments]"
	@echo ''
	@echo "$(Yellow)Arguments:$(NC)"
	printf "  $(Green)%-15s$(NC) %s\n" "testName" "for all test runners - Filter which tests to run"
	@echo ''
	@echo "$(Yellow)Targets:$(NC)"
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(THIS_MAKEFILE) | awk 'BEGIN {FS = ":.*?## "}; \
		{printf "  $(Cyan)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ''
%:
	@:

