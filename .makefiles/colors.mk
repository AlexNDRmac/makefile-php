############################################
# Colors
############################################
# Color  Foreground  Background
# black     30          40
# red       31          41
# green     32          42
# yellow    33          43
# blue      34          44
# magenta   35          45
# cyan      36          46
# white     37          47

# Regular Colors
NC         = \033[0m
Black      = \033[0;30m
Red        = \033[1;31m
Green      = \033[1;32m
Yellow     = \033[1;33m
Blue       = \033[1;34m
Purple     = \033[1;35m
Cyan       = \033[1;36m
White      = \033[1;37m
Gray       = \033[1;90m

# Background Colors
On_Black   = \033[40m
On_Red     = \033[41m
On_Green   = \033[42m
On_Yellow  = \033[43m
On_Blue    = \033[44m
On_Purple  = \033[45m
On_Cyan    = \033[46m
On_White   = \033[47m

solid_line  = ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
dash_line   = ------------------------------------------------------------------------
dots_line   = ........................................................................
ascii_block = ██████████

.PHONY: show_colors
show_colors:
	@echo "Black:       $(Black)$(ascii_block)$(NC)\n"
	@echo "Red:         $(Red)$(ascii_block)$(NC)\n"
	@echo "Green:       $(Green)$(ascii_block)$(NC)\n"
	@echo "Yellow:      $(Yellow)$(ascii_block)$(NC)\n"
	@echo "Blue:        $(Blue)$(ascii_block)$(NC)\n"
	@echo "Purple:      $(Purple)$(ascii_block)$(NC)\n"
	@echo "Cyan:        $(Cyan)$(ascii_block)$(NC)\n"
	@echo "White:       $(White)$(ascii_block)$(NC)\n"
	@echo "Gray:        $(Gray)$(ascii_block)$(NC)\n"
