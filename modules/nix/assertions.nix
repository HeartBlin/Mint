{ config, ... }:

let flakeDir = config.Ark.flakeDir;
in {
  assertions = [{
    assertion = flakeDir != null;
    message = ''
      Flake location _must_ be specified.
      [config.Ark.flakeDir] :: string
    '';
  }];
}
