# Add rvm and rbenv to PATH
if (( $+commands[rbenv] ))
then
  export PATH="$PATH:$HOME/.rvm/bin:$HOME/.rbenv/bin"
fi
