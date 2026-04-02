{ user, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user.name} = {
      imports = [ ./config.nix ];
      home.username = user.name;
      home.homeDirectory = user.homeDirectory;
    };
  };
}
