{
  lib,
  pkgs,
  user,
  ...
}:
{
  system.stateVersion = "25.11";

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [ "@wheel" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      # Utility functions made available to the rest of the config
      lib' = (prev.lib' or { }) // {
        writeShellScriptBin =
          name: script:
          let
            rootDir = prev.writeShellScriptBin name script;
          in
          {
            inherit name rootDir;
            binDir = "${rootDir}/bin";
            binFile = "${rootDir}/bin/${name}";
          };
      };
    })
  ];

  documentation = {
    enable = true;

    nixos.enable = true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;

    man = {
      enable = true;
      cache.enable = true;
    };
  };

  # Some packages expect this group to exist
  users.groups.netdev = { };

  users.users.${user.name} = {
    description = user.description;
    isNormalUser = true;
    useDefaultShell = false;
    shell = pkgs.fish;

    extraGroups = [
      "input"
      "networkmanager"
      "video"
      "wheel"
    ];
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = true;
  };

  networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  networking.useDHCP = lib.mkDefault true;
  networking.nameservers = [
    "192.168.86.1"
    "8.8.8.8"
    "8.8.4.4"
    "1.1.1.1"
  ];

  environment.sessionVariables = {
    EDITOR = "vim";
  };

  programs.fish.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.pulseaudio.enable = false;

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-browsed
      cups-filters
      hplipWithPlugin
    ];
  };

  services.xserver = {
    enable = true;

    xkb = {
      layout = "eu";
      variant = "";
    };
  };

  console.useXkbConfig = true;
}
