{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.fwupd.enable = true;

#  services.logind = {
#    settings = {
#      Login = {
#        HandleLidSwitch = "suspend-then-hibernate";
#        HandleLidSwitchExternalPower = "suspend-then-hibernate";
#        HandleLidSwitchDocked = "ignore";
#        HandlePowerKey = "suspend-then-hibernate";
#      };
#    };
#  };

#  systemd.sleep = {
#    extraConfig = ''
#      HibernateOnACPower=no
#      HibernateDelaySec=240min
#    '';
#  };
}
