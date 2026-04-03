{
  pkgs,
  user,
  nixDir,
  ...
}:
{
  users.users.${user.name}.packages = with pkgs; [
    bat
    btop
    delta
    direnv
    eza
    gum
    git
    git-lfs
    neovim
    neovim-remote
    nix-direnv
    tmux
    trash-cli
    vim
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user.name} = {
      imports = [ (import ./config.nix { inherit user nixDir; }) ];
      home.username = user.name;
      home.homeDirectory = user.homeDirectory;
    };
  };
}
