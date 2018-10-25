# The rest of my fun git aliases
alias gl='git lg'
alias gup='git up'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias gc='git commit'
alias gca='git commit -a'
alias gac='git add -A && git commit -m'
alias gco='git co'
alias gcob='git cob'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb'
