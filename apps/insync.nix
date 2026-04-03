{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    insync
  ];
}
