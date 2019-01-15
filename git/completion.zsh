zstyle ':completion:*:*:g*:*' user-commands \
    amend:"Use the last commit message and amend your stuffs" \
    ci:"View CI status for a ref" \
    conflicts:"Show list of files in a conflict state" \
    credit:"Quick way to credit an author on the latest commit" \
    edit-conflicts:"Open files with conflicts in $EDITOR" \
    pr:"Start or open a pull request for the current branch" \
    rank-contributors:"Rank contributors by total size of diffs" \
    undo:"Undo your last commit, but don't throw away your changes" \
    wtf:"Display the state of your repository in a readable, easy-to-scan format." \

compdef '_dispatch git git' g