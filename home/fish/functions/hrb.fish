function hrb --description "home-manager [COMMAND | switch] --flake ~/nix/home"
    switch (uname)
        case Linux
            set -f flake_path ~/nix/home
        case Darwin
            set -f flake_path ~/nix/home/darwin
        case '*':
            echo "Unsupported OS!"
            return 1
    end

    set -q argv[1]; or set argv switch
    type -q home-manager; and set -l hm home-manager; or set -l hm nix run home-manager/master --
    $hm $argv[1] --impure --flake $flake_path $argv[2..]
end
