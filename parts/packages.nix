{
  perSystem = { pkgs, ... }: {
    packages = {
      arkWalls = pkgs.callPackage ../packages/arkWalls { };
      material-discord = pkgs.callPackage ../packages/material-discord { };
    };
  };
}
