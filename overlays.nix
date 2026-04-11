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
      inherit (forkPkgs) capacities;

      # Utility functions made available to the rest of the config
      lib' = (prev.lib' or { }) // {
        writeShellScriptBin =
          name: script:
          let
            rootDir = prev.writeShellScriptBin name script;
          in
          {
            inherit name rootDir;
            binDir = "${rootDir}/bin";
            binFile = "${rootDir}/bin/${name}";
          };
      };
    })
  ];
}
