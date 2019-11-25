export PS1='\[\e[01;33m\][\[\e[01;36m\]\t\[\e[01;33m\]]\[\e[01;35m\]\h\[\e[01;37m\]:\[\e[01;32m\]\w \[\e[01;34m\]\u\[\e[01;33m\]\$ '
#export PS1='\[\033[01;35m\]\h:\u\[\033[01;37m\] \W\$\[\033[00m\] '
export CLICOLOR=1
export LSCOLORS=ExFxCxGxBxFhfhBhbhEheh
alias grep='grep --color'

# Python3 Configurations
# Virtualenv
export PIP_REQUIRE_VIRTUALENV=true
gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Autoenv
#source /Users/darcychiu/Library/Python/3.7/bin/activate.sh

# ban .pyc files
export PYTHONDONTWRITEBYTECODE=1

# proxy func
proxy() {
	# 开启代理函数
	export http_proxy=http://127.0.0.1:1087
	export https_proxy=https://127.0.0.1:1087
	echo 'Proxy Mode'
}

unproxy() {
	# 关闭代理函数
	unset http_proxy
	unset https_proxy
	echo 'Normal Mode'
}

# homebrew repo switch
brew_origin() {
	git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git
	git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core
	git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/Homebrew/homebrew-cask
	echo 'Switched to the original repo: success'
	unset HOMEBREW_BOTTLE_DOMAIN
	echo 'Prepare to start homebrew updating...'
	brew update
	echo 'Original repo mode: success'
}

brew_tsinghua() {
	git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
	git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
	git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
	echo 'Switched to the tsinghua repo: success'
	export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
	echo 'Prepare to start homebrew updating...'
	brew update
	echo 'Tsinghua repo mode: success'
}

alias ll='ls -lh'
alias lla='ls -lha'
# Path configurations
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
#export PATH="$HOME/Library/Python/3.7/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
#export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
#export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/less/bin:$PATH"

# About rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

# About Language unicode
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export GTAGSLIBPATH=$HOME/.gtags/

# MANPATH Set
#export MANPATH="`manpath`:/usr/local/share/man:/usr/local/opt/openssl@1.1/share/man:/usr/local/opt/openssl/share/man:/usr/local/opt/sqlite/share/man:/usr/share/man:/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/share/man:/Library/Developer/CommandLineTools/usr/share/man"
export MANPATH="/usr/local/opt/openssl@1.1/share/man:$MANPATH"
export MANPATH="/usr/local/opt/openssl/share/man:$MANPATH"
