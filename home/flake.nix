{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      plasma-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      user = {
        name = "chad";
        description = "Chad Norvell";
        homeDirectory = "/home/chad";
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
          inputs.plasma-manager.homeModules.plasma-manager
          (import ./home.nix { inherit user nixDir; })
        ];
      };
    };
}
