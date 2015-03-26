#!/bin/bash

why_did_i_come_to_exist="in the beginning, there was the darkness;\n
there were shadows and only a bunch of bad-looking, anti-human terminal emulators to use;\n
but then blessed tools came along, together with their respective dotfiles.\n
\n
they changed the way stuff is done.\n
they also fostered the shell scripting as the linux user's best friend (not the prettiest)\n
\n
then this auto-loader-setupper-script was born. (use --hard ONLY if you trust me!)\n
"

[ "$1" == "-h" -o "$1" == "who_am_i" ] && echo -e $why_did_i_come_to_exist && exit 0

hard=
if [ "$1" == "--hard" ]; then
	hard=1
	echo "your old files will be saved to ~/.old_dotfiles/"
	echo "do you want to continue? [y/N]"
	read confirm
	[ "$confirm" != "y" ] && echo "aborting.." && exit 0
	echo -e "..ok, will move your files to ~/.old_dotfiles/ and put new ones in its former place\n\n"
	[ ! -e "$HOME/.old_dotfiles" ] && mkdir "$HOME/.old_dotfiles"
fi

do_link() {
	if [ "$hard" ]; then
		bkp_file="$(basename $2).$(date "+%Y%m%d-%H%M%S")"
		echo "moving file: $2 to $HOME/.old_dotfiles/$bkp_file"
		mv "$2" "$HOME/.old_dotfiles/$bkp_file"
	fi
	[ ! -e "$2" ] && echo -e "linking file: $1 to $2\n" && ln -s "$1" "$2" && return 0
	echo "skipping already existent file: $2" && return 1
}

# select only the dotfiles that are intended to be installed at home directory
for f in $(find . -maxdepth 1 | egrep -i "^\.\/\..*" | egrep -v "git|bash_profile|cscope_maps.vim" | sed "s;^\.\/;;g"); do
	do_link "$(pwd)/$f" "$HOME/$f"
done

[ ! -e $HOME/bin ] && mkdir $HOME/bin

[ -e .bash_profile ] && do_link "$(pwd)/.bash_profile" "$HOME/bin/.bash_profile"
if [ "$?" == "0" ]; then
	# if do not exist, create a dummy one
	[ ! -e $HOME/.bash_profile ] && touch $HOME/.bash_profile
	# echo 'source $HOME/bin/.bash_profile' only if needed
	if [ -z "$(grep -o "$HOME/bin/.bash_profile" $HOME/.bash_profile)" ]; then
		echo -e "\nsource $HOME/bin/.bash_profile\n" >> $HOME/.bash_profile
	fi
fi

[ -e .cscope_maps.vim ] && do_link "$(pwd)/.cscope_maps.vim" "$HOME/bin/.cscope_maps.vim"

exit 0
