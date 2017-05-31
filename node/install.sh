#!/bin/sh
#
# Install tj/n, a node version manager package. This also comes
# bundled with a script for upgrading and uninstall - https://github.com/mklement0/n-install

curl -sL https://git.io/n-install | bash -s -- -q -

# Install the latest version of node, quietly if possible
echo "› n latest"
n latest
# Use that install, this command is a bit silly really.
n latest

# Yarn requires node, so make sure it's installed afterwards
brew yarn