#!/bin/bash
## Author: crunchie
## Description: Script to automatically link up certain files in home-directory to pre-built versions.
## 				Backups of currently installed versions are made in a .dtbak-file. 
##				Links the .zshrc file to different files depending on whether a linux or mac platform is in use.
##				oh-my-zsh needs to be installed as the pre-built .zshrc files depend on it. An adapted Agnoster-prompt is used in the theme-file.

# function to check if mac or linux
check_os () {
	which sw_vers
	if [ $? == 0 ]; then
		os=mac
	else
		os=linux
	fi
}

# function to unlink symlink or mv original file to dtbak
unlink_mv_file () {
	local file=$1
	if [ -e $file ]; then
		if [ -L $file ]; then
			unlink $file
		fi
		if [ -f $file ]; then
			mv -f $file{,.dtbak}
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

# Check whether linux or macos is used
check_os

# Backup dotfiles and link to local versions
for file in $(find ~/dotfiles -maxdepth 1 -name ".*" ! -name ".zshrc*" ! -name ".zcompdum*" ! -name ".*history*" -type f  -printf "%f\n" ); do
	check_exist $file
	stat_dot=$?
	if [ $stat_dot == 2 ]; then
		unlink_mv_file ~/$file
		ln -s ~/dotfiles/$file ~/$file
	elif [ $stat_dot == 3 ]; then
		ln -s ~/dotfiles/$file ~/$file
	fi
done

# Unlink or move existing .zshrc config or .zshrc-theme 
for file in .zshrc .zshrc-theme
do
	check_exist $file
	if [ $? == 2 ]; then
		unlink_mv_file ~/$file
	fi
done 

# link the .zshrc-file in home-directory depending on the underlying os
if [ $os == linux ];then
	ln -s ~/dotfiles/.zshrc-linux ~/.zshrc
	ln -s ~/dotfiles/.zshrc-linux-agnoster ~/.zshrc-theme
	echo ".zshrc and .zshrc-theme linked"
elif [ $os == mac ];then
	ln -s ~/dotfiles/.zshrc-mac ~/.zshrc
	ln -s ~/dotfiles/.zshrc-mac-agnoster ~/.zshrc-theme
	echo ".zshrc and .zshrc-theme linked"
else
	echo "Unknown OS - no .zshrc placed"
fi

echo "Installation done."
exit 0