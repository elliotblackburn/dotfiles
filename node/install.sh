if command -v asdf &> /dev/null; then
	# Setup our asdf plugins so we're ready to install whatever versions we want
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

	# Install latest nodejs
	asdf install nodejs latest
fi
