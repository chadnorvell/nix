{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    clinfo
  ];

  environment.variables.RUSTICL_ENABLE = "radeonsi";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa.opencl
      rocmPackages.clr.icd
      rocmPackages.rocminfo
    ];
  };

  hardware.bluetooth.enable = true;

  services.upower.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

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
