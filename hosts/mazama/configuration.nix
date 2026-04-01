{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1defb5f2-cad0-4210-b961-0458fe3c984f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/843D-2E4E";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/a6d47ef1-c47a-4b2d-b28f-099808b69fb1"; }
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/a6d47ef1-c47a-4b2d-b28f-099808b69fb1";
  boot.kernelParams = [ "resume=UUID=a6d47ef1-c47a-4b2d-b28f-099808b69fb1" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.fwupd.enable = true;
  hardware.framework.laptop13.audioEnhancement = {
    enable = false;
    hideRawDevice = true;
    rawDeviceName = "alsa_input.pci-0000_c1_00.6.analog-stereo";
  };

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

  systemd.sleep = {
    extraConfig = ''
      HibernateOnACPower=no
      HibernateDelaySec=240min
    '';
  };

  services.evremap = {
    enable = true;
    settings = {
      device_name = "AT Translated Set 2 keyboard";
      dual_role = [
        {
          input = "KEY_TAB";
          tap = [ "KEY_TAB" ];
          hold = [
            "KEY_LEFTCTRL"
            "KEY_LEFTALT"
            "KEY_LEFTSHIFT"
          ];
        }
      ];
      remap = [
        {
          input = [ "KEY_LEFTCTRL" ];
          output = [
            "KEY_LEFTCTRL"
            "KEY_LEFTSHIFT"
          ];
        }
        {
          input = [ "KEY_CAPSLOCK" ];
          output = [ "KEY_LEFTCTRL" ];
        }
      ];
    };
  };
}
