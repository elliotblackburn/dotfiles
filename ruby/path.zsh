# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Lunchy for systemctl handling with nicer commands
LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
  . $LUNCHY_DIR/lunchy-completion.zsh
fi
