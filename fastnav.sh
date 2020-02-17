#!/bin/bash

# MIT License
# Copyright (c) 2020 Geovane Fedrecheski
# https://choosealicense.com/licenses/mit/

# function go_up_n -> navigate up N directories
# param $1
#   must be a number, indicate how many directories to navigate up
#   if omitted, navigate up only one directory
# e.g.: 
#  $ pwd
# > /home/mithrandil/middle_earth/shire/hobbits/bilbo/ring
#  $ go_up_n 2
# > /home/mithrandil/middle_earth/shire/hobbits
# 
go_up_n() {
    # if no parameters, navigate up only 1 directory and stop
    [ -z "$1" ] && cd .. && return 0

    # filter parameter $1, should contains only numbers
    [ "$( echo $1 | sed "s/[0-9]*//g" )" ] && echo "arg \$1 must be a number" && return 1 || n=$1

    dirs_up=
    for i in $(seq $1); do
        dirs_up+="../"
    done
    cd $dirs_up

    return 0
}
# by using this alias, going back become as simples as ".. 2" :)
alias ..="go_up_n"

# function go_down_n_from_home() -> navigate down N directories,
# counting from $HOME with respect to the working directory
# param $1
#   must be a number, indicate how many directories to navigate down
#   if omitted, will be treated as 0
# e.g.: 
#  $ pwd
# > /home/mithrandil/middle_earth/shire/hobbits/bilbo/ring
#  $ navigate_from_up 1
# > /home/mithrandil/middle_earth
go_down_n_from_home() {
    [ "$( echo $1 | sed "s/[0-9]*//g" )" ] && echo "arg \$1 must be a number" && return 1 || n=$1

    # separate path components into a string array
    a=( $(echo $(pwd) | sed "s;\/; ;g") )

    ((n+=2)) # we are starting from /home/<your-user>/
    dir=$(echo "${a[@]:0:$n}" | sed "s; ;\/;g") # filter the array and put slashes back
    cd /$dir

    return 0
}
# by using this alias, going up counting from home become as simples as ",, 1" :)
alias ,,="go_down_n_from_home"
