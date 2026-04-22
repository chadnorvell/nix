update-nixos-flake:
    nix flake update

[working-directory: 'home']
update-hm-flake:
    nix flake update

[working-directory: 'home/darwin']
update-hm-darwin-flake:
    nix flake update

update-flakes:
    just update-nixos-flake update-hm-flake update-hm-darwin-flake

