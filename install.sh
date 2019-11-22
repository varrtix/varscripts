#!/usr/bin/env bash
#
# Auto install all the required settings for the new unix-like system environment.
# Author: varrtix<tiamo_nana@outlook.com>
# Intro: https://github.com/varrtix/varsc

# script version
readonly VERSION="1.0"
readonly AUTHORS=("varrtix<tiamo_nana@outlook.com>")
readonly MACHINE=$(uname -s)

# terminal font style
readonly RED_FS='\033[31m'
readonly GREEN_FS='\033[32m'
readonly YELLOW_FS='\033[33m'
readonly PLAIN_FS='\033[0m'
readonly BOLD_FS='\033[1m'

###############################################################################
# Output the error msg and when it occurred to stderr.
# Globals:
#  None
# Arguments:
#  error_msg
# Returns:
#  None
# Example:
#  err "error_msg"
###############################################################################
err() {
  echo -e "[$(date +'%Y-%m-%dT%H:%M:%S%:z')]${RED_FS}Error:${PLAIN_FS} ${BOLD_FS}$@${PLAIN_FS}" >&2
}

###############################################################################
# initialize menu
# Globals:
#  None
# Arguments:
#  None
# Returns:
#  None
###############################################################################
init() {
  clear
  cat <<EOF
+---------------------------------------------------------+
                        Delay tools
+---------------------------------------------------------+
   Auto install all the required settings for new system
+---------------------------------------------------------+
   Authors: ${AUTHORS[0]}
+---------------------------------------------------------+
   Version: ${VERSION}
+---------------------------------------------------------+
EOF

}

###############################################################################
# Check system name
# Globals:
#  None
# Arguments:
#  None
# Returns:
#  None
###############################################################################
# check_sys() {
# }

###############################################################################
# Main entrance for the script.
# Globals:
#  None
# Arguments:
#  None
# Returns:
#  None
###############################################################################
main() {
# Guess => Portability
# PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
# export PATH
  [[ $EUID -ne 0 ]] && err "Make sure run the script as superuser." && exit 1
  # readonly machine=$(check_machine)
  echo ${MACHINE}
  # check_sys
}

main "$@"
###############################################################################
# string
# Globals:
#  None
# Arguments:
#  None
# Returns:
#  None
# Example:
#  None
###############################################################################
