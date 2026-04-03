{
  pkgs,
  user,
  nixDir,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    desktop-file-utils
    gruvbox-plus-icons
    insync
    libreoffice-fresh
    nautilus
    shared-mime-info
    wl-clipboard
    xdg-utils
    xwayland-satellite
  ];

  # Make sure KDE apps can find application menus and .desktop files
  environment.pathsToLink = [ "/share/applications" ];
  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  environment.sessionVariables = {
    KDE_SESSION_VERSION = "6";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
    XDG_CURRENT_DESKTOP = "niri";

    # Ensure application menus are findable
    XDG_MENU_PREFIX = "kf6-";
    XDG_CONFIG_DIRS = [
      "/etc/xdg" # This MUST be first for the menu link to be found reliably
      "/run/current-system/sw/etc/xdg"
      "/etc/profiles/per-user/${user.name}/etc/xdg"
    ];

    # Ensure .desktop files are findable
    XDG_DATA_DIRS = [
      # GSettings schemas
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
      # Manually-created desktop files
      "/home/${user.name}/.local/share"
      # System-provided desktop files
      "/run/current-system/sw/share"
      # Fallback
      "/nix/var/nix/profiles/default/share"
    ];
  };

  home-manager.users.${user.name}.imports = [ (import ./home.nix { inherit nixDir; }) ];

  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      };
    };

    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;

  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  programs.dconf.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ user.name ];
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = user.homeDirectory;
  };

  programs.dms-shell = {
    enable = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
    enableDynamicTheming = true;
    enableSystemMonitoring = true;
    enableVPN = true;
    systemd.enable = true;
  };

  programs.niri = {
    enable = true;
  };
}
