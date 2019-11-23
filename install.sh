#!/usr/bin/env bash
#
# Auto install all the required settings for the new unix-like system environment.
# Author: varrtix<tiamo_nana@outlook.com>
# Intro: https://github.com/varrtix/varsc

# script version
readonly VERSION="1.0"
readonly AUTHORS=("varrtix<tiamo_nana@outlook.com>")
local SYSTEM=''
local RELEASE=''
# readonly MACHINE=$(uname -s)

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
    exit 1
  fi
}

###############################################################################
# Check system name & version
# Globals:
#  SYSTEM RELEASE
# Arguments:
#  machine_name=>$(uname -s)
# Returns:
#  Success return 0, Failed return 1
###############################################################################
check_sys() {
  case $1 in
    Darwin)
      SYSTEM='macOS'
      RELEASE=$(sw_vers -productVersion)
      ;;
    Linux)
      if [[ -s /etc/os-release ]]; then
          SYSTEM=$(cat /etc/os-release \
		       | grep -E "^NAME=+" \
		       | awk -F "\"" '{print $2}')
	  RELEASE=$(cat /etc/os-release \
			| grep -E "^VERSION=+" \
			| awk -F "\"" '{print $2}')
      fi
      ;;
    *)
      SYSTEM='Unknown'
      RELEASE='0.0'
      return 1
      ;;
  esac
  return 0
}

###############################################################################
# initialize menu view
# Globals:
#  None
# Arguments:
#  None
# Returns:
#  None
###############################################################################
menu_init() {
  clear
  cat <<EOF

+---------------------------------------------------------+
                        Delay tools
+---------------------------------------------------------+
  Auto install all the required settings for new system
+---------------------------------------------------------+
  Authors: ${AUTHORS[0]}
+---------------------------------------------------------+
  System: ${SYSTEM} ${RELEASE}
+---------------------------------------------------------+
  Version: ${VERSION}
+---------------------------------------------------------+

EOF

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
# Guess => Portability
# PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
# export PATH
  err $EUID "Make sure run the script as superuser."
  check_sys $(uname -s)
  err $? "Unknown system"
  menu_init SYSTEM RELEASE
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
###############################################################################
