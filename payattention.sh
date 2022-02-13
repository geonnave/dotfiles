#!/bin/bash

payattention() {
	clear
	while [ 1 ]; do
		echo $ $@
		echo
		eval $@
		sleep 1
		clear
	done
}

