#!/bin/sh

brew install zsh

sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'

chsh -s /usr/local/bin/zsh
