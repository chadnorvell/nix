{ pkgs, ... }:
let
  ln' = pkgs.lib'.ln';
in
{
  programs.git.settings.core.sshCommand = "/usr/bin/ssh";

  programs.ssh.extraConfig = ''
    UseKeychain yes
  '';

  xdg.configFile = ln' "fish/conf.d/darwin" "fish/conf.d" [
    "abbr-darwin.fish"
    "50-bun.fish"
    "50-deno.fish"
    "50-go.fish"
    "50-npm.fish"
    "50-pipx.fish"
    "50-rust.fish"
    "50-ssh.fish"
    "90-local.fish"
    "99-nix.fish"
  ];
}
