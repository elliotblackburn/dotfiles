#!/bin/sh

brew install zsh

sudo bash -c 'echo $(which zsh) >> /etc/shells'

chsh -s $(which zsh)
