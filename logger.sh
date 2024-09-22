#!/bin/bash

# Universal Bash Script Logger
# This script provides a robust and flexible logging framework that can be easily integrated into other shell scripts.
# Author: Stillreich (https://github.com/Stillreich)
# Version: 1.1
# License: GNU General Public License v3.0

########################################
# Configuration Variables
########################################

# Default log file path (can be overridden in log_initialize)
LOG_FILE=""

# Default verbosity level (can be overridden in log_initialize)
# Levels: SILENT=0, CRITICAL=1, ERROR=2, SUCCESS=3, WARN=4, INFO=5, DEBUG=6
log_verbosity=5  # Default to INFO level

# Whether to use colored output (true/false)
log_use_color=true

########################################
# ANSI color codes for colored output
########################################

if [ "$log_use_color" = true ]; then
    LOG_COL_BLACK='\033[0;30m'  # Black - Regular
    LOG_COL_RED='\033[0;31m'    # Red
    LOG_COL_GREEN='\033[0;32m'  # Green
    LOG_COL_YELLOW='\033[0;33m' # Yellow
    LOG_COL_BLUE='\033[0;34m'   # Blue
    LOG_COL_PURPLE='\033[0;35m' # Purple
    LOG_COL_CYAN='\033[0;36m'   # Cyan
    LOG_COL_WHITE='\033[0;97m'  # White
    LOG_COL_RESET='\033[0m'     # Text Reset
else
    LOG_COL_BLACK=''
    LOG_COL_RED=''
    LOG_COL_GREEN=''
    LOG_COL_YELLOW=''
    LOG_COL_BLUE=''
    LOG_COL_PURPLE=''
    LOG_COL_CYAN=''
    LOG_COL_WHITE=''
    LOG_COL_RESET=''
fi

########################################
# Verbosity Levels
########################################

# Adjusted Levels: SILENT=0, CRITICAL=1, ERROR=2, SUCCESS=3, WARN=4, INFO=5, DEBUG=6
log_silent_lvl=0
log_critical_lvl=1
log_error_lvl=2
log_success_lvl=3
log_warn_lvl=4
log_info_lvl=5
log_debug_lvl=6

########################################
# Logging Functions
########################################

# log_message(level, message)
# Internal function to log a message with a given level
log_message() {
    local level="$1"
    shift
    local message="$*"

    if [ "$log_verbosity" -ge "$level" ]; then
        local current_date
        current_date=$(date +"%Y-%m-%d %H:%M:%S")
        echo -e "$current_date - $message" | tee -a "$LOG_FILE"
    fi
}

# log_silent(message)
# Silent logging (level 0)
log_silent() {
    log_message "$log_silent_lvl" "$@"
}

# log_critical(message)
# Critical error logging (level 1)
log_critical() {
    log_message "$log_critical_lvl" "${LOG_COL_PURPLE}CRITICAL${LOG_COL_RESET} - $@"
}

# log_error(message)
# Error logging (level 2)
log_error() {
    log_message "$log_error_lvl" "${LOG_COL_RED}ERROR${LOG_COL_RESET} - $@"
}

# log_success(message)
# Success logging (level 3)
log_success() {
    log_message "$log_success_lvl" "${LOG_COL_GREEN}SUCCESS${LOG_COL_RESET} - $@"
}

# log_warn(message)
# Warning logging (level 4)
log_warn() {
    log_message "$log_warn_lvl" "${LOG_COL_YELLOW}WARNING${LOG_COL_RESET} - $@"
}

# log_info(message)
# Information logging (level 5)
log_info() {
    log_message "$log_info_lvl" "${LOG_COL_WHITE}INFO${LOG_COL_RESET} - $@"
}

# log_debug(message)
# Debug logging (level 6)
log_debug() {
    log_message "$log_debug_lvl" "${LOG_COL_CYAN}DEBUG${LOG_COL_RESET} - $@"
}

# log_dumpvar var1 var2 ...
# Dump the values of variables (for debugging)
log_dumpvar() {
    for var in "$@"; do
        log_debug "$var=${!var}"
    done
}

# log_initialize(log_file_path, verbosity_level, use_color)
# Initialize the logging system
# Parameters:
#   log_file_path: Path to the log file (default: none)
#   verbosity_level: SILENT, CRITICAL, ERROR, SUCCESS, WARN, INFO, DEBUG (default: INFO)
#   use_color: true/false (default: true)
log_initialize() {
    LOG_FILE="$1"
    local verbosity_level="$2"
    local use_color="$3"

    # Set verbosity level
    case "$verbosity_level" in
        SILENT)
            log_verbosity=$log_silent_lvl
            ;;
        CRITICAL)
            log_verbosity=$log_critical_lvl
            ;;
        ERROR)
            log_verbosity=$log_error_lvl
            ;;
        SUCCESS)
            log_verbosity=$log_success_lvl
            ;;
        WARN)
            log_verbosity=$log_warn_lvl
            ;;
        INFO)
            log_verbosity=$log_info_lvl
            ;;
        DEBUG)
            log_verbosity=$log_debug_lvl
            ;;
        *)
            log_verbosity=$log_info_lvl
            ;;
    esac

    # Set color usage
    if [ "$use_color" = false ]; then
        log_use_color=false
        LOG_COL_BLACK=''
        LOG_COL_RED=''
        LOG_COL_GREEN=''
        LOG_COL_YELLOW=''
        LOG_COL_BLUE=''
        LOG_COL_PURPLE=''
        LOG_COL_CYAN=''
        LOG_COL_WHITE=''
        LOG_COL_RESET=''
    else
        log_use_color=true
    fi

    # Create log file if specified
    if [ -n "$LOG_FILE" ]; then
        touch "$LOG_FILE" || { echo "Failed to create log file: $LOG_FILE"; exit 1; }
        log_info "Logging initialized. Log file is $LOG_FILE"
    else
        log_info "Logging initialized. No log file specified."
    fi
}

########################################
# End of Logger Script
########################################

# Test code (executed only if the script is run directly)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Initialize logging for testing purposes
    log_initialize "/tmp/test.log" "INFO" true

    # Example log messages
    log_info "This is an info message."
    log_warn "This is a warning message."
    log_error "This is an error message."
    log_success "This is a success message."
    log_debug "This is a debug message."
    log_critical "This is a critical message!"
    log_dumpvar HOSTNAME USER PWD
fi
