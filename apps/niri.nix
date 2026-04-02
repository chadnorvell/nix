{
  pkgs,
  user,
  ...
}:

let
  systemVariables = {
    KDE_SESSION_VERSION = "6";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_MENU_PREFIX = "kf6-";

    XDG_CONFIG_DIRS = [
      "/etc/xdg" # This MUST be first for the menu link to be found reliably
      "/run/current-system/sw/etc/xdg"
      "/etc/profiles/per-user/${user.name}/etc/xdg"
    ];

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

  insync-file-manager-shim = pkgs.cxn.writeShellScriptBin "xdg-open" ''
    # If the argument is a directory, force-open with Nautilus
    if [ -d "$1" ]; then
      exec ${pkgs.nautilus}/bin/nautilus "$1"
    fi
    # Otherwise, pass through to the real system xdg-open
    exec /run/current-system/sw/bin/xdg-open "$@"
  '';

  autostart-script = pkgs.cxn.writeShellScriptBin "niri-autostart" ''
    export XDG_MENU_PREFIX=kf6-
    dbus-update-activation-environment --systemd --all
    kbuildsycoca6 &

    until dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep -q "StatusNotifierWatcher"; do
      sleep 0.5
    done

    PATH="${insync-file-manager-shim.binDir}:$PATH" insync start &
    1password --silent
  '';
in
{
  environment.systemPackages = with pkgs; [
    desktop-file-utils
    gruvbox-plus-icons
    insync
    nautilus
    shared-mime-info
    wl-clipboard
    xdg-utils
    xwayland-satellite
  ];

  environment.pathsToLink = [
    "/share/applications"
  ];

  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  environment.sessionVariables = systemVariables;

  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = "*";
        # default = [ "gtk" ];
        # "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      };
    };

    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      # pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  home-manager.users.${user.name}.xdg.configFile."niri/config.kdl" = {
    force = true;

    text = ''
      include "base.kdl"
      spawn-at-startup "sh" "-c" "${autostart-script.binFile}"
    '';
  };

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

  programs.dconf.enable = true;

  services.dbus.enable = true;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${user.name}";
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ user.name ];
  };

  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
