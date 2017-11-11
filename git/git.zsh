export GIT_SANDBOX=~/code/sandbox

# Wrap git with hub
if [[ -f `command -v hub` ]] ; then alias git=hub ; fi

function g {
    if [[ $# > 0 ]]; then
        git "$@"
    else
        echo "Last commit: $(time_since_last_commit) ago"
        git status --short --branch
    fi
}

function time_since_last_commit() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  git log -1 --pretty=format:"%ar" | sed 's/\([0-9]*\) \(.\).*/\1\2/'
}

# Sometimes you need to do something complex and it's useful to sandbox it
function sandbox() {
  cd $GIT_SANDBOX && git clone $1 && cd `last_modified`
}