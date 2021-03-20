#!/bin/sh

# For macos we install via the Brewfile, for linux
# we assume ubuntu and install thusly...
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# Install deps
	sudo apt install curl git -y

	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
fi
