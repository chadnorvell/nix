# This could be an abbr, but as a function it overrides the default function.
function la --description "eza --long --all" --wraps eza
    eza -la $argv
end

