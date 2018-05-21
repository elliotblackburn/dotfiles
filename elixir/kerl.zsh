# Kerl is used to manage Erlang versions, however it doesn't manage
# keeping them active at all times. So we must activate the chosen
# erlang version each time.

# Current erl version is symlinked to the "current" dir
if [ -f ~/kerl/current/activate ]; then
    source ~/kerl/current/activate
fi
