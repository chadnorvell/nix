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
      };

      homeConfig = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user.name} = {
            imports = [ ./home.nix ];
            home.username = user.name;
            home.homeDirectory = "/home/${user.name}";
          };
        };
      };

      hostConfig =
        hostName: extraModules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit
              inputs
              outputs
              user
              hostName
              ;
          };

          modules = [
            ./base.nix
            ./hosts/${hostName}.nix
            home-manager.nixosModules.home-manager
            homeConfig
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        advaita = hostConfig "advaita" [
          nixos-hardware.nixosModules.framework-16-amd-ai-300-series
          ./hosts/framework.nix
          ./hosts/workstation.nix
          # ./apps/cli.nix
          # ./apps/gui.nix
          # ./apps/kde.nix
          # ./apps/niri.nix
          # ./apps/davinci.nix
          # ./apps/docker.nix
          # ./apps/tailscale.nix
        ];

        mazama = hostConfig "mazama" [ nixos-hardware.nixosModules.framework-amd-ai-300-series ];
        sunyata = hostConfig "sunyata" [ ];
      };
    };
}
