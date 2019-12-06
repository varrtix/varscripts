#!/usr/bin/env bash
#
# Auto compile and install for the SS/SSR and accelerated tools on Linux.
# Author: varrtix<tiamo_nana@outlook.com>
# Intro: https://github.com/varrtix/varsc

# Script version
readonly VERSION="1.0"
# Author info
readonly AUTHOR="varrtix<tiamo_nana@outlook.com>"

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
#  error_no error_msg
# Returns:
#  if error, return 1, exit the script.
###############################################################################
err() {
  if [[ $1 -ne 0 ]]; then
    echo -e "[$(date +'%Y-%m-%dT%H:%M:%S%:z')]${RED_FS}Error:${PLAIN_FS} ${BOLD_FS}$2${PLAIN_FS}" >&2
    exit $1
  fi
}

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
# PATH Setting
  PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
  export PATH

# If the script is not running as superuser, it will interrupt.
  err $EUID "Make sure run the script as superuser."
  # check_sys $(uname -s)
  # err $? "System: ${SYSTEM}"
  # 	check_interface ${SYSTEM}
  # 	err $? "Mode: ${MODE}"
  # 	pm_prefix ${SYSTEM}
  # 	err $? "Cannot set package manager Prefix: ${PM}"
  # menu_init SYSTEM RELEASE
}

main "$@"
