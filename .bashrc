
# load my exports
[ ! "$(echo $PATH | grep bin/bin)" ] && export PATH=$HOME/bin/bin/:$PATH

export PATH=$PATH:/usr/local/go/bin

export PATH=/snap/bin:$PATH
[ ! "$(echo $PATH | grep node)" ] && export PATH=$HOME/bin/node/bin:$PATH
[ ! "$(echo $PATH | grep zotero)" ] && export PATH=$HOME/bin/Zotero-5.0.89_linux-x86_64/Zotero_linux-x86_64/:$PATH
[ ! "$(echo $PATH | grep ngrok)" ] && export PATH=$HOME/bin/ngrok/:$PATH
[ ! "$(echo $PATH | grep ex_doc)" ] && export PATH=$HOME/bin/ex_doc/bin/:$PATH
[ ! "$(echo $PATH | grep studio)" ] && export PATH=$HOME/bin/android-studio-ide-183.5692245-linux/android-studio/bin/:$PATH
[ ! "$(echo $PATH | grep jdk)" ] && export PATH=$HOME/bin/jdk1.8.0_211/bin/:$PATH
[ ! "$(echo $PATH | grep flutter)" ] && export PATH=$HOME/bin/flutter/bin/:$PATH

[ ! "$(echo $PATH | grep asdf)" ] && . $HOME/.asdf/asdf.sh
[ ! "$(echo $PATH | grep asdf)" ] && . $HOME/.asdf/completions/asdf.bash

[ ! "$(echo $PATH | grep pycharm)" ] && export PATH=$HOME/bin/pycharm-community-2017.2.3/bin/:$PATH
[ ! "$(echo $PATH | grep xtensa-esp32)" ] && export PATH=$PATH:$HOME/esp/xtensa-esp32-elf/bin
#[ ! "$(echo $PATH | grep anaconda3)" ] && export PATH=$HOME/anaconda3/bin/:$PATH

[ ! "$(echo $PATH | grep cmake)" ] && export PATH=$HOME/bin/cmake-3.18.0-rc2-Linux-x86_64/bin/:$PATH

#export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/"
export JAVA_HOME="/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64/"

# Android stuff
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func () {
	local x2 the_new_dir adir index
	local -i cnt

	if [[ $1 ==  "--" ]]; then
		dirs -v
		return 0
	fi

	the_new_dir=$1
	[[ -z $1 ]] && the_new_dir=$HOME

	if [[ ${the_new_dir:0:1} == '-' ]]; then
		#
		# Extract dir N from dirs
		index=${the_new_dir:1}
		[[ -z $index ]] && index=1
		adir=$(dirs +$index)
		[[ -z $adir ]] && return 1
		the_new_dir=$adir
	fi

	#
	# '~' has to be substituted by ${HOME}
	[[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

	#
	# Now change to the new dir and add to the top of the stack
	pushd "${the_new_dir}" > /dev/null
	[[ $? -ne 0 ]] && return 1
	the_new_dir=$(pwd)

	#
	# Trim down everything beyond 11th entry
	popd -n +11 2>/dev/null 1>/dev/null

	#
	# Remove any other occurence of this dir, skipping the top of the stack
	for ((cnt=1; cnt <= 10; cnt++)); do
		x2=$(dirs +${cnt} 2>/dev/null)
		[[ $? -ne 0 ]] && return 0
		[[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
		if [[ "${x2}" == "${the_new_dir}" ]]; then
			popd -n +$cnt 2>/dev/null 1>/dev/null
			cnt=cnt-1
		fi
	done

	return 0
}
alias cd=cd_func

#PS1='\[\e[32m\]\u \[\e[33m\]\w\[\e[0m\]\n\@ \d \$ '

# aliases for Tmux
alias tmux='tmux -2'
alias ta='tmux attach -t'
alias tnew='tmux new -s'
alias tls='tmux ls'
alias tkill='tmux kill-session -t'

# convenience aliases for editing configs
alias ev='vim ~/.vimrc'
alias et='vim ~/.tmux.conf'

export EDITOR=vim
export VISUAL=vim

# adb aliases
alias alogcat="adb logcat -v time -b main -b radio -b system"
alias await="adb wait-for-device devices"
alias awrootw="adb wait-for-device && adb root && adb wait-for-device devices "
alias akeyevent="adb shell input keyevent"
alias ainput="adb shell input"
alias akill="adb kill-server"
alias agetprop="adb shell getprop"

alias csjava_here="find . -name '*.java' > cscope.files && cscope -b -q"

# avoid annoying accessibility bus GTK warning when opening emacs
export NO_AT_BRIDGE=1

export ERL_AFLAGS="-kernel shell_history enabled"

#source /usr/share/autojump/autojump.sh

alias python=python3

export IDF_PATH=~/esp/esp-idf

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/geovane/dev/tmp/test-indy/indy-sdk/libindy/target/debug

source $HOME/dev/config/dotfiles/fastnav.sh
source $HOME/dev/config/dotfiles/payattention.sh

export MOZ_USE_XINPUT2=1

export PATH=$PATH:/usr/local/go/bin

