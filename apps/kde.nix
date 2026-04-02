{
  pkgs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    with kdePackages;
    [
      ark
      breeze
      breeze-icons
      dolphin
      dolphin-plugins
      elisa
      gwenview
      kate
      kde-cli-tools
      kimageformats
      kio
      kio-extras
      konsole
      kservice
      markdownpart
      plasma-workspace
      okular
      qt6ct
    ];
}
