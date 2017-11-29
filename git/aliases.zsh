# The rest of my fun git aliases
alias gl='git lg' # gitconfig.symlink
alias gup='git up' # gitconfig.symlink
alias gp='git push origin HEAD'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcob='git cob' # gitconfig.symlink
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb'
alias gac='git add -A && git commit -m'
