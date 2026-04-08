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
    (final: prev: { inherit (forkPkgs) capacities; })
  ];
}
