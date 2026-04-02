{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # INSERT HW HERE

  hardware.framework.laptop13.audioEnhancement = {
    enable = false;
    hideRawDevice = true;
    rawDeviceName = "alsa_input.pci-0000_c1_00.6.analog-stereo";
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
