#!/bin/sh

if command -v asdf &> /dev/null; then
	# Setup our asdf plugins so we're ready to install whatever versions we want
	asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
	asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
fi