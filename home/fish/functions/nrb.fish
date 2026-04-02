function nrb --wraps='sudo nixos-rebuild $1 --impure --flake $NIX_CFG $argv'
    set command $argv[1]
    set args $argv[2..-1]

    if test -z "$command"
        set command switch
    end

    sudo nixos-rebuild $command --impure --flake "$NIX_CFG" $args
end
