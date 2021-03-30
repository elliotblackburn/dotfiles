# Lunchy is a nice wrapper around systemctl, but I only use it on macos.

if [[ "$OSTYPE" == "darwin"* ]]; then
	if [ -x "$(command -v gem)" ] && [ -x "$(command -v lunchy)" ]; then
	  LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
	  if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
	    . $LUNCHY_DIR/lunchy-completion.zsh
	  fi
	fi
fi