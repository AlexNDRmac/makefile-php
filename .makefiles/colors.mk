############################################
# Colors
############################################

# Regular Colors
NC         =\033[0m
Black      =\033[0;30m
Red        =\033[0;31m
Green      =\033[0;32m
Yellow     =\033[0;33m
Blue       =\033[0;34m
Purple     =\033[0;35m
Cyan       =\033[0;36m
White      =\033[0;37m
Gray       =\033[0;90m

# Background Colors
On_Black   =\033[40m
On_Red     =\033[41m
On_Green   =\033[42m
On_Yellow  =\033[43m
On_Blue    =\033[44m
On_Purple  =\033[45m
On_Cyan    =\033[46m
On_White   =\033[47m

OK_COLOR    = \033[32;01m
ERROR_COLOR = \033[31;01m
WARN_COLOR  = \033[33;01m

solid_line = ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
dash_line  = ------------------------------------------------------------------------
dots_line  = ........................................................................
ascii_block = ██████████

.PHONY: show_colors
show_colors:
	@echo "OK_COLOR:    $(OK_COLOR)$(ascii_block)$(NC)\n"
	@echo "WARN_COLOR:  $(WARN_COLOR)$(ascii_block)$(NC)\n"
	@echo "ERROR_COLOR: $(ERROR_COLOR)$(ascii_block)$(NC)\n"
	@echo "Black:       $(Black)$(ascii_block)$(NC)\n"
	@echo "Red:         $(Red)$(ascii_block)$(NC)\n"
	@echo "Green:       $(Green)$(ascii_block)$(NC)\n"
	@echo "Yellow:      $(Yellow)$(ascii_block)$(NC)\n"
	@echo "Blue:        $(Blue)$(ascii_block)$(NC)\n"
	@echo "Purple:      $(Purple)$(ascii_block)$(NC)\n"
	@echo "Cyan:        $(Cyan)$(ascii_block)$(NC)\n"
	@echo "White:       $(White)$(ascii_block)$(NC)\n"
	@echo "Gray:        $(Gray)$(ascii_block)$(NC)\n"
