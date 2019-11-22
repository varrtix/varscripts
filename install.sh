#!/usr/bin/env bash
#
# Auto install all the required settings for the new unix-like system environment.
# Author: varrtix<tiamo_nana@outlook.com>
# Intro: https://github.com/varrtix/varsc

# Guess => Portability
# PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
# export PATH

version="1.0"
authors=("varrtix<tiamo_nana@outlook.com>")

red='\033[31m'
green='\033[32m'
yellow='\033[33m'
plain='\033[0m'
bold='\033[1m'

###############################################################################
# Output the error msg and when it occurred to stderr.
# Globals:
#  None
# Arguments:
#  error_msg
# Returns:
#  None
# Example:
#  err "string"
###############################################################################
err() {
  echo -e "[$(date +'%Y-%m-%dT%H:%M:%S%:z')]${red}Error:${plain} ${bold}$@${plain}" >&2
}

clear
cat <<EOF
+---------------------------------------------------------+
|                       Delay tools                       |
+---------------------------------------------------------+
|  Auto install all the required settings for new system  |
+---------------------------------------------------------+
|  Authors: ${authors[0]}               |
+---------------------------------------------------------+
EOF

# func_intro(){
# }
