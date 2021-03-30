if command -v asdf &> /dev/null; then
	# Setup our asdf plugins so we're ready to install whatever versions we want
	asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
fi
