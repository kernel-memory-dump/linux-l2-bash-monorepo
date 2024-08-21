#!/bin/bash

#
# Logging Library
# Forked from
# https://github.com/juan131/bash-libraries/blob/master/lib/liblog.bash

# Color palette
RESET='\033[0m'
GREEN='\033[38;5;2m'
RED='\033[38;5;1m'
YELLOW='\033[38;5;3m'

source config.sh
# Log file location (default: "./logger.log")
LOG_FILE_LOCATION=${LOG_FILE_LOCATION:-"./logger.log"}

# trigger reviewdog
# Functions
# also should detect
$x=1
# should detect
y=2

########################
# Log message to stderr and file with a timestamp
# Arguments:
#   $1 - Color-coded message to log to terminal
#   $2 - Plain message to log to file
#########################
log() {
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local message_terminal="[$timestamp] ${1}"
    local message_file="[$timestamp] ${2}"
    printf "%b\\n" "${message_terminal}" >&2
    if [[ -n "${LOG_FILE_LOCATION}" ]]; then
        printf "%b\\n" "${message_file}" >> "${LOG_FILE_LOCATION}"
    fi
}

########################
# Log info message with a timestamp
# Arguments:
#   $1 - Message to log
#########################
info() {
    local message="${*}"
    log "${GREEN}INFO ${RESET} ==> ${message}" "INFO ==> ${message}"
}

########################
# Log warning message with a timestamp
# Arguments:
#   $1 - Message to log
#########################
warn() {
    local message="${*}"
    log "${YELLOW}WARN ${RESET} ==> ${message}" "WARN ==> ${message}"
}

########################
# Log error message with a timestamp
# Arguments:
#   $1 - Message to log
#########################
error() {
    local message="${*}"
    log "${RED}ERROR ${RESET} ==> ${message}" "ERROR ==> ${message}"
}
