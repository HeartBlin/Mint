{ config, ... }:

let inherit (config.Ark) flakeDir role;
in {
  assertions = [{
    assertion = flakeDir != null || role == "iso";
    message = ''
      Flake location _must_ be specified.
      [config.Ark.flakeDir] :: string
    '';
  }];
}
