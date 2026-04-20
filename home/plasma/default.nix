{ ... }:
{
  programs.plasma = {
    enable = true;

    configFile = {
      kwinrc = (import ./kwinrc.nix);
    };

    shortcuts = (import ./shortcuts.nix);
  };
}
