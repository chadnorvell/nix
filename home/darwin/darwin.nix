{ pkgs, ... }:
let
  ln = pkgs.lib'.ln;
  ln' = pkgs.lib'.ln';
in
{
  imports = [ ./iterm2.nix ];

  programs.git.settings.core.sshCommand = "/usr/bin/ssh";

  programs.ssh.extraConfig = ''
    UseKeychain yes
  '';

  xdg.configFile =
    ln' "fish/conf.d/darwin" "fish/conf.d" [
      "abbr-darwin.fish"
      "50-bun.fish"
      "50-deno.fish"
      "50-editor.fish"
      "50-go.fish"
      "50-npm.fish"
      "50-pipx.fish"
      "50-rust.fish"
      "50-ssh.fish"
      "90-local.fish"
      "99-nix.fish"
    ]
    // ln "nvim" [ "init.lua" ]
    // ln "tmux" [ "tmux.conf" ]
    // ln "vim" [ "vimrc" ]
    // ln' "neovide/darwin" "neovide" [ "config.toml" ];

  programs.iterm2 = {
    enable = true;
    settings.appearance.theme = "minimal";

    profiles = [
      {
        name = "Default";
        default = true;

        font = {
          normal = "IosevkaNFM 16";
          antiAlias = true;
          brightenBold = true;
        };

        colors = {
          foreground = "#d8dee9";
          background = "#242933";

          black = {
            normal = "#000000";
            bright = "#808080";
          };

          red = {
            normal = "#ec5f66";
            bright = "#f97b58";
          };

          green = {
            normal = "#99c794";
            bright = "#acd1a8";
          };

          yellow = {
            normal = "#f9ae58";
            bright = "#fac761";
          };

          blue = {
            normal = "#6699cc";
            bright = "#85add6";
          };

          magenta = {
            normal = "#c695c6";
            bright = "#d8b6d8";
          };

          cyan = {
            normal = "#5fb4b4";
            bright = "#82c4c4";
          };

          white = {
            normal = "#f7f7f7";
            bright = "#ffffff";
          };
        };
      }
    ];
  };
}
