{ user, nixDir }:
{ lib, pkgs, ... }:
{
  home.stateVersion = "25.11";

  imports = [
    (import ./user.nix { inherit user nixDir; })
    (import ./desktop.nix { inherit nixDir; })
  ];

  programs.home-manager.enable = true;
  home.username = user.name;
  home.homeDirectory = user.homeDirectory;
}
