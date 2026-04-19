{ pkgs, ... }:
let
  systemPkgs = with pkgs; [
    libreoffice-qt-fresh
    wl-clipboard
  ];

  kdePkgs =
    with pkgs;
    with kdePackages;
    [
      digikam
      dragon
      falkon
      filelight
      karousel
      kbackup
      kcharselect
      kcolorchooser
      kdenlive
      kdf
      kdialog
      kfind
      kget
      kgpg
      kjournald
      kompare
      ksystemlog
      markdownpart
      partitionmanager
      plasma-vault
      skanpage
      svgpart
      yakuake
    ];
in
{
  environment.systemPackages = systemPkgs ++ kdePkgs;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };
}
