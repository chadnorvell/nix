function git-squash-all
    git reset $(git commit-tree HEAD^{tree} \"$@\")
end
