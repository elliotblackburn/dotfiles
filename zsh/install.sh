#!/bin/sh

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
 	# Install zsh and syntax highlighting
 	sudo apt install zsh zsh-syntax-highlighting -y

 	echo "Now run zsh --version to check the install"
 	echo "Then check cat /etc/shells to ensure zsh is in the list"
 	echo "Finally, switch to zsh by running chsh -s $(which zsh)"
 	echo "Then logout and back in again."
fi