{ user, nixDir }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  homeDirectory = user.homeDirectory;

  cp = path: builtins.readFile "${nixDir.home}/${path}";
  ln = path: config.lib.file.mkOutOfStoreSymlink "${nixDir.home}/${path}";
  lnr = path: {
    source = ln path;
    recursive = true;
  };

  addToPath = [
    "${homeDirectory}/.local/bin"
  ];
in
{
  imports = [
    (import ./desktop.nix { inherit lib pkgs nixDir; })
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
  home.sessionPath = addToPath;

  systemd.user.sessionVariables = {
    EDITOR = "nvim";
    MAKEFLAGS = "-j20";
    PATH = lib.strings.concatStringsSep ":" addToPath + ":$PATH";
  };

  xdg.enable = true;

  xdg.userDirs = {
    enable = true;
    setSessionVariables = true;
    createDirectories = true;
    desktop = "${homeDirectory}/top";
    documents = "${homeDirectory}/docs";
    download = "${homeDirectory}/inbox";
    music = "${homeDirectory}/media/music";
    pictures = "${homeDirectory}/media/images";
    publicShare = "${homeDirectory}/public";
    templates = "${homeDirectory}/docs/templates";
    videos = "${homeDirectory}/media/videos";
  };

  programs.bash.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  xdg.configFile."fish/functions".source = ln "fish/functions";
  xdg.configFile."fish/completions".source = ln "fish/completions";
  xdg.configFile."fish/conf.d".source = ln "fish/conf.d";

  xdg.configFile."kitty/kitty.conf".source = ln "kitty/kitty.conf";

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;

    options = [ "--cmd cd" ];
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    package = pkgs.openssh;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user.name = "Chad Norvell";
      user.email = "chadnorvell@pm.me";

      core.editor = "nvim";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "base16";
  };

  programs.btop = {
    enable = true;
    settings.color_theme = "onedark";
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;

    initLua = ''
      require("cxn")
    '';
  };

  xdg.configFile."nvim/lua" = lnr "nvim/lua";
  xdg.configFile."nvim/ftplugin" = lnr "nvim/ftplugin";

  programs.tmux = {
    enable = true;
    extraConfig = cp "tmux/tmux.conf";
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = cp "vim/vimrc";
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = false;
    shellWrapperName = "y";

    settings = {
      opener = {
        edit = [
          {
            run = "nvim \"$@\"";
            block = true;
          }
        ];
      };
    };
  };
}
