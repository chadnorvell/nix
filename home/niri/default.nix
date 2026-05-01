{ pkgs, ... }:
let
  ln = pkgs.lib'.ln;
in
{
  home.packages = with pkgs; [
    gruvbox-plus-icons
  ];

  dconf.settings."org/gnome/desktop/interface".icon-theme = "Gruvbox-Plus-Dark";

  xdg.configFile = ln "niri" [
    "config.kdl"
    "binds.kdl"
  ]
  // ln "niri/dms" [
    "binds.kdl"
  ];
}
