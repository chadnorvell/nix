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

  bat = lib.getExe pkgs.bat;
  eza = lib.getExe pkgs.eza;
  gum = lib.getExe pkgs.gum;
  nvim = lib.getExe pkgs.neovim;
  nvim-qt = lib.getExe pkgs.neovim-qt;
  neovide = lib.getExe pkgs.neovide;
  trash-put = "${pkgs.trash-cli}/bin/trash-put";

  gitBasicAliases = {
    a = "add -A";
    ac = "!f() { git add -A && git commit \"$@\"; }; f";
    aca = "!f() { git add -A && git commit --amend; }; f";
    acaf = "!f() { git add -A && git commit --amend --no-edit; }; f";
    acapf = "!f() { git add -A && git commit --amend --no-edit && git push --force; }; f";
    b = "branch";
    c = "commit";
    ca = "commit --amend";
    caf = "commit --amend --no-edit";
    capf = "!f() { git commit --amend --no-edit && git push --force; }; f";
    cm = "commit -m";
    d = "diff";
    ds = "diff --staged";
    g = "clone";
    h = "checkout";
    hb = "checkout -b";
    pu = "pull";
    puf = "pull --rebase";
    r = "rebase";
    ra = "rebase --abort";
    rc = "rebase --continue";
    ri = "rebase --interactive";
    rq = "rebase --autosquash";
    s = "status";
    up = "push";
    upf = "push --force";
    x = "!f() { git branch --merged | grep -v \"^\*\\|main\" | xargs -n 1 git branch -d; }; f";
    z = "stash";
    zz = "stash -u";
    za = "stash apply";
    zd = "stash drop";
    zl = "stash list";
    zp = "stash pop";
    zs = "stash show";

    l = "log --oneline -10";
    ll = "log --oneline";

    lm = "log main..HEAD --oneline -10";
    llm = "log main..HEAD --oneline";

    lv = "log";
    lvm = "log main..HEAD";

    lt = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
    ltv = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
    ltvv = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";
  };

  gitAliasToShellAliasName =
    name:
    let
      len = builtins.stringLength name;
      rest = builtins.substring 0 (len - 1) name;
      last = builtins.substring (len - 1) 1 name;
    in
    if len > 0 && last == "f" then "g${rest}!" else "g${name}";

  gitAliasToShellAlias = key: value: lib.nameValuePair (gitAliasToShellAliasName key) ("git ${key}");

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

  home.shellAliases = {
    clear = "clear -x";
    cp = "cp -v";
    l = eza;
    la = "${eza} --long --all";
    lg = "${eza} --long --git --git-ignore";
    lga = "${eza} --long --git";
    ll = "${eza} --long";
    ls = "ls --color=auto";
    rm = trash-put;
    rrm = "rm";
  }
  // lib.attrsets.mapAttrs' gitAliasToShellAlias gitBasicAliases;

  programs.bash = {
    enable = true;

    shellAliases = {
      cdl = "cd $@ && ${eza} --long";
      cdla = "cd $@ && ${eza} --long --all";
      cdls = "cd $@ && ${eza} --tree --level=2";
      lt = "{ lvl=\"\${1:-2}\"; [ $# -gt 0 ] && shift; ${eza} --tree --level=\"\$lvl\" \"\$@\"; }";
      mkcd = "mkdir $@ && cd $@";
      nrb = "{ cmd=\"\${1:-switch}\"; shift; sudo nixos-rebuild \"$cmd\" --impure --flake \"${nixDir.root}\" \"$@\"; }";
      nvg = "nohup ${neovide} \"\${1:-.}\" >/dev/null 2>&1 & disown";
      nvgqt = "nohup ${nvim-qt} \"\${1:-.}\" >/dev/null 2>&1 & disown";
      nxd = "nix develop";
      nxs = "nix-shell";
      v = "{ [ -d \"$1\" ] && ${eza} --long \"$1\" || { [ -f \"$1\" ] && ${bat} \"$1\" || echo \"Error: Path '$1' is neither a directory nor a file\"; }; }";
    };
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';

    functions = {
      cdl = "cd $argv && ${eza} --long";
      cdla = "cd $argv && ${eza} --long --all";
      cdls = "cd $argv && ${eza} --tree --level=2";
      mkcd = "mkdir $argv && cd $argv";
      nvg = "set -l p $argv .; ${neovide} $p[1] &>/dev/null &; disown";
      nvgqt = "set -l p $argv .; ${nvim-qt} $p[1] &>/dev/null &; disown";

      lt = ''
        set -q argv[1]; or set argv 2
        ${eza} --tree --level=$argv[1] $argv[2..]
      '';

      v = ''
        set -l p $argv[1]
        set -l cmd (test -d $p; and echo ${eza} --long; or test -f $p; and echo ${bat})
        if test -n "$cmd"; $cmd $p; else; echo "Error: '$p' is neither a file nor a directory"; end
      '';

      nrb = "set -q argv[1]; or set argv switch; sudo nixos-rebuild $argv[1] --impure --flake \"${nixDir.root}\" $argv[2..]";

      nxd = ''
        argparse 'c/command=' -- $argv; or return
        IN_FISH_SUBSHELL=1 nix develop $argv --command fish (set -q _flag_c; and echo -c $_flag_c)
      '';

      nxs = ''
        argparse 'c/command=' -- $argv; or return
        IN_FISH_SUBSHELL=1 nix-shell $argv --command fish (set -q _flag_c; and echo -c $_flag_c)
      '';

    };
  };

  xdg.configFile."fish/functions/fish_prompt.fish".source = ln "fish/functions/fish_prompt.fish";

  xdg.configFile."kitty/kitty.conf".source = ln "kitty/kitty.conf";

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
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

      alias = gitBasicAliases // {
        del-branches = "!git branch | cut -c 3- | ${gum} choose --no-limit | xargs git branch -D";
        fixup-on = "!git log --oneline | ${gum} choose | awk '{print $1}' | xargs git commit --fixup";
        squash-all = "!f() { git reset $(git commit-tree HEAD^{tree} \"$@\"); }; f";
        sync = "!f() { git checkout main && git pull; }; f";
        undo = "!f() { git reset HEAD~1 --mixed; }; f";
        wip = "!f() { git add -A && git commit --no-verify -m '~~WIP~~'; }; f";
      };
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

    initLua = ''
      require("cxn")
    '';
  };

  xdg.configFile."nvim/lua" = {
    source = ln "nvim/lua";
    recursive = true;
  };

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
    enableFishIntegration = true;
    shellWrapperName = "y";

    settings = {
      opener = {
        edit = [
          {
            run = "${nvim} \"$@\"";
            block = true;
          }
        ];
      };
    };
  };
}
