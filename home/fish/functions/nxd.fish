function nxd --description "nix develop in fish (invoke command with -c COMMAND)" --wraps "nix develop"
    argparse -i 'c/command=' -- $argv; or return

    if set -q _flag_c
        nix develop $argv --command "fish -c '$_flag_c'"
    else
        nix develop $argv --command fish
    end
end
