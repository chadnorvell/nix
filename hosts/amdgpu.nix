{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.rocminfo
    ];
  };

  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    clinfo
  ];

  environment.variables.RUSTICL_ENABLE = "radeonsi";
}
