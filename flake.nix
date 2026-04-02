{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      user = {
        name = "chad";
        description = "Chad Norvell";
        homeDirectory = "/home/chad";
      };

      hostConfig =
        extraModules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit
              inputs
              outputs
              user
              ;
          };

          modules = [
            ./base.nix
            home-manager.nixosModules.home-manager
            ./home
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        sunyata = hostConfig [
          ./hosts/sunyata.nix
          ./hosts/workstation.nix
        ];

        advaita = hostConfig [
          ./hosts/advaita.nix
          ./hosts/framework.nix
          ./hosts/workstation.nix
          nixos-hardware.nixosModules.framework-16-amd-ai-300-series
        ];

        mazama = hostConfig [
          ./hosts/mazama.nix
          ./hosts/framework.nix
          ./hosts/workstation.nix
          nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };
    };
}
