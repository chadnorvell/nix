{ system, nixpkgs-fork }:
let
  forkPkgs = import nixpkgs-fork {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      # These packages will be overridden by the fork
      # inherit (forkPkgs) ___;
    })
  ];
}
