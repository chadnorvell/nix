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
        modules = [ (import ./home.nix { inherit user nixDir; }) ];
      };
    };
}
