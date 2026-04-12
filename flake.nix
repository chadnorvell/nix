{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-fork.url = "github:chadnorvell/nixpkgs/current";
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
      nixpkgs-fork,
      nixos-hardware,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      user = {
        name = "chad";
        description = "Chad Norvell";
        homeDirectory = "/home/chad";
      };

      nixDir = {
        root = "${user.homeDirectory}/nix";
        home = "${user.homeDirectory}/nix/home";
      };

      hostConfig =
        extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit
              inputs
              outputs
              user
              nixDir
              ;
          };

          modules = [
            (import ./overlays.nix { inherit system nixpkgs-fork; })
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

        mach = hostConfig [
          ./hosts/mach.nix
          ./hosts/framework.nix
          ./hosts/workstation.nix
          nixos-hardware.nixosModules.framework-16-amd-ai-300-series
        ];

        lux = hostConfig [
          ./hosts/lux.nix
          ./hosts/framework.nix
          ./hosts/workstation.nix
          nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };
    };
}
