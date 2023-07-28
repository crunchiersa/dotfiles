#!/bin/bash
## Author: crunchie
## Description: Script to remove any symlinks to dotfiles and restore existing .dtbak-files

check_location () {
    if [ `pwd` == "$HOME/dotfiles" ]; then
	    echo "Please leave dotfile folder to uninstall dotfiles."
        exit 2
    fi
}

# function to unlink symlink or mv .dtbak-file to original name
unlink_file () {
	local file=$1
	if [ -e $file ]; then
		if [ -L $file ]; then
			unlink $file
		fi
	fi
}

# function to check if the file exists in the home directory
# return parameters: 2 = file exists, 3 = file does not exist
check_exist () {
	local file=$1
	if [ -e ~/$file ]; then
		return 2
	else
		return 3
	fi
}

## EXECUTE begins here

# check if user is currently inside dotfiles-folder
check_location

# Unlink any links in ~ and mv .dtbak-files to original location
for file in $(find ~/dotfiles -maxdepth 1 -name ".*" ! -name ".zshrc*" ! -name ".zcompdum*" ! -name ".*history*" -type f  -printf "%f\n" ); do
	check_exist ~/$file.dtbak
	if [ $? == 2 ]; then
        unlink_file ~/$file
		mv -f ~/$file{.dtbak,}
    elif [ $? == 3 ]; then
		unlink_file ~/$file
	fi
done

# Unlink or move existing .zshrc config or .zshrc-theme 
for file in .zshrc .zshrc-theme
do
	check_exist ~/$file.dtbak
	if [ $? == 2 ]; then
		unlink_file ~/$file
        mv -f ~/$file{.dtbak,}
	elif [ $? == 3 ]; then
		unlink_file ~/$file
	fi
done 

# Remove dotfiles-folder in home-directory.
rm -rf $HOME/dotfiles

echo "Removal done."
exit 0
