{ user, nixDir, ... }:
{
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
