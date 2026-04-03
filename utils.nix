final: prev: {
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
}
