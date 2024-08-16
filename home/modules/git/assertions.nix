{ config, ... }:

let cfg = config.Ark.git;
in {
  assertions = [
    {
      assertion = !cfg.enable || cfg.username != null;
      message = ''
        An username address must be provided for git.
        [config.Ark.git.username] :: string
      '';
    }
    {
      assertion = !cfg.enable || cfg.email != null;
      message = ''
        An email address must be provided for git.
        [config.Ark.git.email] :: string
      '';
    }
    {
      assertion = !cfg.signing.enable || (cfg.signing.signKey != null);
      message = ''
        You have enabled signing for git. An Sign key must be provided.
        [config.Ark.git.signing.signKey] :: string
      '';
    }
  ];
}
