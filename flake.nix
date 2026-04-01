{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
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

      hostConfig =
        hostName: extraModules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs outputs;
          };

          modules = [
            {
              nixpkgs.config.permittedInsecurePackages = [
                "openssl-1.1.1w"
              ];
            }
            (import ./nixos.nix { inherit hostName user; })
            ./hosts/${hostName}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user.name} = {
                  imports = [ ./home.nix ];
                  home.username = user.name;
                  home.homeDirectory = "/home/${user.name}";
                };
              };
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        advaita = hostConfig "advaita" [ nixos-hardware.nixosModules.framework-16-amd-ai-300-series ];
        mazama = hostConfig "mazama" [ nixos-hardware.nixosModules.framework-amd-ai-300-series ];
        sunyata = hostConfig "sunyata" [ ];
      };
    };
}
