#!/bin/bash

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

check_os

# Backup dotfiles and link to local versions
for file in $(find ~/dotfiles -maxdepth 1 -name ".*" ! -name ".zshrc*" ! -name ".zcompdum*" -type f  -printf "%f\n" ); do
	check_exist $file
	if [ $? == 2 ]; then
		unlink_mv_file ~/$file
		ln -s ~/dotfiles/$file ~/$file
	elif [ $? == 3 ]; then
		ln -s ~/dotfiles/$file ~/$file
	fi
done

# Find all dot files then if the original file exists, create a backup
# Once backed up to {file}.dtbak symlink the new dotfile in place
for file in $(find ~ -maxdepth 1 -name ".*" ! -name ".gitconfig" -type f  -printf "%f\n" ); do
    if [ -e ~/$file ]; then
        mv -f ~/$file{,.dtbak}
    fi
    ln -s ~/dotfiles/$file ~/$file
	echo "$file linked"
done

# Unlink or move .zshrc config 
for file in .zshrc .zshrc-theme
do
	check_exist $file
	if [ $? == 2 ]; then
		unlink_mv_file ~/$file
	fi
done 

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