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
    cmake-language-server
    delta
    direnv
    emacs-lsp-booster
    eslint
    eza
    fish-lsp
    gh
    git
    git-lfs
    gum
    kdlfmt
    lua-language-server
    mdformat
    neovim
    neovim-remote
    nil
    nix-direnv
    nixfmt
    pre-commit
    rassumfrassum
    ruff
    shellcheck
    shfmt
    statix
    stylua
    tailwindcss-language-server
    tmux
    trash-cli
    tree-sitter
    vim
    vscode-langservers-extracted
    yaml-language-server
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
