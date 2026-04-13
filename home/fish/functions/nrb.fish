function nrb --description "nixos-rebuild [COMMAND | switch] --flake ~/nix" --wraps nixos-rebuild
    set -q argv[1]; or set argv switch
    sudo nixos-rebuild $argv[1] --impure --flake ~/nix $argv[2..]
end
