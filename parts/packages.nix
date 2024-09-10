{
  perSystem = {pkgs, ...}: {
    packages = {
      arkWalls = pkgs.callPackage ../packages/arkWalls {};
    };
  };
}
