# This could be an abbr, but as a function it overrides the default function.
function ll --description "eza --long" --wraps eza
    eza -l $argv
end
