function hrb --description "home-manager [COMMAND | switch] --flake ~/nix/home"
    set -q argv[1]; or set argv switch
    type -q home-manager; and set -l hm home-manager; or set -l hm nix run home-manager/master --
    $hm $argv[1] --impure --flake ~/nix/home $argv[2..]
end
