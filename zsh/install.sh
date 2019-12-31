#!/bin/sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    sudo bash -c 'echo $(which zsh) >> /etc/shells'

    chsh -s $(which zsh)
fi