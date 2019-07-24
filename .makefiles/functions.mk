# Load `phar` and save it to `vendor/bin`
# example:
#        $(call download_phar,./vendor/bin/phpunit,https://phar.phpunit.de/phpunit-8.phar)
define download_phar
	curl -sSL $(2) -o $(1) && chmod 755 $(1) && chmod +x $(1)
endef

# Install PHP tool from phar archive if this tool not installed
# example:
#        $(call install_phar,./vendor/bin/phpunit,https://phar.phpunit.de/phpunit-8.phar)
define install_phar
	if test ! -f "$(1)"; then \
		echo "$(Green)Downloading $(1)...$(NC)"; \
		$(call download_phar,$(1),$(2)); \
	fi
endef

# Check if PHP tool exists. On success - display tool version
# example:
#        $(call check_tools,./vendor/bin/phpunit)
define check_tools
	echo "$(Green)checking > $(subst $(CWD),".",$(1))$(NC)"
	if test -f "$(1)"; then \
		$(1) --version; \
	else \
		echo "$(Red)not installed$(NC)"; \
	fi
	echo
endef

# Read param from config file
# example:
#        $(call config,PHPUNIT,./makefiles/.sources.conf)
define config
	`grep -E $(1) $(2) | awk '{gsub(/$(1)=/,"")}1'`
endef

# Copy file if not exists
# example:
#        $(call copy_file,phpcs.xml,phpcs.xml.dist)
define copy_file
	if test -f "$(1)"; then \
		echo "$(Yellow)exists > $(subst $(CWD),".",$(1))$(NC)"; \
	else \
		cp $(2) $(1); \
		echo "$(Green)created > $(subst $(CWD),".",$(1))$(NC)"; \
	fi
endef
