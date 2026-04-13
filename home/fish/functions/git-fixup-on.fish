function git-fixup-on
    git log --oneline | ${gum} choose | awk '{print $1}' | xargs git commit --fixup
end
