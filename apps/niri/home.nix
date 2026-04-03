{ nixDir }:
{ config, pkgs, ... }:
let
  ln = path: config.lib.file.mkOutOfStoreSymlink "${nixDir.root}/apps/niri/config/${path}";


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
