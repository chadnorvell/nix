{ user, nixDir }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cp = path: builtins.readFile "${nixDir.home}/${path}";

  ln' =
    sourceDir: destDir: files:
    builtins.listToAttrs (
      lib.lists.map (file: {
        name = "${destDir}/${file}";
        value = {
          source = config.lib.file.mkOutOfStoreSymlink "${nixDir.home}/${sourceDir}/${file}";
          recursive = true;
        };
      }) files
    );

  ln = dir: files: ln' dir dir files;
in
{
  nixpkgs.overlays = [
    (final: prev: {
      lib' = (prev.lib' or { }) // {
        inherit cp ln ln';
      };
    })
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  home.username = user.name;
  home.homeDirectory = user.homeDirectory;

  programs.bash.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';
  };

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
      identityFile = "~/.ssh/id_ed25519";
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

  programs.jujutsu = {
    enable = true;

    settings = {
      user.name = "Chad Norvell";
      user.email = "chadnorvell@pm.me";

      ui.editor = "nvim";
      ui.paginate = "never";

      remotes.origin.auto-track-bookmarks = "*";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    enableJujutsuIntegration = true;
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

    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;

    initLua = ''
      require("cxn")
    '';
  };

  programs.tmux = {
    enable = true;
    extraConfig = cp "tmux/tmux.conf";
  };

  programs.vim = {
    enable = true;
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

  xdg.enable = true;

  xdg.configFile =
    ln "fish" [
      "functions"
      "completions"
    ]
    // ln "fish/conf.d" [
      "abbr.fish"
      "magic_space.fish"
    ]
    // ln "nvim" [
      "lua"
      "ftplugin"
    ];
}
