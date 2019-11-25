######################################################################
## User Style Settings By VARRTIX
# bash EX: export PS1="\[\e[01;33m\][\[\e[01;36m\]\t\[\e[01;33m\]]\[\e[01;35m\]\h\[\e[01;37m\]:\[\e[01;32m\]\w \[\e[01;34m\]\u\[\e[01;33m\]\$ "
# export CLICOLOR=1
# export LSCOLORS=ExFxCxGxBxFhfhBhbhEheh
# Enable colors prompt
autoload -U colors && colors
# Prompt format >>> FORMAT: [HH:MM:SS]ComputerName(ttyname):Location Username %
#export PS1="%{$fg_bold[yellow]%}[%{$fg_no_bold[cyan]%}%*%{$fg_bold[yellow]%}]%{$fg_bold[magenta]%}%m%{$fg_bold[yellow]%}(%{$fg_no_bold[white]%}%l%{$fg_bold[yellow]%}):%{$fg_bold[green]%}%~ %{$fg_bold[blue]%}%n %{$fg_bold[yellow]%}%#%b "
export PS1="%B%F{white}%K{magenta} ☰ %m %k %K{blue} %n ☰ %k%f「 %F{green}%~%f 」☯ %b"
export RPROMPT="%B%K{cyan}%F{black} TTY%l「%*」☭ %F{red}%?%f %f%k%b "
# Language encoding
export LANG="en_US.UTF-8"

######################################################################
## User Alias By VARRTIX
alias grep='grep --color'
alias ll='ls -l'
alias la='ls -la'

######################################################################
## User Environments By VARRTIX
export PATH="/usr/local/opt/openssl@1.1/bin:${PATH}"
export PATH="/usr/local/opt/qt/bin:${PATH}"

######################################################################
## User Quick Commands By VARRTIX
# >>> Proxy switch
proxy() {
# Usage format for proxy
    SPXY_HELP="EXample usage:
  proxy enable\t: enable proxy mode
  proxy disable\t: enable normal mode
  proxy status\t: mode status

Write by VARRTIX"

    if [ $# -eq 0 ]; then
	echo ${SPXY_HELP}
	return
    fi

    SPXY_C=0
    ADD_VOL=`expr ${SPXY_C} + $?`
    case $1 in
	"enable")
	    # Open proxy
	    echo -n "Proxy address (Default: 127.0.0.1): "; read SPXY_ADDR
	    if [ -z ${SPXY_ADDR} ]; then SPXY_ADDR="127.0.0.1"; fi
	    echo -n "Proxy port: "; read SPXY_PORT
	    if [ -z ${SPXY_PORT} ]; then
		echo -e "\033[31mError: \033[0mport cannot be empty"
		return
	    fi
	    export http_proxy="http://${SPXY_ADDR}:${SPXY_PORT}"
	    SPXY_C=${ADD_VOL}
	    export https_proxy="https://${SPXY_ADDR}:${SPXY_PORT}"
	    SPXY_C=${ADD_VOL}
	    if [ ${SPXY_C} -eq 0 ]; then
		echo -e "SUCCESS >> Proxy Mode"
	    else
		unset SPXY_ADDR SPXY_PORT http_proxy https_proxy
	    fi
	    ;;
	"disable")
	    # Close proxy
	    unset http_proxy https_proxy
	    SPXY_C=${ADD_VOL}
	    if [ ${SPXY_C} -eq 0 ]; then echo -e "SUCCESS >> Normal Mode"; fi
	    ;;
	"status")
	    # Check status
	    if [ ${http_proxy} ] && [ ${https_proxy} ]; then
		echo -e "STATUS >> Proxy Enabled"
	    else
		echo -e "STATUS >> Proxy Disabled"
	    fi
	    ;;
	*)
	    echo -e "\033[31mError: \033[0mUnknown command: $1"
	    ;;
    esac

    # Clear var
    unset SPXY_C
    unset ADD_VOL
}

# >>> Homebrew repo switch
sbrew() {
# Usage format for sbrew
    SBW_HELP="Example usage:
  sbrew ustc\t: switch repo to ustc
  sbrew tuna\t: switch repo to tsinghua
  sbrew reset\t: reset repo

Further help:
  sbrew help [-h, --help] : usage help

Write by VARRTIX"

    if [ $# -eq 0 ]; then
	echo -e ${SBW_HELP}
	return
    fi

    SBW_P=0
    ADD_VOL=`expr ${SBW_P} + $?`
    SBW_REPO=("$(brew --repo)" \
		  "$(brew --repo homebrew/core)" \
		  "$(brew --repo homebrew/cask)")
    SBW_GIT=("brew.git" \
		 "homebrew-core.git" \
		 "homebrew-cask.git")
    SBW_DOMAIN=("mirrors.ustc.edu.cn" \
		    "mirrors.tuna.tsinghua.edu.cn/git/homebrew" \
		    "github.com/Homebrew")

    case $1 in
	"--help" | "-h" | "help")
	    echo -e ${SBW_HELP}
	    SBW_P=1
	    ;;
	"ustc")
	    for i in $(seq ${#SBW_REPO[@]}); do
		echo "DETAIL >> ${SBW_REPO[$i]} repo: https://${SBW_DOMAIN[1]}/${SBW_GIT[$i]}"
		git -C ${SBW_REPO[$i]} remote set-url origin https://${SBW_DOMAIN[1]}/${SBW_GIT[i]}
		SBW_P=${ADD_VOL}
	    done
	    HOMEBREW_BOTTLE_DOMAIN=https://${SBW_DOMAIN[1]}/homebrew-bottles
	    ;;
	"tsinghua" | "tuna")
	    for i in $(seq ${#SBW_REPO[@]}); do
		echo "DETAIL >> ${SBW_REPO[$i]} repo: https://${SBW_DOMAIN[2]}/${SBW_GIT[$i]}"
		git -C ${SBW_REPO[$i]} remote set-url origin https://${SBW_DOMAIN[2]}/${SBW_GIT[i]}
		SBW_P=${ADD_VOL}
	    done
	    HOMEBREW_BOTTLE_DOMAIN=https://${SBW_DOMAIN[2]%%/*}/homebrew-bottles
	    ;;
	"reset")
	    for i in $(seq ${#SBW_REPO[@]}); do
		echo "DETAIL >> ${SBW_REPO[$i]} repo: https://${SBW_DOMAIN[3]}/${SBW_GIT[$i]}"
		git -C ${SBW_REPO[$i]} remote set-url origin https://${SBW_DOMAIN[3]}/${SBW_GIT[i]}
		SBW_P=${ADD_VOL}
	    done
	    unset HOMEBREW_BOTTLE_DOMAIN
	    ;;
	*)
	    echo -e "\033[31mError: \033[0mUnknown command: $1"
	    SBW_P=1
	    ;;
    esac
    if [ ${HOMEBREW_BOTTLE_DOMAIN} ]; then export HOMEBREW_BOTTLE_DOMAIN; fi
    if [ ${SBW_P} -eq 0 ]; then echo "SUCCESS >> $1 repo, All Done!"; fi

# Clear env
    unset SBW_HELP
    unset SBW_P
    unset ADD_VOL
    unset SBW_REPO
    unset SBW_GIT
    unset SBW_DOMAIN
}
