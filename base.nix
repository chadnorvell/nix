{
  lib,
  pkgs,

  user,
  hostName,

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

  nixpkgs.overlays = [ (import ./utils.nix) ];

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

  # Some packages expect this group to exist.
  users.groups.netdev = { };

  users.users.${user.name} = {
    description = user.description;
    isNormalUser = true;
    extraGroups = [
      "docker"
      "input"
      "networkmanager"
      "video"
      "wheel"
    ];
    useDefaultShell = false;
    shell = pkgs.fish;
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

  hardware.keyboard.qmk.enable = true;

  networking.hostName = hostName;
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
    NIXOS_OZONE_WL = "1";
    EDITOR = "vim";
  };

  environment.systemPackages = with pkgs; [
    bat
    chezmoi
    clang
    clang-tools
    curl
    delta
    eza
    fastfetch
    fd
    file
    fzf
    gcc
    git
    git-lfs
    htop
    jq
    man-pages
    man-pages-posix
    neovim
    openssh
    procps
    psmisc
    ripgrep
    rsync
    silver-searcher
    tmux
    trash-cli
    vim
    yazi
    yq
  ];

  programs.fish.enable = true;


  # programs.ssh.startAgent = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.openssh.enable = true;

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

  # services.udisks2.enable = true;
}
