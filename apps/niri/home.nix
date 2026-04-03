{ nixDir }:
{ config, pkgs, ... }:
let
  ln = path: config.lib.file.mkOutOfStoreSymlink "${nixDir.root}/apps/niri/config/${path}";

  # Because of the way Insync is packaged, it just can't open Dolphin in a non-broken way.
  # So we intercept directory opening events from Insync and handle them with Nautilus.
  insync-file-manager-shim = pkgs.lib'.writeShellScriptBin "xdg-open" ''
    # If the argument is a directory, open with Nautilus, ignoring mimeapps.list
    if [ -d "$1" ]; then
      exec ${pkgs.nautilus}/bin/nautilus "$1"
    fi

    # Otherwise, pass through to the real xdg-open
    exec /run/current-system/sw/bin/xdg-open "$@"
  '';

  # Handle all autostart logic in one place.
  autostart-script = pkgs.lib'.writeShellScriptBin "niri-autostart" ''
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
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };

  xdg.configFile."niri/config.kdl" = {
    force = true;

    text = ''
      include "base.kdl"
      spawn-at-startup "sh" "-c" "${autostart-script.binFile}"
    '';
  };

  xdg.configFile."niri/base.kdl".source = ln "base.kdl";
  xdg.configFile."niri/dms".source = ln "dms";
}
