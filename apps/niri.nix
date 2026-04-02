{ pkgs, user, ... }:

let
  # Because of the way Insync is packaged, it just can't open Dolphin in a non-broken way.
  # So we intercept directory opening events from Insync and handle them with Nautilus.
  insync-file-manager-shim = pkgs.cxn.writeShellScriptBin "xdg-open" ''
    # If the argument is a directory, open with Nautilus, ignoring mimeapps.list
    if [ -d "$1" ]; then
      exec ${pkgs.nautilus}/bin/nautilus "$1"
    fi

    # Otherwise, pass through to the real xdg-open
    exec /run/current-system/sw/bin/xdg-open "$@"
  '';

  # Handle all autostart logic in one place.
  autostart-script = pkgs.cxn.writeShellScriptBin "niri-autostart" ''
    # Ensure Dolphin can find all application menus and .desktop files
    export XDG_MENU_PREFIX=kf6-
    dbus-update-activation-environment --systemd --all
    kbuildsycoca6 &

    # Wait for the system tray to start up before launching background apps,
    # otherwise they may launch too early and never appear there.
    until dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep -q "StatusNotifierWatcher"; do
      sleep 0.5
    done

    # Start Insync with a shim to xdg-open directories in Nautilus
    PATH="${insync-file-manager-shim.binDir}:$PATH" insync start &

    1password --silent
  '';
in
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

  home-manager.users.${user.name} = {
    xdg.configFile."niri/config.kdl" = {
      force = true;

      text = ''
        include "base.kdl"
        spawn-at-startup "sh" "-c" "${autostart-script.binFile}"
      '';
    };
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
  programs.niri.enable = true;

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

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = user.homeDirectory;
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ user.name ];
  };
}
