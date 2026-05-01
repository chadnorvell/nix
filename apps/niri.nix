{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    desktop-file-utils
    nautilus
    # shared-mime-info
    # xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableVPN = false;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
  };

  # Ensure that DMS only auto-starts in Niri
  systemd.user.services.dms.unitConfig.ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";

  security.polkit.enable = true;
  security.rtkit.enable = true;

  programs.regreet.enable = true;
  programs.dconf.enable = true;

  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.gnome.gcr-ssh-agent.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
