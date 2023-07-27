#!/bin/bash

# functions
check_os () {
	which sw_vers
	if [ $? == 0 ]; then
		os=mac
	fi
	if [ -z $os ]; then 
		which apt
		[ $? == 0 ]; then
			os=linux
		fi
	fi
	if [ -z $os ]; then 
		which pacman
		if [ $? == 0 ]; then
			os=linux
		fi
	fi
	if [ -z $os ]; then 
		which yum 
		if [ $? == 0 ]; then
			os=linux
		fi
	fi
	if [ -z $os ]; then 
		os=unknown
	fi
}

# Find all dot files then if the original file exists, create a backup
# Once backed up to {file}.dtbak symlink the new dotfile in place
for file in $(find ~ -maxdepth 1 -name ".*" ! -name ".gitconfig" -type f  -printf "%f\n" ); do
    if [ -e ~/$file ]; then
        mv -f ~/$file{,.dtbak}
    fi
    ln -s ~/dotfiles/$file ~/$file
done

check_os

# link .zshrc and theme file according to the os
if [ -f ~/.zshrc ]; then
	mv -f ~/.zshrc{,.dtbak}
	if [ $os == linux ];then
		ln -s ~/dotfiles/.zshrc-linux ~/.zshrc
		ln -s ~/dotfiles/.zshrc-linux-agnoster ~/.zshrc-theme
	elif [ $os == mac ];then
		ln -s ~/dotfiles/.zshrc-mac ~/.zshrc
		ln -s ~/dotfiles/.zshrc-mac-agnoster ~/.zshrc-theme
	else
		echo "Unknown OS - no .zshrc placed"
	fi
fi

if [ ! -f .bash_aliases ]; then
	ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases
fi

echo "Installed"
exit 0