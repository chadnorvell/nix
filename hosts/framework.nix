{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.bluetooth.enable = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth.powerOnBoot = false;
  services.upower.enable = true;
  networking.networkmanager.wifi.powersave = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # Experiment: nixos-hardware's framework-16-amd-ai-300-series module sets
  # amdgpu.dcdebugmask=0x410 (disable stutter + PSR_SU), amdgpu.sg_display=0,
  # and amdgpu.abmlevel=0 as workarounds for graphical glitches. Each costs
  # idle watts. These appended params exploit the kernel's last-wins parsing
  # to restore defaults; revert if rendering glitches appear.
  boot.kernelParams = lib.mkAfter [
    "amdgpu.dcdebugmask=0"
    "amdgpu.sg_display=-1"
    "amdgpu.abmlevel=-1"
  ];

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
