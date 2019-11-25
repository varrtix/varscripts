#!/usr/bin/env bash
#
# Auto install all the required settings for the new unix-like system environment.
# Author: varrtix<tiamo_nana@outlook.com>
# Intro: https://github.com/varrtix/varsc

# script version
readonly VERSION="1.0"
readonly AUTHORS=("varrtix<tiamo_nana@outlook.com>")
local MODE
local SYSTEM
local RELEASE
local REMOTE_DIR
# The tool name of package manager in system.
local PM

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
					| awk '{ gsub(/="|=/, " "); print $2}')
	      RELEASE=$(cat /etc/os-release \
			    | grep -E "^VERSION=+" \
					| awk '{ gsub(/="/, " "); print $2}')
      fi
      ;;
    *)
      SYSTEM='Unknown'
      RELEASE='0.0'
      return 1
      ;;
  esac
	readonly SYSTEM
	readonly RELEASE
  return 0
}

###############################################################################
# Set package manager prefix
# Globals:
#  SYSTEM PM(yum, dnf, apt...etc.)
# Arguments:
#  SYSTEM
# Returns:
#  Success return 0, Failed return 1
###############################################################################
pm_prefix() {
	case $1 in
		'macOS') PM='brew';;
		'CentOS' | 'Redhat') [[ ${RELEASE} -gt 7 ]] && PM='dnf' || PM='yum';;
		'Fedora') [[ ${RELEASE} -gt 21 ]] && PM='dnf' || PM='yum';;
		'Ubuntu') PM='apt';;
		*) PM='unknown'; return 1;;
	esac
	readonly PM
	return 0
}

###############################################################################
# Check the interface mode of the system.
# Globals:
#  SYSTEM MODE
# Arguments:
#  SYSTEM
# Returns:
#  Success return 0, Failed return 1
###############################################################################
check_interface() {
  case ${SYSTEM} in
		'macOS') MODE='GUI';;
    'CentOS')
			MODE='CLI'
    ;;
	  *) MODE='Unknown'; return 1;;
  esac
  readonly MODE
	return 0
}

###############################################################################
# initialize menu view
# Globals:
#  SYSTEM
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
  System: ${SYSTEM} ${RELEASE} | Mode: ${MODE}
+---------------------------------------------------------+
  Version: ${VERSION}
+---------------------------------------------------------+

EOF
  case ${SYSTEM} in
    'macOS')
      macos_menu
    ;;
    'CentOS')
      centos_menu
    ;;
    *)
      err 1 "Unknown system."
    ;;
  esac
}

macos_menu() {
  cat <<EOF
Functions:
[1] Set Shell Configuration
[2] Install Homebrew
[3] Install Vim
[4] Install Emacs

EOF
  local opt
  read -p "Please select a number of options: " opt
  readonly opt
  case ${opt} in
    1);;
    2);;
    3);;
    4);;
  esac

}

centos_menu() {
  cat<<EOF
Functions:
[1] Replace repo
[2] Restore repo
[3] Install vim
[4] Install Emacs
[5] Set Shell Configuration

EOF
  local opt
  read -p "Please select a number of options: " opt
  readonly opt
  case ${opt} in
    1);;
    2);;
    3);;
    4);;
    5);;
    *);;
  esac

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
  err $? "System: ${SYSTEM}"
	check_interface ${SYSTEM}
	err $? "Mode: ${MODE}"
	pm_prefix ${SYSTEM}
	err $? "Cannot set package manager Prefix: ${PM}"
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
