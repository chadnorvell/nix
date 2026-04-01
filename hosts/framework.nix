{
  pkgs,
  ...
}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth.enable = true;

  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        HandleLidSwitchDocked = "ignore";
        HandlePowerKey = "suspend-then-hibernate";
      };
    };
  };

  systemd.sleep.settings = {
    Sleep = {
      HibernateOnACPower = "no";
      HibernateDelaySec = "240min";
    };
  };
}
