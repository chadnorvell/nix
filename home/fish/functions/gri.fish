function gri --description "git rebase --interactive" --wraps "git rebase"
    argparse 'n#num' -- $argv; or return

    set -f cmd "git rebase --interactive $argv"
    set -ql _flag_n; and set cmd "$cmd HEAD~$_flag_n"
    eval "$cmd"
end
