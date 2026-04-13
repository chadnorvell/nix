function nvgqt --description "launch nvim-qt" --wraps nvim-qt
    set -l p $argv .
    nvim-qt $p[1] &>/dev/null &
    disown
end
