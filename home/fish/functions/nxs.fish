function nxs --description "nix-shell in fish (invoke command with -c COMMAND)" --wraps nix-shell
    argparse -i 'c/command=' -- $argv; or return

    if set -q _flag_c
        nix-shell $argv --command "fish -c '$_flag_c'"
    else
        nix-shell $argv --command fish
    end
end
