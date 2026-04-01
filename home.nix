{
  config,
  lib,
  pkgs,
  ...
}:

let
  homeDirectory = config.home.homeDirectory;

  addToPath = [
    "${homeDirectory}/.local/bin"
    "${homeDirectory}/.cargo/bin"
  ];
in
{
  home.stateVersion = "25.11";

  home.sessionPath = [
    "${homeDirectory}/.local/bin"
    "${homeDirectory}/.cargo/bin"
  ];

  home.shellAliases = {
      clear = "command clear -x";
      cp = "command cp -v";
      cz = "chezmoi diff";
      cza = "chezmoi add";
      czz = "chezmoi apply";
      ga = "git add -A";
      gb = "git branch";
      gc = "git commit";
      gca = "git commit --amend";
      "gca!" = "git commit --amend --no-edit";
      gcm = "git commit -m";
      gd = "git diff";
      gds = "git diff --staged";
      gg = "git clone";
      gh = "git checkout";
      ghb = "git checkout -b";
      gpu = "git pull";
      gr = "git rebase";
      gra = "git rebase --abort";
      grc = "git rebase --continue";
      gri = "git rebase -i";
      gs = "git status";
      gup = "git push";
      "gup!" = "git push --force";
      gZ = "git stash";
      gZa = "git stash apply";
      gZd = "git stash drop";
      gZl = "git stash list";
      gZp = "git stash pop";
      gZs = "git stash show";
      l = "eza";
      la = "eza --long --all";
      lg = "eza --long --git --git-ignore";
      lga = "eza --long --git";
      ll = "eza --long";
      ls = "command ls --color=auto";
      rm = "trash-put";
      rrm = "command rm";
  };

  systemd.user.sessionVariables = {
    EDITOR = "nvim";
    GOPATH = "${homeDirectory}/pkg/go";
    MAKEFLAGS = "-j20";
    npm_config_prefix = "${homeDirectory}/.local";
    PATH = lib.strings.concatStringsSep ":" addToPath + ":$PATH";
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${homeDirectory}/top";
    documents = "${homeDirectory}/docs";
    download = "${homeDirectory}/inbox";
    music = "${homeDirectory}/media/music";
    pictures = "${homeDirectory}/media/images";
    publicShare = "${homeDirectory}/pub";
    templates = "${homeDirectory}/docs/templates";
    videos = "${homeDirectory}/media/videos";
  };
}
