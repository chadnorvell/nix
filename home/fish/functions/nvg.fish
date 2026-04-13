function nvg --description "launch neovide" --wraps neovide
    set -l p $argv .
    neovide $p[1] &>/dev/null &
    disown
end
