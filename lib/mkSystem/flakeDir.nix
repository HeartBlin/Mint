{ flakeDir, mkOption, nullOr, str, ... }:

{
  options.Mint.flakeDir = mkOption {
    type = nullOr str;
    readOnly = true;
    default = flakeDir;
  };

  config.environment.sessionVariables.FLAKE = flakeDir;
}
