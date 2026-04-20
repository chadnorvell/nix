{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };

      user = {
        name = "chad";
        description = "Chad Norvell";
        homeDirectory = "/Users/chad";
      };

      nixDir = {
        root = "${user.homeDirectory}/nix";
        home = "${user.homeDirectory}/nix/home";
      };
    in
    {
      homeConfigurations.${user.name} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          (import ../home.nix { inherit user nixDir; })
          ./darwin.nix
        ];
      };
    };
}
