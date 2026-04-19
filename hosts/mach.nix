{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./framework.nix
    ./amdgpu.nix
  ];

  networking.hostName = "mach";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/643e6fcf-e676-4d84-af12-717e8ed3fbb6";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D863-76C5";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/d3df86b2-a82f-4df2-88cb-812b698fc4c4"; }
  ];
}
