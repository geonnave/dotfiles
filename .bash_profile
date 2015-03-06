
# load my exports
source ${HOME}/bin/.exports

source $HOME/bin/.cscopes

# function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
 cd_func ()
 {
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

# function navigate_up -> navigate up N directories
# param $1 -> must be a number, indicate how many directories to navigate up; if omitted, navigate up only one directory
# e.g.: 
#  $ pwd
# > /home/mithrandil/middle_earth/shire/hobbits/bilbo/ring
#  $ navigate_up 2
# > /home/mithrandil/middle_earth/shire/hobbits
navigate_up() {
        # if there aren't parameters, navigate up only 1 directory and stop
        [ -z "$1" ] && cd .. && return 0

        # filter parameter $1, should contains only numbers
        non_number_chars=$( echo $1 | sed "s/[0-9]*//g" )
        if [ ! -z "$non_number_chars" ]; then
                echo -e "You must specify a number of directories to navigate up"
                return 1
        fi

        dirs_up=
        for i in $(seq $1); do
                dirs_up+="../"
        done

        cd $dirs_up
        return 0
}
# by using this alias, going back become as simples as ".. 2" :)
alias ..="navigate_up"

# function navigate_from_home() -> navigate down N directories counting from your $HOME directory, considering your current directory
# param $1 -> must be a number, indicate how many directories to navigate down; if omitted, will be treated as 0
# e.g.: 
#  $ pwd
# > /home/mithrandil/middle_earth/shire/hobbits/bilbo/ring
#  $ navigate_from_up 2
# > /home/mithrandil/middle_earth/shire
navigate_from_home() {
	[ "$( echo $1 | sed "s/[0-9]*//g" )" ] && echo wrong usage && return 1 || n=$1

	a=( $(echo $(pwd) | sed "s;\/; ;g") )

	((n+=2))
	dir=$(echo "${a[@]:0:$n}" | sed "s; ;\/;g")
	cd /$dir

	return 0
}
# by using this alias, jumping-back-from-home become as simples as ",, 2" :)
alias ,,="navigate_from_home"

PS1='\[\e[32m\]\u \[\e[33m\]\w\[\e[0m\]\n\@ \d \$ '

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

alias alogcat="adb logcat -v time -b main -b radio -b system"
alias await="adb wait-for-device devices"
alias awrootw="adb wait-for-device && adb root && adb wait-for-device devices "
alias akeyevent="adb shell input keyevent"
alias ainput="adb shell input"
alias akill="adb kill-server"

