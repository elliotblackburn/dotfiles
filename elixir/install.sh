# Clone exenv for elixir environment management
# this does not handle erlang. That is done via kerl
# which is installed via brew.
git clone git://github.com/mururu/exenv.git ~/.exenv

# Exenv is added to the path by path.zsh in this dir

# Exenv is initialised in zshrc.

# Now setup the elixir-build plugin
git clone git://github.com/mururu/elixir-build.git ~/.exenv/plugins/elixir-build
