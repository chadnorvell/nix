{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-fork.url = "github:chadnorvell/nixpkgs/current";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      # nixpkgs-fork,
      nixos-hardware,
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

      hostConfig =
        extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs outputs user;
          };

          modules = [
            # (import ./fork.nix { inherit system nixpkgs-fork; })
            ./base.nix
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        sunyata = hostConfig [
          ./hosts/sunyata.nix
          ./apps/workstation.nix
          ./apps/steam.nix
        ];

        mach = hostConfig [
          ./hosts/mach.nix
          ./apps/workstation.nix
          nixos-hardware.nixosModules.framework-16-amd-ai-300-series
        ];

        lux = hostConfig [
          ./hosts/lux.nix
          ./apps/workstation.nix
          nixos-hardware.nixosModules.framework-amd-ai-300-series
        ];
      };

      devShells.${system} =
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              fish-lsp
              lua-language-server
              nil
              nixfmt
              statix
              stylua
            ];
          };
        };
    };
}
